From: Ryan Nielsen <ran@krazynet.com>
Date: Mon, 25 Oct 1999 22:29:05 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991025222905.A32256@gondolin.asf>
References: <19991011154325.A14359@HSE-MTL-ppp4363.qc.sympatico.ca> <Pine.LNX.4.10.9910111308380.802-100000@opus.bloom.county> <19991011200346.A258@gondolin.asf> <19991014193940.A1143@HSE-MTL-ppp4505.qc.sympatico.ca> <19991017190502.A13068@gondolin.asf> <19991023152110.A525@HSE-MTL-ppp4445.qc.sympatico.ca> <19991023203334.A26715@gondolin.asf> <19991024223141.A758@HSE-MTL-ppp4328.qc.sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991024223141.A758@HSE-MTL-ppp4328.qc.sympatico.ca>; from dorland@lords.com on Sun, Oct 24, 1999 at 10:31:41 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eric Dorland wrote:
> On Sat, Oct 23, 1999 at 08:33:34PM -0700, Ryan Nielsen wrote:
> > Eric Dorland wrote:
> > > I finally had the chance to recompile my kernel and try your patch, which so
> > > far is working flawlessly. The only bug i've noticed is that regular beeps
> > > sound slightly clipped. You should post the patch to the list if you haven't
> > > already done so :)
> > 
> > does it fix the esound problem ?
> 
> It does indeed.
>  
> > I posted it to the list before but noone replied except for one saying it broke
> > a workaround for a bug, search the dev list at lists.linuxppc.org for 'dmasound bug'.
> 
> Yes, there is a bit of a hissing, but I find the hissing is only noticable
> at really high volumes, on my G3, so it doesn't bother me at all.

can someone fix that hissing problem and get this patch into the kernel ?
diff -u -r1.41.2.2 dmasound.c
--- dmasound.c	1999/08/16 01:58:47	1.41.2.2
+++ dmasound.c	1999/10/25 22:15:23
@@ -3169,9 +3169,9 @@
 	if (beep_playing) {
 		/* sound takes precedence over beeps */
 		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
-		out_le32(&awacs->control,
-			 (in_le32(&awacs->control) & ~0x1f00)
-			 || (awacs_rate_index << 8));
+		out_le32(&awacs->control, MASK_IEPC
+			 | (awacs_rate_index << 8) | 0x11
+			 | (awacs_revision < AWACS_BURGUNDY? MASK_IEE: 0));
 		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
 		beep_playing = 0;
 	}
@@ -3259,6 +3259,11 @@
 	save_flags(flags); cli();
 	if (beep_playing) {
 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
+		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
+		out_le32(&awacs->control, MASK_IEPC
+			 | (awacs_rate_index << 8) | 0x11
+			 | (awacs_revision < AWACS_BURGUNDY? MASK_IEE: 0));
+		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
 		beep_playing = 0;
 	}
 	restore_flags(flags);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
