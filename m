Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYcr97433zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 16:14:17 +1000 (AEST)
Message-ID: <1466489657.25838.39.camel@neuling.org>
Subject: Re: [v6, 08/11] powerpc/powernv: Add platform support for stop
 instruction
From: Michael Neuling <mikey@neuling.org>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: ego@linux.vnet.ibm.com, benh@au1.ibm.com, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Aneesh Kk Veetil
 <aneesh.kumar@in.ibm.com>
Date: Tue, 21 Jun 2016 16:14:17 +1000
In-Reply-To: <5761518A.1040709@linux.vnet.ibm.com>
References: <3rV3nm07hsz9t1V@ozlabs.org> <5761518A.1040709@linux.vnet.ibm.com>
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


> > > +#define OPAL_PM_TIMEBASE_STOP		0x00000002
> > > +#define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
> > > +#define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
> > > =C2=A0#define OPAL_PM_NAP_ENABLED		0x00010000
> > > =C2=A0#define OPAL_PM_SLEEP_ENABLED		0x00020000
> > > =C2=A0#define OPAL_PM_WINKLE_ENABLED		0x00040000
> > > =C2=A0#define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with
> > > workaround */
> > > +#define OPAL_PM_STOP_INST_FAST		0x00100000
> > > +#define OPAL_PM_STOP_INST_DEEP		0x00200000
> > I don't see the above in skiboot yet?
> I've posted it here -
> http://patchwork.ozlabs.org/patch/617828/

FWIW, this is in now.

https://github.com/open-power/skiboot/commit/952daa69baca407383bc900911f6c4=
0718a0e289

> >=20
> >=20
> > >=20
> > > diff --git a/arch/powerpc/include/asm/paca.h
> > > b/arch/powerpc/include/asm/paca.h
> > > index 546540b..ae91b44 100644
> > > --- a/arch/powerpc/include/asm/paca.h
> > > +++ b/arch/powerpc/include/asm/paca.h
> > > @@ -171,6 +171,8 @@ struct paca_struct {
> > > =C2=A0	/* Mask to denote subcore sibling threads */
> > > =C2=A0	u8 subcore_sibling_mask;
> > > =C2=A0#endif
> > > +	/* Template for PSSCR with EC, ESL, TR, PSLL, MTL fields set
> > > */
> > > +	u64 thread_psscr;
> > I'm not entirely clear on why that needs to be in the paca. Could it
> > not be global?
> >=20
> While we use Requested Level (RL) field of PSSCR to request a stop
> level, other fields in the SPR like EC, ESL, TR, PSLL, MTL can be
> modified by individual threads less frequently to alter the behaviour of
> stop. So the idea was to have a per-thread variable with all (except RL)
> fields of PSSCR set appropriately. Threads at the time of entering idle,
> can modify the RL field in the variable and execute stop instruction.

But we don't do any of this currently? This is setup at init
in=C2=A0pnv_init_idle_states() and only the RL is changed in power_stop().

So it can still be a global. =C2=A0It could just be a constant currently ev=
en.

> =C2=A0	.text
> > > =C2=A0
> > > =C2=A0/*
> > > @@ -61,8 +75,19 @@ save_sprs_to_stack:
> > > =C2=A0	=C2=A0* Note all register i.e per-core, per-subcore or per-thr=
ead=20
> > > is saved
> > > =C2=A0	=C2=A0* here since any thread in the core might wake up first
> > > =C2=A0	=C2=A0*/
> > > +BEGIN_FTR_SECTION
> > > +	mfspr	r3,SPRN_PTCR
> > > +	std	r3,_PTCR(r1)
> > > +	mfspr	r3,SPRN_LMRR
> > > +	std	r3,_LMRR(r1)
> > > +	mfspr	r3,SPRN_LMSER
> > > +	std	r3,_LMSER(r1)
> > > +	mfspr	r3,SPRN_ASDR
> > > +	std	r3,_ASDR(r1)
> > > +FTR_SECTION_ELSE
> > A comment here saying that SDR1 is removed in ISA 3.0 would be helpful.
> >=20
> Ok.

I thought we decided we didn't need LMRR, LMSR,=C2=A0

https://lkml.org/lkml/2016/6/8/1121

or ASDR isn't actually used at all yet and is only valid for some page
faults, so we don't need it here also.

> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
> > > +
> > > +	/* Restore per thread state */
> > > +BEGIN_FTR_SECTION
> > > +	bl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__restore_cpu_power9
> > > +
> > > +	ld	r4,_LMRR(r1)
> > > +	mtspr	SPRN_LMRR,r4
> > > +	ld	r4,_LMSER(r1)
> > > +	mtspr	SPRN_LMSER,r4
> > > +	ld	r4,_ASDR(r1)
> > > +	mtspr	SPRN_ASDR,r4
> > Should those be in __restore_cpu_power9 ?
> I was not sure how these registers will be used, but after speaking to
> Aneesh and Mikey I realized these registers will not need restoring.
> LMRR and LMSER are associated with the context and ADSR will be consumed
> before entering stop. So I'll be dropping the this hunk in next revision.

Yep.

>=C2=A0
> > > =C2=A0	pnv_alloc_idle_core_states();
> > > =C2=A0
> > > +	if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
> > > +		for_each_possible_cpu(i) {
> > > +
> > > +			u64 psscr_init_val =3D PSSCR_ESL | PSSCR_EC |
> > > +					PSSCR_PSLL_MASK | PSSCR_TR_MASK |
> > > +					PSSCR_MTL_MASK;
> > > +
> > > +			paca[i].thread_psscr =3D psscr_init_val;

This seems to be the only place you set this. =C2=A0Why put it in the paca,=
 why
not just make this a constant?=C2=A0

Mikey
