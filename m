Return-Path: <diana.craciun@nxp.com>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Lz5v3TPFzF1g4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 23:21:38 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "oss@buserror.net" <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>, Bharat
 Bhushan <bharat.bhushan@nxp.com>
Subject: Re: [PATCH v2 2/3] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book3E
Date: Thu, 5 Jul 2018 13:21:31 +0000
Message-ID: <VI1PR0401MB24639B3BFDF52DD27471D626FF400@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-3-git-send-email-diana.craciun@nxp.com>
 <87tvpgg4qa.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,=0A=
=0A=
Thank you for the review.=0A=
=0A=
On 07/03/2018 10:26 AM, Michael Ellerman wrote:=0A=
> Hi Diana,=0A=
>=0A=
> A few comments below ...=0A=
>=0A=
> Diana Craciun <diana.craciun@nxp.com> writes:=0A=
>> Implement the barrier_nospec as a isync;sync instruction sequence.=0A=
>> The implementation uses the infrastructure built for BOOK3S 64.=0A=
> Do you have any details on why that sequence functions as an effective=0A=
> barrier on your chips?=0A=
=0A=
It was recommended by the hardware team, I do not have details.=0A=
=0A=
>=0A=
> In a lot of places we have eg:=0A=
>=0A=
>  +#if defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_FSL_BOOK3E)=0A=
>=0A=
> Can you please add a Kconfig symbol to capture that. eg.=0A=
>=0A=
> config PPC_NOSPEC=0A=
> 	bool=0A=
>         default y=0A=
> 	depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E=0A=
>=0A=
>=0A=
> And then use that everywhere.=0A=
=0A=
OK.=0A=
=0A=
>=0A=
>> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/a=
sm/barrier.h=0A=
>> index f67b3f6..405d572 100644=0A=
>> --- a/arch/powerpc/include/asm/barrier.h=0A=
>> +++ b/arch/powerpc/include/asm/barrier.h=0A=
>> @@ -86,6 +86,16 @@ do {									\=0A=
>>  // This also acts as a compiler barrier due to the memory clobber.=0A=
>>  #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "m=
emory")=0A=
>>  =0A=
>> +#elif defined(CONFIG_PPC_FSL_BOOK3E)=0A=
>> +/*=0A=
>> + * Prevent the execution of subsequent instructions speculatively using=
 a=0A=
>> + * isync;sync instruction sequence.=0A=
>> + */=0A=
>> +#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop; nop=0A=
>> +=0A=
>> +// This also acts as a compiler barrier due to the memory clobber.=0A=
>> +#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "m=
emory")=0A=
>> +=0A=
>>  #else /* !CONFIG_PPC_BOOK3S_64 */=0A=
>>  #define barrier_nospec_asm=0A=
>>  #define barrier_nospec()=0A=
> If we have CONFIG_PPC_NOSPEC this can be done something like:=0A=
>=0A=
> #ifdef CONFIG_PPC_BOOK3S_64=0A=
> #define NOSPEC_BARRIER_SLOT	nop=0A=
> #elif defined(CONFIG_PPC_FSL_BOOK3E)=0A=
> #define NOSPEC_BARRIER_SLOT	nop; nop=0A=
> #endif /* CONFIG_PPC_BOOK3S_64 */=0A=
>=0A=
> #ifdef CONFIG_PPC_NOSPEC=0A=
> /*=0A=
>  * Prevent execution of subsequent instructions until preceding branches =
have=0A=
>  * been fully resolved and are no longer executing speculatively.=0A=
>  */=0A=
> #define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; NOSPEC_BARRIER_S=
LOT=0A=
>=0A=
> // This also acts as a compiler barrier due to the memory clobber.=0A=
> #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "mem=
ory")=0A=
> #else=0A=
> #define barrier_nospec_asm=0A=
> #define barrier_nospec()=0A=
> #endif /* CONFIG_PPC_NOSPEC */=0A=
=0A=
OK.=0A=
=0A=
>=0A=
>=0A=
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile=
=0A=
>> index 2b4c40b2..d9dee43 100644=0A=
>> --- a/arch/powerpc/kernel/Makefile=0A=
>> +++ b/arch/powerpc/kernel/Makefile=0A=
>> @@ -76,7 +76,7 @@ endif=0A=
>>  obj64-$(CONFIG_HIBERNATION)	+=3D swsusp_asm64.o=0A=
>>  obj-$(CONFIG_MODULES)		+=3D module.o module_$(BITS).o=0A=
>>  obj-$(CONFIG_44x)		+=3D cpu_setup_44x.o=0A=
>> -obj-$(CONFIG_PPC_FSL_BOOK3E)	+=3D cpu_setup_fsl_booke.o=0A=
>> +obj-$(CONFIG_PPC_FSL_BOOK3E)	+=3D cpu_setup_fsl_booke.o security.o=0A=
>>  obj-$(CONFIG_PPC_DOORBELL)	+=3D dbell.o=0A=
>>  obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o=0A=
> Can we instead do:=0A=
>=0A=
> obj-$(CONFIG_PPC_NOSPEC)	+=3D security.o=0A=
=0A=
OK=0A=
=0A=
>=0A=
>> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securi=
ty.c=0A=
>> index c55e102..797c975 100644=0A=
>> --- a/arch/powerpc/kernel/security.c=0A=
>> +++ b/arch/powerpc/kernel/security.c=0A=
>> @@ -13,7 +13,9 @@=0A=
>>  #include <asm/setup.h>=0A=
>>  =0A=
>>  =0A=
>> +#ifdef CONFIG_PPC_BOOK3S_64=0A=
>>  unsigned long powerpc_security_features __read_mostly =3D SEC_FTR_DEFAU=
LT;=0A=
>> +#endif /* CONFIG_PPC_BOOK3S_64 */=0A=
> Why are you making that book3s specific?=0A=
>=0A=
> By doing that you then can't use the existing versions of=0A=
> setup_barrier_nospec() and cpu_show_spectre_v1/v2().=0A=
>=0A=
>> @@ -24,6 +26,7 @@ static void enable_barrier_nospec(bool enable)=0A=
>>  	do_barrier_nospec_fixups(enable);=0A=
>>  }=0A=
>>  =0A=
>> +#ifdef CONFIG_PPC_BOOK3S_64=0A=
>>  void setup_barrier_nospec(void)=0A=
>>  {=0A=
>>  	bool enable;=0A=
>> @@ -46,6 +49,15 @@ void setup_barrier_nospec(void)=0A=
>>  	if (!no_nospec)=0A=
>>  		enable_barrier_nospec(enable);=0A=
>>  }=0A=
>> +#endif /* CONFIG_PPC_BOOK3S_64 */=0A=
>> +=0A=
>> +#ifdef CONFIG_PPC_FSL_BOOK3E=0A=
>> +void setup_barrier_nospec(void)=0A=
>> +{=0A=
>> +	if (!no_nospec)=0A=
>> +		enable_barrier_nospec(true);=0A=
>> +}=0A=
>> +#endif /* CONFIG_PPC_FSL_BOOK3E */=0A=
> eg. that is identical to the existing version except for the feature chec=
k:=0A=
>=0A=
> 	enable =3D security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&=0A=
> 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);=0A=
>=0A=
>=0A=
> Both those bits are enabled by default, so you shouldn't need to elide=0A=
> that check.=0A=
>=0A=
> So basically you should be able to use the existing=0A=
> setup_barrier_nospec() if you just remove the ifdef around=0A=
> powerpc_security_features. Or am I missing something?=0A=
=0A=
OK. I was under the impression that those bits are not enabled by=0A=
default. But obviously I was wrong. In this case I will use the existing=0A=
function.=0A=
=0A=
>=0A=
>=0A=
>> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_=
32.c=0A=
>> index 7445748..80c1e6e 100644=0A=
>> --- a/arch/powerpc/kernel/setup_32.c=0A=
>> +++ b/arch/powerpc/kernel/setup_32.c=0A=
>> @@ -116,6 +116,11 @@ notrace void __init machine_init(u64 dt_ptr)=0A=
>>  	/* Do some early initialization based on the flat device tree */=0A=
>>  	early_init_devtree(__va(dt_ptr));=0A=
>>  =0A=
>> +	/* Apply the speculation barrier fixup */=0A=
>> +#ifdef CONFIG_PPC_FSL_BOOK3E=0A=
>> +	setup_barrier_nospec();=0A=
>> +#endif=0A=
> This ifdef should be handled in a header with an empty version for the=0A=
> #else case.=0A=
=0A=
OK=0A=
=0A=
>=0A=
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_=
64.c=0A=
>> index 7a7ce8a..b2a644a 100644=0A=
>> --- a/arch/powerpc/kernel/setup_64.c=0A=
>> +++ b/arch/powerpc/kernel/setup_64.c=0A=
>> @@ -327,6 +327,12 @@ void __init early_setup(unsigned long dt_ptr)=0A=
>>  =0A=
>>  	/* Apply all the dynamic patching */=0A=
>>  	apply_feature_fixups();=0A=
>> +=0A=
>> +	/* Apply the speculation barrier fixup */=0A=
>> +#ifdef CONFIG_PPC_FSL_BOOK3E=0A=
>> +	setup_barrier_nospec();=0A=
>> +#endif /* CONFIG_PPC_FSL_BOOK3E */=0A=
> Can you call it from ppc_md->setup_arch() like the other platforms?=0A=
>=0A=
> Failing that we could put it in setup_arch() after the call to=0A=
> ppc_md->setup_arch(), so we can share it with powernv/pseries.=0A=
=0A=
The reason for which I did not call it from the ppc_md->setup_arch() was=0A=
that from my point of view the mitigation is not specific to the=0A=
platform code, but rather to the CPU.=0A=
=0A=
>=0A=
>> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/featur=
e-fixups.c=0A=
>> index 2b9173d..bea2b87 100644=0A=
>> --- a/arch/powerpc/lib/feature-fixups.c=0A=
>> +++ b/arch/powerpc/lib/feature-fixups.c=0A=
>> @@ -188,7 +188,40 @@ void do_barrier_nospec_fixups_range(bool enable, vo=
id *fixup_start, void *fixup_=0A=
>>  =0A=
>>  	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);=0A=
>>  }=0A=
>> +#endif /* CONFIG_PPC_BOOK3S_64 */=0A=
>> +=0A=
>> +#ifdef CONFIG_PPC_FSL_BOOK3E=0A=
>> +void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, voi=
d *fixup_end)=0A=
>> +{=0A=
>> +	unsigned int instr[2], *dest;=0A=
>> +	long *start, *end;=0A=
>> +	int i;=0A=
>> +=0A=
>> +	start =3D fixup_start;=0A=
>> +	end =3D fixup_end;=0A=
>> +=0A=
>> +	instr[0] =3D PPC_INST_NOP;=0A=
>> +	instr[1] =3D PPC_INST_NOP;=0A=
>> +=0A=
>> +	if (enable) {=0A=
>> +		pr_info("barrier_nospec; using isync; sync as a speculation barrier\n=
");=0A=
>> +		instr[0] =3D PPC_INST_ISYNC;=0A=
>> +		instr[1] =3D PPC_INST_SYNC;=0A=
>> +	}=0A=
>> +=0A=
>> +	for (i =3D 0; start < end; start++, i++) {=0A=
>> +		dest =3D (void *)start + *start;=0A=
>> +		pr_devel("patching dest %lx\n", (unsigned long)dest);=0A=
>>  =0A=
>> +		patch_instruction(dest, instr[0]);=0A=
>> +		patch_instruction(dest + 1, instr[1]);=0A=
>> +	}=0A=
>> +=0A=
>> +	pr_debug("barrier-nospec: patched %d locations\n", i);=0A=
>> +}=0A=
>> +#endif /* CONFIG_PPC_FSL_BOOK3E */=0A=
> It's a bit unfortunate that we end up with two versions of that, which=0A=
> are 80% the same. But merging them without ugly ifdefs would require a=0A=
> bit more refactoring. So I guess it's OK for now.=0A=
>=0A=
> cheers=0A=
>=0A=
Regards,=0A=
=0A=
Diana=0A=
=0A=
