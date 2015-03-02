Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5620A1A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 08:44:29 +1100 (AEDT)
Date: Mon, 2 Mar 2015 16:44:19 -0500
From: Martin Hicks <mort@bork.org>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>
Subject: Re: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
Message-ID: <20150302214419.GA30523@darwin.bork.org>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <54F464E4.8080204@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54F464E4.8080204@freescale.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Martin Hicks <mort@bork.org>,
 linux-crypto@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Milan Broz <gmazyland@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 02, 2015 at 03:25:56PM +0200, Horia Geantă wrote:
> On 2/20/2015 7:00 PM, Martin Hicks wrote:
> > This adds the AES-XTS mode, supported by the Freescale SEC 3.3.2.
> > 
> > One of the nice things about this hardware is that it knows how to deal
> > with encrypt/decrypt requests that are larger than sector size, but that 
> > also requires that that the sector size be passed into the crypto engine
> > as an XTS cipher context parameter.
> > 
> > When a request is larger than the sector size the sector number is
> > incremented by the talitos engine and the tweak key is re-calculated
> > for the new sector.
> > 
> > I've tested this with 256bit and 512bit keys (tweak and data keys of 128bit
> > and 256bit) to ensure interoperability with the software AES-XTS
> > implementation.  All testing was done using dm-crypt/LUKS with
> > aes-xts-plain64.
> > 
> > Is there a better solution that just hard coding the sector size to
> > (1<<SECTOR_SHIFT)?  Maybe dm-crypt should be modified to pass the
> > sector size along with the plain/plain64 IV to an XTS algorithm?
> 
> AFAICT, SW implementation of xts mode in kernel (crypto/xts.c) is not
> aware of a sector size ("data unit size" in IEEE P1619 terminology):
> There's a hidden assumption that all the data send to xts in one request
> belongs to a single sector. Even more, it's supposed that the first
> 16-byte block in the request is "block 0" in the sector. These can be
> seen from the way the tweak ("T") value is computed.
> (Side note: there's no support of ciphertext stealing in crypto/xts.c -
> i.e. sector sizes must be a multiple of underlying block cipher size -
> that is 16B.)
> 
> If dm-crypt would be modified to pass sector size somehow, all in-kernel
> xts implementations would have to be made aware of the change.
> I have nothing against this, but let's see what crypto maintainers have
> to say...

Right.  Additionally, there may be some requirement for the encryption
implementation to broadcast the maximum size that can be handled in a single
request.  For example Talitos could handle XTS encrypt/decrypt requests of
up to 64kB (regardless of the block device's sector size).

> BTW, there were some discussions back in 2013 wrt. being able to
> configure / increase sector size, smth. crypto engines would benefit from:
> http://www.saout.de/pipermail/dm-crypt/2013-January/003125.html
> (experimental patch)
> http://www.saout.de/pipermail/dm-crypt/2013-March/003202.html
> 
> The experimental patch sends sector size as the req->nbytes - hidden
> assumption: data size sent in an xts crypto request equals a sector.

I found this last week, and used it as a starting point for some testing.  I
modified it to keep the underlying sector size of the dm-crypt mapping as
512byte, but allowed the code to combine requests in IOs up to 4kB.  Doing
greater request sizes would require allocating additional pages...I plan to
implement that to see how much extra performance can be squeezed out.

patch below...

With regards to performance, with my low-powered Freescale P1022 board, I see
performance numbers like this on ext4, as measured by bonnie++.

			Write (MB/s)	Read (MB/s)
Unencrypted		140		176
aes-xts-plain64 512b	113		115
aes-xts-plain64 4kB	71		56

The more detailed bonnie++ output is here:
http://www.bork.org/~mort/dm-crypt-enc-blksize.html

The larger IO sizes is a huge win for this board.

The patch I'm using to send IOs up to 4kB to talitos follows.

Thanks,
mh


diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 08981be..88e95b5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -42,6 +42,7 @@ struct convert_context {
 	struct bvec_iter iter_out;
 	sector_t cc_sector;
 	atomic_t cc_pending;
+	unsigned int block_size;
 	struct ablkcipher_request *req;
 };
 
@@ -142,6 +143,8 @@ struct crypt_config {
 	sector_t iv_offset;
 	unsigned int iv_size;
 
+	unsigned int block_size;
+
 	/* ESSIV: struct crypto_cipher *essiv_tfm */
 	void *iv_private;
 	struct crypto_ablkcipher **tfms;
@@ -801,10 +804,17 @@ static void crypt_convert_init(struct crypt_config *cc,
 {
 	ctx->bio_in = bio_in;
 	ctx->bio_out = bio_out;
-	if (bio_in)
+	ctx->block_size = 0;
+	if (bio_in) {
 		ctx->iter_in = bio_in->bi_iter;
-	if (bio_out)
+		ctx->block_size = max(ctx->block_size, bio_cur_bytes(bio_in));
+	}
+	if (bio_out) {
 		ctx->iter_out = bio_out->bi_iter;
+		ctx->block_size = max(ctx->block_size, bio_cur_bytes(bio_out));
+	}
+	if (ctx->block_size > cc->block_size)
+		ctx->block_size = cc->block_size;
 	ctx->cc_sector = sector + cc->iv_offset;
 	init_completion(&ctx->restart);
 }
@@ -844,15 +854,15 @@ static int crypt_convert_block(struct crypt_config *cc,
 	dmreq->iv_sector = ctx->cc_sector;
 	dmreq->ctx = ctx;
 	sg_init_table(&dmreq->sg_in, 1);
-	sg_set_page(&dmreq->sg_in, bv_in.bv_page, 1 << SECTOR_SHIFT,
+	sg_set_page(&dmreq->sg_in, bv_in.bv_page, ctx->block_size,
 		    bv_in.bv_offset);
 
 	sg_init_table(&dmreq->sg_out, 1);
-	sg_set_page(&dmreq->sg_out, bv_out.bv_page, 1 << SECTOR_SHIFT,
+	sg_set_page(&dmreq->sg_out, bv_out.bv_page, ctx->block_size,
 		    bv_out.bv_offset);
 
-	bio_advance_iter(ctx->bio_in, &ctx->iter_in, 1 << SECTOR_SHIFT);
-	bio_advance_iter(ctx->bio_out, &ctx->iter_out, 1 << SECTOR_SHIFT);
+	bio_advance_iter(ctx->bio_in, &ctx->iter_in, ctx->block_size);
+	bio_advance_iter(ctx->bio_out, &ctx->iter_out, ctx->block_size);
 
 	if (cc->iv_gen_ops) {
 		r = cc->iv_gen_ops->generator(cc, iv, dmreq);
@@ -861,7 +871,7 @@ static int crypt_convert_block(struct crypt_config *cc,
 	}
 
 	ablkcipher_request_set_crypt(req, &dmreq->sg_in, &dmreq->sg_out,
-				     1 << SECTOR_SHIFT, iv);
+				     ctx->block_size, iv);
 
 	if (bio_data_dir(ctx->bio_in) == WRITE)
 		r = crypto_ablkcipher_encrypt(req);
@@ -926,13 +936,13 @@ static int crypt_convert(struct crypt_config *cc,
 			/* fall through*/
 		case -EINPROGRESS:
 			ctx->req = NULL;
-			ctx->cc_sector++;
+			ctx->cc_sector += ctx->block_size / (1<<SECTOR_SHIFT);
 			continue;
 
 		/* sync */
 		case 0:
 			atomic_dec(&ctx->cc_pending);
-			ctx->cc_sector++;
+			ctx->cc_sector += ctx->block_size / (1<<SECTOR_SHIFT);
 			cond_resched();
 			continue;
 
@@ -1814,6 +1824,9 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad;
 	}
 
+	/* PAGE_SIZE? */
+	cc->block_size = 4096;
+
 	ti->num_flush_bios = 1;
 	ti->discard_zeroes_data_unsupported = true;
 
@@ -1974,9 +1987,16 @@ static int crypt_iterate_devices(struct dm_target *ti,
 	return fn(ti, cc->dev, cc->start, ti->len, data);
 }
 
+static void crypt_io_hints(struct dm_target *ti,
+                           struct queue_limits *limits)
+{
+	/* PAGE_SIZE? */
+	blk_limits_io_min(limits, 4096);
+}
+
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version = {1, 13, 0},
+	.version = {1, 14, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
@@ -1988,6 +2008,7 @@ static struct target_type crypt_target = {
 	.message = crypt_message,
 	.merge  = crypt_merge,
 	.iterate_devices = crypt_iterate_devices,
+	.io_hints = crypt_io_hints,
 };
 
 static int __init dm_crypt_init(void)

-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
