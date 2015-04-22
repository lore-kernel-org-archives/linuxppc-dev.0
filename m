Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 218501A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 10:30:34 +1000 (AEST)
Message-ID: <1429662633.15241.3.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Disable building the 32-bit VDSO on little
 endian
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 22 Apr 2015 10:30:33 +1000
In-Reply-To: <1429641409.4352.110.camel@freescale.com>
References: <1429609312-32638-1-git-send-email-mpe@ellerman.id.au>
 <1429609312-32638-2-git-send-email-mpe@ellerman.id.au>
 <1429641409.4352.110.camel@freescale.com>
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

On Tue, 2015-04-21 at 13:36 -0500, Scott Wood wrote:
> On Tue, 2015-04-21 at 19:41 +1000, Michael Ellerman wrote:
> > diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> > index 12fc443b9d54..1324f589f43a 100644
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -405,6 +405,16 @@ config PPC_DOORBELL
> >  
> >  endmenu
> >  
> > +config VDSO32
> > +	def_bool y
> > +	depends on PPC32 || CPU_BIG_ENDIAN
> > +	help
> > +	  This symbol controls whether we build the 32-bit VDSO. We obviously
> > +	  want to do that if we're building a 32-bit kernel. If we're building
> > +	  a 64-bit kernel then we only want a 32-bit VDSO if we're building for
> > +	  big endian. That is because the only little endian configuration we
> > +	  support is ppc64le which is 64-bit only.
> 
> Shouldn't this depend on COMPAT, and COMPAT depend on CPU_BIG_ENDIAN?

Hmm maybe. But ATM we can't disable COMPAT, that's an even bigger mess. So I
think we'll go for this and when we get COMPAT sorted then we can maybe fix the
dependency.

cheers
