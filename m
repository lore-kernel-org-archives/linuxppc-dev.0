Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B61BDE081
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:12:31 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] ppc32: Fix errata for 603 CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <059AA568-4729-4060-A876-C8460E0A7794@kernel.crashing.org>
References: <Pine.LNX.4.64.0804211457010.8003@blarg.am.freescale.net>
	<1208812957.9640.47.camel@pasglop>
	<059AA568-4729-4060-A876-C8460E0A7794@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 08:12:24 +1000
Message-Id: <1208815944.9640.49.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-21 at 17:04 -0500, Kumar Gala wrote:
> On Apr 21, 2008, at 4:22 PM, Benjamin Herrenschmidt wrote:
> >
> >>
> >> _GLOBAL(__setup_cpu_603)
> >> -	b	setup_common_caches
> >> +	mflr	r4
> >> +BEGIN_FTR_SECTION
> >> +	bl	__init_fpu_registers
> >> +END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
> >> +	bl	__init_fpu_registers
> >> +	bl	setup_common_caches
> >> +	mtlr	r4
> >> +	blr
> >> _GLOBAL(__setup_cpu_604)
> >> 	mflr	r4
> >> 	bl	setup_common_cache
> >
> > Has the feature fixup been perform yet when __setup_* is called ?
> 
> Yes.  We call do_feature_fixups() in early_init and call  
> call_setup_cpu() after than on 6xx (in head_32.S).

Hrm. I think that may be the other way around on 64 bits... damn, I need
to consolidate these.

I'd rather have the init code explicitely test for the features.

Ben.
