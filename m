Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A909B1A0245
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 10:27:12 +1000 (AEST)
Message-ID: <1429662432.15241.1.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: Little endian should depend on PPC64
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 22 Apr 2015 10:27:12 +1000
In-Reply-To: <1429641183.4352.108.camel@freescale.com>
References: <1429609312-32638-1-git-send-email-mpe@ellerman.id.au>
 <1429641183.4352.108.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-21 at 13:33 -0500, Scott Wood wrote:
> On Tue, 2015-04-21 at 19:41 +1000, Michael Ellerman wrote:
> > The only little endian configuration we support is ppc64le, so we
> > shouldn't be asking which endian to use when building 32-bit kernels,
> > they are always big endian.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/platforms/Kconfig.cputype | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> > index 7264e91190be..12fc443b9d54 100644
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -421,6 +421,7 @@ config CPU_BIG_ENDIAN
> >  
> >  config CPU_LITTLE_ENDIAN
> >  	bool "Build little endian kernel"
> > +	depends on PPC64
> >  	select PPC64_BOOT_WRAPPER
> >  	help
> >  	  Build a little endian kernel.
> 
> Shouldn't this be PPC_BOOK3S_64?

Ah yeah, stupid BOOKE :)

Currently it's nothing so PPC64 was an improvement, but you're right, if we're
building 64-bit BOOKE then we shouldn't prompt.

cheers
