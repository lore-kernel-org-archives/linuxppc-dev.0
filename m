Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 624C21A2B02
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 21:07:40 +1000 (AEST)
Date: Wed, 9 Sep 2015 21:07:39 +1000
From: Anton Blanchard <anton@samba.org>
To: Simon Horman <horms@verge.net.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to
 big-endian
Message-ID: <20150909210739.419a4f72@kryten>
In-Reply-To: <20150902010251.GC30886@verge.net.au>
References: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
 <20150902010251.GC30886@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Horms,

> > Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> > meaning if we kexec from a little-endian kernel the target kernel
> > will fail to boot.
> > Returning to big-endian before we enter the target kernel ensures
> > that the target kernel can boot whether or not it includes
> > FIXUP_ENDIAN.
> > 
> > This mirrors commit 150b14e7 in kexec-lite.
> > 
> > Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> 
> I would value a review from one of the PPC folks.

Looks good to me. You can add:

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> > ---
> >  purgatory/arch/ppc64/v2wrap.S | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/purgatory/arch/ppc64/v2wrap.S
> > b/purgatory/arch/ppc64/v2wrap.S index dc5034f..179ade9 100644
> > --- a/purgatory/arch/ppc64/v2wrap.S
> > +++ b/purgatory/arch/ppc64/v2wrap.S
> > @@ -114,10 +114,16 @@ master:
> >  	LOADADDR(6,run_at_load) # the load flag
> >  	lwz	7,0(6)		# possibly patched by
> > kexec-elf-ppc64 stw	7,0x5c(4)	# and patch it into the
> > kernel
> > -	li	5,0		# r5 will be 0 for kernel
> > -	mtctr	4		# prepare branch too
> >  	mr      3,16            # restore dt address
> >  
> > +	mtsrr0	4		# prepare branch to
> > +
> > +	mfmsr	5
> > +	clrrdi	5,5,1		# clear MSR_LE
> > +	mtsrr1	5
> > +
> > +	li	5,0		# r5 will be 0 for kernel
> > +
> >  				# skip cache flush, do we care?
> >  
> > -	bctr			# start kernel
> > +	rfid			# update MSR and start kernel
> > -- 
> > 2.5.0
> > 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
