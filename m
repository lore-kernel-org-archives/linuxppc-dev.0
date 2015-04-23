Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04F0D1A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:37:56 +1000 (AEST)
Message-ID: <1429763875.4672.5.camel@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/vdso: Disable building the 32-bit VDSO on
 little endian
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Apr 2015 14:37:55 +1000
In-Reply-To: <20150423130621.19d74dfb@canb.auug.org.au>
References: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
 <1429681236-11644-3-git-send-email-mpe@ellerman.id.au>
 <20150423130621.19d74dfb@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-23 at 13:06 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Wed, 22 Apr 2015 15:40:36 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
> > index c53f5f6d1761..f455adb471e7 100644
> > --- a/arch/powerpc/include/asm/vdso.h
> > +++ b/arch/powerpc/include/asm/vdso.h
> > @@ -19,6 +19,7 @@
> >  
> >  /* Offsets relative to thread->vdso_base */
> >  extern unsigned long vdso64_rt_sigtramp;
> > +
> >  extern unsigned long vdso32_sigtramp;
> >  extern unsigned long vdso32_rt_sigtramp;
> 
> You could drop this hunk :-)

Darn it.

> > diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> > index 8331d0bef0fb..c2bd45187315 100644
> > --- a/arch/powerpc/kernel/vdso.c
> > +++ b/arch/powerpc/kernel/vdso.c
> > @@ -49,12 +49,15 @@
> >  /* The alignment of the vDSO */
> >  #define VDSO_ALIGNMENT	(1 << 16)
> >  
> > -extern char vdso32_start, vdso32_end;
> > -static void *vdso32_kbase = &vdso32_start;
> >  static unsigned int vdso32_pages;
> > +static void *vdso32_kbase;
> >  static struct page **vdso32_pagelist;
> > -unsigned long vdso32_sigtramp;
> > -unsigned long vdso32_rt_sigtramp;
> > +unsigned long vdso32_sigtramp = 0;
> > +unsigned long vdso32_rt_sigtramp = 0;
> 
> And they should be zero anyway, right?

Yeah I guess, I wanted to be sure :)

cheers
