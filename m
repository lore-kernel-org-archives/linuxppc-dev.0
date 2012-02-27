Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C804B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 12:50:12 +1100 (EST)
Message-ID: <1330307396.20389.67.camel@pasglop>
Subject: Re: [PATCH/RFC] rapidio: temporarily exclude FSL_RIO from 64 bit
 builds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@gmail.com>
Date: Mon, 27 Feb 2012 12:49:56 +1100
In-Reply-To: <CAP=VYLroaEKncpy7VBobJdXijnDS5UdTV7qPG2A--SicnGvFSg@mail.gmail.com>
References: <1329865853-17277-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLroaEKncpy7VBobJdXijnDS5UdTV7qPG2A--SicnGvFSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Gang.Liu@freescale.com, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-02-26 at 20:26 -0500, Paul Gortmaker wrote:
> Hi Ben,
> 
> Given a week has passed with the absence of any feedback
> with respect to SRIO on 64 bit, are you OK with applying the
> below patch[1] pretty much as-is?

It can't hurt, I'll put it in. That's normally Kumar's side of things
but then with him leaving FSL things are a bit in flux right now.

Cheers,
Ben.

> Thanks,
> Paul.
> 
> [1] http://patchwork.ozlabs.org/patch/142383/
> 
> ---
> 
> On Tue, Feb 21, 2012 at 6:10 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > The following are seen while using the corenet64_smp_defconfig:
> >
> > arch/powerpc/sysdev/fsl_rmu.c:315: error: cast from pointer to integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:330: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:332: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:339: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:340: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:341: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:659: error: cast from pointer to integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:659: error: format '%8.8x' expects type 'unsigned int', but argument 5 has type 'size_t'
> > arch/powerpc/sysdev/fsl_rmu.c:985: error: cast from pointer to integer of different size
> > arch/powerpc/sysdev/fsl_rmu.c:997: error: cast to pointer from integer of different size
> >
> > A quick inspection of the code leaves one with the impression
> > that it was not explicitly written with 64 bit support in mind,
> > so just block that as a possible config selection for now.
> >
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> >
> > ---
> >
> > [This is seen in linux-next -- not sure if this is the right way to go
> >  but at least it will give the issue some visibility to the right ppl.]
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 75f061e..5ad8013 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -773,7 +773,7 @@ config RAPIDIO
> >
> >  config FSL_RIO
> >        bool "Freescale Embedded SRIO Controller support"
> > -       depends on RAPIDIO && HAS_RAPIDIO
> > +       depends on RAPIDIO && HAS_RAPIDIO && (BROKEN || !PPC64)
> >        default "n"
> >        ---help---
> >          Include support for RapidIO controller on Freescale embedded
> > --
> > 1.7.9.1
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
