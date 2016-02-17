Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A3721A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 20:10:58 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 651F3140297
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 20:10:58 +1100 (AEDT)
Message-ID: <1455700258.17094.56.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Add POWER9 cputable entry
From: Michael Neuling <mikey@neuling.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Feb 2016 20:10:58 +1100
In-Reply-To: <56C40D1A.9060601@linux.vnet.ibm.com>
References: <1455685668-30198-1-git-send-email-mikey@neuling.org>
 <1455685668-30198-2-git-send-email-mikey@neuling.org>
 <56C40D1A.9060601@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +_GLOBAL(__setup_cpu_power9)
> > +	mflr	r11
> > +	bl	__init_FSCR
> > +	bl	__init_PMU
> Just to keep in mind, I am not sure whether
> powerisa 3.0 support MMCRS spr, so we
> will need a feature check in __init_PMU()
> for power9.

Yeah, I'm not expecting this to work.

I'm trying to lay down a common base we can start working on.  There
are lots of people working a bunch different bases.  I want to avoid
that and we can do that by upstreaming.

> > +	bl	__init_hvmode_206
> > +	mtlr	r11
> > +	beqlr
> > +	li	r0,0
> > +	mtspr	SPRN_LPID,r0
> > +	mfspr	r3,SPRN_LPCR
> > +	ori	r3, r3, LPCR_PECEDH
> > +	bl	__init_LPCR
> > +	bl	__init_HFSCR
> > +	bl	__init_tlb_power9
> > +	bl	__init_PMU_HV
>=20
> Again, need to check whether powerisa 3.0 support MMCRH spr
> which is used in __init_PMU_HV()

Same here.
> > +	{	/*  Hacked up Power9 */

/me reviews his own patch...

Oops

> > +		.pvr_mask		=3D 0xffff0000,
> > +		.pvr_value		=3D 0x004e0000,
> > +		.cpu_name		=3D "POWER9 (raw)",
> > +		.cpu_features		=3D CPU_FTRS_POWER9,
> > +		.cpu_user_features	=3D COMMON_USER_POWER9,
> > +		.cpu_user_features2	=3D COMMON_USER2_POWER9,
> > +		.mmu_features		=3D MMU_FTRS_POWER9,
> > +		.icache_bsize		=3D 128,
> > +		.dcache_bsize		=3D 128,
> > +		.num_pmcs		=3D 6,
> > +		.pmc_type		=3D PPC_PMC_IBM,
> > +		.oprofile_cpu_type	=3D "ppc64/power8",
>
> This should be ppc64/power9. We use "oprofile_cpu_type" in PMU init.

Yep, we can fix that up when we post PMU patches, but if I repost I'll
change so it doesn't match with old one.

Mikey
