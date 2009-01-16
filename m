Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B8DEDDFE6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 22:41:58 +1100 (EST)
Date: Fri, 16 Jan 2009 14:41:56 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1328000796.20090116144156@emcraft.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re[2]: [PATCH 02/11][v3] async_tx: add support for asynchronous GF
	multiplication
In-Reply-To: <e9c3a7c20901141656g2fec1802vcecc4ae433838bb3@mail.gmail.com>
References: <200901130343.06895.yur@emcraft.com>
	<e9c3a7c20901141656g2fec1802vcecc4ae433838bb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Dan,

 Thanks for review. Some comments below.

On Thursday, January 15, 2009 you wrote:

[..]

>> +/**
>> + * do_async_pq - asynchronously calculate P and/or Q
>> + */
>> +static struct dma_async_tx_descriptor *
>> +do_async_pq(struct dma_chan *chan, struct page **blocks, unsigned char =
*scfs,
>> +       unsigned int offset, int src_cnt, size_t len, enum async_tx_flag=
s flags,
>> +       struct dma_async_tx_descriptor *depend_tx,
>> +       dma_async_tx_callback cb_fn, void *cb_param)
>> +{
>> +       struct dma_device *dma =3D chan->device;
>> +       dma_addr_t dma_dest[2], dma_src[src_cnt];
>> +       struct dma_async_tx_descriptor *tx =3D NULL;
>> +       dma_async_tx_callback _cb_fn;
>> +       void *_cb_param;
>> +       unsigned char *scf =3D NULL;
>> +       int i, src_off =3D 0;
>> +       unsigned short pq_src_cnt;
>> +       enum async_tx_flags async_flags;
>> +       enum dma_ctrl_flags dma_flags =3D 0;
>> +
>> +       /*  If we won't handle src_cnt in one shot, then the following
>> +        * flag(s) will be set only on the first pass of prep_dma
>> +        */
>> +       if (flags & ASYNC_TX_PQ_ZERO_P)
>> +               dma_flags |=3D DMA_PREP_ZERO_P;
>> +       if (flags & ASYNC_TX_PQ_ZERO_Q)
>> +               dma_flags |=3D DMA_PREP_ZERO_Q;
>> +
>> +       /* DMAs use destinations as sources, so use BIDIRECTIONAL mappin=
g */
>> +       if (blocks[src_cnt]) {
>> +               dma_dest[0] =3D dma_map_page(dma->dev, blocks[src_cnt],
>> +                                          offset, len, DMA_BIDIRECTIONA=
L);
>> +               dma_flags |=3D DMA_PREP_HAVE_P;
>> +       }
>> +       if (blocks[src_cnt+1]) {
>> +               dma_dest[1] =3D dma_map_page(dma->dev, blocks[src_cnt+1],
>> +                                          offset, len, DMA_BIDIRECTIONA=
L);
>> +               dma_flags |=3D DMA_PREP_HAVE_Q;
>> +       }
>> +
>> +       for (i =3D 0; i < src_cnt; i++)
>> +               dma_src[i] =3D dma_map_page(dma->dev, blocks[i],
>> +                                         offset, len, DMA_TO_DEVICE);
>> +
>> +       while (src_cnt) {
>> +               async_flags =3D flags;
>> +               pq_src_cnt =3D min(src_cnt, (int)dma->max_pq);
>> +               /* if we are submitting additional pqs, leave the chain =
open,
>> +                * clear the callback parameters, and leave the destinat=
ion
>> +                * buffers mapped
>> +                */
>> +               if (src_cnt > pq_src_cnt) {
>> +                       async_flags &=3D ~ASYNC_TX_ACK;
>> +                       dma_flags |=3D DMA_COMPL_SKIP_DEST_UNMAP;
>> +                       _cb_fn =3D NULL;
>> +                       _cb_param =3D NULL;
>> +               } else {
>> +                       _cb_fn =3D cb_fn;
>> +                       _cb_param =3D cb_param;
>> +               }
>> +               if (_cb_fn)
>> +                       dma_flags |=3D DMA_PREP_INTERRUPT;
>> +               if (scfs)
>> +                       scf =3D &scfs[src_off];
>> +
>> +               /* Since we have clobbered the src_list we are committed
>> +                * to doing this asynchronously.  Drivers force forward
>> +                * progress in case they can not provide a descriptor
>> +                */
>> +               tx =3D dma->device_prep_dma_pq(chan, dma_dest,
>> +                                            &dma_src[src_off], pq_src_c=
nt,
>> +                                            scf, len, dma_flags);
>> +               if (unlikely(!tx))
>> +                       async_tx_quiesce(&depend_tx);
>> +
>> +               /* spin wait for the preceeding transactions to complete=
 */
>> +               while (unlikely(!tx)) {
>> +                       dma_async_issue_pending(chan);
>> +                       tx =3D dma->device_prep_dma_pq(chan, dma_dest,
>> +                                       &dma_src[src_off], pq_src_cnt,
>> +                                       scf, len, dma_flags);
>> +               }
>> +
>> +               async_tx_submit(chan, tx, async_flags, depend_tx,
>> +                               _cb_fn, _cb_param);
>> +
>> +               depend_tx =3D tx;
>> +               flags |=3D ASYNC_TX_DEP_ACK;
>> +
>> +               if (src_cnt > pq_src_cnt) {
>> +                       /* drop completed sources */
>> +                       src_cnt -=3D pq_src_cnt;
>> +                       src_off +=3D pq_src_cnt;
>> +
>> +                       /* use the intermediate result as a source; we
>> +                        * clear DMA_PREP_ZERO, so prep_dma_pq will
>> +                        * include destination(s) into calculations. Thus
>> +                        * keep DMA_PREP_HAVE_x in dma_flags only
>> +                        */
>> +                       dma_flags &=3D (DMA_PREP_HAVE_P | DMA_PREP_HAVE_=
Q);

> I don't think this will work as we will be mixing Q into the new P and
> P into the new Q.  In order to support (src_cnt > device->max_pq) we
> need to explicitly tell the driver that the operation is being
> continued (DMA_PREP_CONTINUE) and to apply different coeffeicients to
> P and Q to cancel the effect of including them as sources.

 With DMA_PREP_ZERO_P/Q approach, the Q isn't mixed into new P, and P=20
isn't mixed into new Q. For your example of max_pq=3D4:

 p, q =3D PQ(src0, src1, src2, src3, src4, COEF({01}, {02}, {04}, {08}, {10=
}))

 with the current implementation will be split into:

 p, q =3D PQ(src0, src1, src2, src3, COEF({01}, {02}, {04}, {08})
 p`,q` =3D PQ(src4, COEF({10}))

 which will result to the following:

 p =3D ((dma_flags & DMA_PREP_ZERO_P) ? 0 : old_p) + src0 + src1 + src2 + s=
rc3
 q =3D ((dma_flags & DMA_PREP_ZERO_Q) ? 0 : old_q) + {01}*src0 + {02}*src1 =
+ {04}*src2 + {08}*src3
=20
 p` =3D p + src4
 q` =3D q + {10}*src4

 But, if we get rid of DMA_PREP_ZERO_P/Q, then the mess with P/Q will=20
have a place indeed.

>  Here is an
> example of supporting a 5 source pq operation where max_pq =3D=3D 4 (the
> minimum).

>     p, q =3D PQ(src0, src1, src2, src3, COEF({01}, {02}, {04}, {08}))
>     p', q' =3D PQ(p, q, q, src4, COEF({00}, {01}, {00}, {10}))

>     p' =3D p + q + q + src4 =3D p + src4 =3D P
>     q' =3D {00}*p + {01}*q + {00}*q + {10}*src4 =3D q + {10)*src4 =3D Q

> ...at no point do we need to zero P or Q.  Yes, this requires a lot of
> extra work for incremental sources,

 I would say, that 'very very lot'. In general this means that for=20
the cases of N sources > max_pq we'll have to do:

 C =3D 1 + ceil((N-max_pq)/(max_pq - 3)) number of calls to ADMA.

 E.g., for max_pq =3D 4:

 N =3D 5 =3D> C =3D 2,
 N =3D 6 =3D> C =3D 3,
 ..
 N =3D 15 =3D> C =3D 12,
 N =3D 16 =3D> C =3D 13,
 ..
 N =3D 128 =3D> C =3D 125.


 If we stay with the current approach of using DMA_PREP_ZERO_P/Q, then

 C =3D 1 + ceil((N-max_pq)/max_pq)) number of calls to ADMA.

 And the same series will result to:

 N =3D 5 =3D> C =3D 2,
 N =3D 6 =3D> C =3D 2,
 ..
 N =3D 15 =3D> C =3D 4,
 N =3D 16 =3D> C =3D 4,
 ..
 N =3D 128 =3D> C =3D 32.


 I'm afraid that the difference (13/4, 125/32) is very significant, so=20
getting rid of DMA_PREP_ZERO_P/Q will eat most of the improvement=20
which could be achieved with the current approach.

>  but at this point I do not see a cleaner alternatve for engines like iop=
13xx.

 I can't find any description of iop13xx processors at Intel's=20
web-site, only 3xx:

http://www.intel.com/design/iio/index.htm?iid=3Dipp_embed+embed_io

 So, it's hard for me to do any suggestions. I just wonder - doesn't=20
iop13xx allow users to program destination addresses into the sources=20
fields of descriptors?

>> +               } else
>> +                       break;
>> +       }
>> +
>> +       return tx;
>> +}
>> +
>> +/**
>> + * do_sync_pq - synchronously calculate P and Q
>> + */
>> +static void
>> +do_sync_pq(struct page **blocks, unsigned char *scfs, unsigned int offs=
et,
>> +       int src_cnt, size_t len, enum async_tx_flags flags,
>> +       struct dma_async_tx_descriptor *depend_tx,
>> +       dma_async_tx_callback cb_fn, void *cb_param)
>> +{
>> +       int i, pos;
>> +       uint8_t *p =3D NULL, *q =3D NULL, *src;
>> +
>> +       /* set destination addresses */
>> +       if (blocks[src_cnt])
>> +               p =3D (uint8_t *)(page_address(blocks[src_cnt]) + offset=
);
>> +       if (blocks[src_cnt+1])
>> +               q =3D (uint8_t *)(page_address(blocks[src_cnt+1]) + offs=
et);
>> +
>> +       if (flags & ASYNC_TX_PQ_ZERO_P) {
>> +               BUG_ON(!p);
>> +               memset(p, 0, len);
>> +       }
>> +
>> +       if (flags & ASYNC_TX_PQ_ZERO_Q) {
>> +               BUG_ON(!q);
>> +               memset(q, 0, len);
>> +       }
>> +
>> +       for (i =3D 0; i < src_cnt; i++) {
>> +               src =3D (uint8_t *)(page_address(blocks[i]) + offset);
>> +               for (pos =3D 0; pos < len; pos++) {
>> +                       if (p)
>> +                               p[pos] ^=3D src[pos];
>> +                       if (q)
>> +                               q[pos] ^=3D raid6_gfmul[scfs[i]][src[pos=
]];
>> +               }
>> +       }
>> +       async_tx_sync_epilog(cb_fn, cb_param);
>> +}

> sync_pq like sync_gensyndrome should not care about the current
> contents of p and q, just regenerate from the current sources.  This
> kills another site where ASYNC_TX_PQ_ZERO_{P,Q} is used.

 Well, perhaps you are right. The ASYNC_TX_PQ_ZERO_{P,Q} is set for=20
the most common cases of using async_pq, i.e. the parity generating.=20
The wrap-around async_gen_syndrome() function always set these flags=20
before calling async_pq().

 The cases where ASYNC_TX_PQ_ZERO_{P,Q} isn't set are:

(a) async_pq can't process the sources in one short because of src_cnt >=20
max_pq, so it should re-use the intermediate results (destination) as=20
the sources;

(b) async_r6_dd_recov() does XOR with async_pq() assuming re-using the=20
destination as the source.


 So, I would say that ASYNC_TX_PQ_ZERO_{P,Q} should definitely go=20
away, if there were no significant overheads in (a) implemented=20
without these flags (see above).

>> +
>> +/**
>> + * async_pq - attempt to do XOR and Galois calculations in parallel usi=
ng
>> + *     a dma engine.
>> + * @blocks: source block array from 0 to (src_cnt-1) with the p destina=
tion
>> + *     at blocks[src_cnt] and q at blocks[src_cnt + 1]. Only one of two
>> + *     destinations may be present (another then has to be set to NULL).
>> + *     By default, the result of calculations is XOR-ed with the initial
>> + *     content of the destinationa buffers. Use ASYNC_TX_PQ_ZERO_x flags
>> + *     to avoid this.
>> + *     NOTE: client code must assume the contents of this array are des=
troyed
>> + * @scfs: array of source coefficients used in GF-multiplication
>> + * @offset: offset in pages to start transaction
>> + * @src_cnt: number of source pages
>> + * @len: length in bytes
>> + * @flags: ASYNC_TX_PQ_ZERO_P, ASYNC_TX_PQ_ZERO_Q, ASYNC_TX_ASSUME_COHE=
RENT,
>> + *     ASYNC_TX_ACK, ASYNC_TX_DEP_ACK, ASYNC_TX_ASYNC_ONLY
>> + * @depend_tx: depends on the result of this transaction.
>> + * @cb_fn: function to call when the operation completes
>> + * @cb_param: parameter to pass to the callback routine
>> + */
>> +struct dma_async_tx_descriptor *
>> +async_pq(struct page **blocks, unsigned char *scfs, unsigned int offset,
>> +       int src_cnt, size_t len, enum async_tx_flags flags,
>> +       struct dma_async_tx_descriptor *depend_tx,
>> +       dma_async_tx_callback cb_fn, void *cb_param)
>> +{
>> +       struct dma_chan *chan =3D async_tx_find_channel(depend_tx, DMA_P=
Q,
>> +                                       &blocks[src_cnt], 2,
>> +                                       blocks, src_cnt, len);
>> +       struct dma_device *device =3D chan ? chan->device : NULL;
>> +       struct dma_async_tx_descriptor *tx =3D NULL;
>> +
>> +       if (!device && (flags & ASYNC_TX_ASYNC_ONLY))
>> +               return NULL;
>> +
>> +       if (device) {
>> +               /* run pq asynchronously */
>> +               tx =3D do_async_pq(chan, blocks, scfs, offset, src_cnt,
>> +                       len, flags, depend_tx, cb_fn,cb_param);
>> +       } else {
>> +               /* run pq synchronously */
>> +               if (!blocks[src_cnt+1]) {
>> +                       struct page *pdst =3D blocks[src_cnt];
>> +                       int i;
>> +
>> +                       /* Calculate P-parity only.
>> +                        * As opposite to async_xor(), async_pq() assumes
>> +                        * that destinations are included into calculati=
ons,
>> +                        * so we should re-arrange the xor src list to
>> +                        * achieve the similar behavior.
>> +                        */
>> +                       if (!(flags & ASYNC_TX_PQ_ZERO_P)) {
>> +                               /* If async_pq() user doesn't set ZERO f=
lag,
>> +                                * it's assumed that destination has some
>> +                                * reasonable data to include in calcula=
tions.
>> +                                * The destination must be at position 0=
, so
>> +                                * shift the sources and put pdst at the
>> +                                * beginning of the list.
>> +                                */
>> +                               for (i =3D src_cnt - 1; i >=3D 0; i--)
>> +                                       blocks[i+1] =3D blocks[i];
>> +                               blocks[0] =3D pdst;
>> +                               src_cnt++;
>> +                               flags |=3D ASYNC_TX_XOR_DROP_DST;
>> +                       } else {
>> +                               /* If async_pq() user want to clear P, t=
hen
>> +                                * this will be done automatically in as=
ync
>> +                                * case, and with the help of ZERO_DST in
>> +                                * the sync one.
>> +                                */
>> +                               flags &=3D ~ASYNC_TX_PQ_ZERO_P;
>> +                               flags |=3D ASYNC_TX_XOR_ZERO_DST;
>> +                       }
>> +
>> +                       return async_xor(pdst, blocks, offset,
>> +                                        src_cnt, len, flags, depend_tx,
>> +                                        cb_fn, cb_param);

> If we assume that async_pq always regenerates parity and never reuses
> the old value then we can get gid of the !(flags & ASYNC_TX_PQ_ZERO_P)
> path.  In the case where code does need to reuse the old P,
> async_r6recov.c, it should call async_xor directly since that routine
> provides this semantic.

 Right. The question is - will we get rid of ZERO_P/Q or not.

[..]

>> @@ -81,14 +81,28 @@ enum dma_transaction_type {
>>  *     dependency chains
>>  * @DMA_COMPL_SKIP_SRC_UNMAP - set to disable dma-unmapping the source b=
uffer(s)
>>  * @DMA_COMPL_SKIP_DEST_UNMAP - set to disable dma-unmapping the destina=
tion(s)
>> + * @DMA_PREP_HAVE_P - set if the destination list includes the correct
>> + *     address of P (P-parity should be handled)
>> + * @DMA_PREP_HAVE_Q - set if the destination list includes the correct
>> + *     address of Q (Q-parity should be handled)
>> + * @DMA_PREP_ZERO_P - set if P has to be zeroed before proceeding
>> + * @DMA_PREP_ZERO_Q - set if Q has to be zeroed before proceeding
>>  */
>>  enum dma_ctrl_flags {
>>        DMA_PREP_INTERRUPT =3D (1 << 0),
>>        DMA_CTRL_ACK =3D (1 << 1),
>>        DMA_COMPL_SKIP_SRC_UNMAP =3D (1 << 2),
>>        DMA_COMPL_SKIP_DEST_UNMAP =3D (1 << 3),
>> +
>> +       DMA_PREP_HAVE_P =3D (1 << 4),
>> +       DMA_PREP_HAVE_Q =3D (1 << 5),
>> +       DMA_PREP_ZERO_P =3D (1 << 6),
>> +       DMA_PREP_ZERO_Q =3D (1 << 7),
>>  };
>>
>> +#define DMA_PCHECK_FAILED      (1 << 0)
>> +#define DMA_QCHECK_FAILED      (1 << 1)

> Perhaps turn these into an enum such that we can pass around a enum
> pq_check_flags pointer rather than a non-descript u32 *.

 Agree.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
