Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 68A27DDE36
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 06:23:16 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAGJNCGs031017
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 14:23:13 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAGJNB6X079980
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 12:23:12 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAGJN9O3012050
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 12:23:09 -0700
Date: Fri, 16 Nov 2007 13:23:08 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 4xx: Use virtual PVR value to init FPU on
	arch/ppc 440EP
Message-ID: <20071116132308.2201e235@weaponx>
In-Reply-To: <96AAE1CB-3F7F-4231-AD52-01F358E01594@kernel.crashing.org>
References: <20071116112956.0f1ca5b1@weaponx>
	<96AAE1CB-3F7F-4231-AD52-01F358E01594@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 Nov 2007 13:20:09 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Nov 16, 2007, at 11:29 AM, Josh Boyer wrote:
> 
> > This fixes arch/ppc 440EP platforms to setup the FPU correctly.  A  
> > virtual
> > PVR is used, as 440GR platforms share an identical hardware PVR  
> > value and do
> > not have an FPU.
> >
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > Index: linux-2.6/arch/ppc/kernel/setup.c
> > ===================================================================
> > --- linux-2.6.orig/arch/ppc/kernel/setup.c
> > +++ linux-2.6/arch/ppc/kernel/setup.c
> > @@ -312,7 +312,14 @@ early_init(int r3, int r4, int r5)
> > 	 * Identify the CPU type and fix up code sections
> > 	 * that depend on which cpu we have.
> > 	 */
> > +#if defined(CONFIG_440EP) && defined(CONFIG_PPC_FPU)
> > +	/* We pass the virtual PVR here for 440EP as 440EP and 440GR have
> > +	 * identical PVRs and there is no reliable way to check for the FPU
> > +	 */
> > +	spec = identify_cpu(offset, (mfspr(SPRN_PVR) | 0x8));
> > +#else
> > 	spec = identify_cpu(offset, mfspr(SPRN_PVR));
> > +#endif
> > 	do_feature_fixups(spec->cpu_features,
> > 			  PTRRELOC(&__start___ftr_fixup),
> > 			  PTRRELOC(&__stop___ftr_fixup));
> 
> Are we really adding support for new processors to arch/ppc?

No.  This is to continue to support 440EP FPU in arch/ppc.  Commit
d1dfc35d3a62 switched the cputable around for EP(x)/GR(x) and arch/ppc wasn't fixed up.  So without the above patch, 440EP gets detected as 440GR and the FPU isn't initialized properly.

josh
