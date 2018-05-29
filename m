Return-Path: <diana.craciun@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00083.outbound.protection.outlook.com [40.107.0.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wHX36b4nzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:22:11 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
Date: Tue, 29 May 2018 15:22:04 +0000
Message-ID: <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
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

Hi Scott,=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 05/22/2018 11:31 PM, Scott Wood wrote:=0A=
> On Tue, 2018-05-22 at 10:10 +0300, Diana Craciun wrote:=0A=
>> Implement the barrier_nospec as a isync;sync instruction sequence.=0A=
>> The implementation uses the infrastructure built for BOOK3S 64=0A=
>> with the difference that for NXP platforms there is no firmware involved=
=0A=
>> and the need for a speculation barrier is read from the device tree.=0A=
>> I have used the same name for the property:=0A=
>> fsl,needs-spec-barrier-for-bounds-check=0A=
> Using the device tree this way means that anyone without an updated devic=
e=0A=
> tree won't get the protection.  I also don't see any device tree updates =
--=0A=
> which chips are affected?=0A=
=0A=
I was planning to have the device tree changes in a different patch-set.=0A=
The affected cores are e500, e500mc, e5500, e6500.=0A=
=0A=
>   Wouldn't it be more robust to just have the kernel=0A=
> check the CPU type, especially given that it already does so for a lot of=
=0A=
> other purposes?=0A=
=0A=
Yes, I think that it might be a better solution not to use the device=0A=
tree at all.=0A=
=0A=
>=0A=
>> +#ifdef CONFIG_PPC_BOOK3S_64=0A=
>>  void setup_barrier_nospec(void)=0A=
>>  {=0A=
>>  	bool enable;=0A=
>> @@ -44,6 +46,12 @@ void setup_barrier_nospec(void)=0A=
>>  =0A=
>>  	enable_barrier_nospec(enable);=0A=
>>  }=0A=
>> +#elif CONFIG_PPC_FSL_BOOK3E=0A=
>> +void setup_barrier_nospec(void)=0A=
>> +{=0A=
>> +	enable_barrier_nospec(true);=0A=
>> +}=0A=
>> +#endif=0A=
> The call site is in FSL_BOOK3E-specific code so why not call=0A=
> enable_barrier_nospec() directly from there?=0A=
=0A=
OK=0A=
=0A=
>   =0A=
>> +#ifdef CONFIG_PPC_BOOK3S_64=0A=
>>  ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute=
=0A=
>> *attr, char *buf)=0A=
>>  {=0A=
>>  	bool thread_priv;=0A=
>> @@ -155,3 +164,4 @@ ssize_t cpu_show_spectre_v2(struct device *dev, stru=
ct=0A=
>> device_attribute *attr, c=0A=
>>  =0A=
>>  	return s.len;=0A=
>>  }=0A=
>> +#endif=0A=
> No equivalent of this for FSL?=0A=
=0A=
There will be an equivalent for this for FSL as well. I was planning to=0A=
send a different patch for this.=0A=
=0A=
>=0A=
>> +#ifdef CONFIG_PPC_FSL_BOOK3E=0A=
>> +void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, voi=
d=0A=
>> *fixup_end)=0A=
>> +{=0A=
>> +	unsigned int instr[2], *dest;=0A=
>> +	long *start, *end;=0A=
>> +	int i;=0A=
>> +=0A=
>> +	start =3D fixup_start;=0A=
>> +	end =3D fixup_end;=0A=
>> +=0A=
>> +	instr[0] =3D PPC_INST_NOP; /* nop */=0A=
>> +	instr[1] =3D PPC_INST_NOP; /* nop */=0A=
>> +=0A=
>> +	if (enable) {=0A=
>> +		pr_info("barrier_nospec: using isync; sync as a speculation=0A=
>> barrier\n");=0A=
>> +		instr[0] =3D PPC_INST_ISYNC;=0A=
>> +		instr[1] =3D PPC_INST_SYNC;=0A=
>> +	}=0A=
>> +=0A=
>> +	for (i =3D 0; start < end; start++, i++) {=0A=
>> +		dest =3D (void *)start + *start;=0A=
>> +		pr_devel("patching dest %lx\n", (unsigned long)dest);=0A=
>> +=0A=
>> +		patch_instruction(dest, instr[0]);=0A=
>> +		patch_instruction(dest + 1, instr[1]);=0A=
>> +=0A=
>> +	}=0A=
>> +=0A=
>> +	pr_debug("barrier-nospec: patched %d locations\n", i);=0A=
> Why patch nops in if not enabled?  Aren't those locations already nops?  =
For=0A=
> that matter, how can this function even be called on FSL_BOOK3E with enab=
le !=3D=0A=
> true?=0A=
=0A=
There is some code in arch/powerpc/kernel/security.c which allows=0A=
control of barrier_nospec via debugfs.=0A=
=0A=
>=0A=
>> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c=0A=
>> b/arch/powerpc/platforms/85xx/corenet_generic.c=0A=
>> index ac191a7..11bce3d 100644=0A=
>> --- a/arch/powerpc/platforms/85xx/corenet_generic.c=0A=
>> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c=0A=
>> @@ -59,6 +59,21 @@ void __init corenet_gen_pic_init(void)=0A=
>>  	}=0A=
>>  }=0A=
>>  =0A=
>> +static void setup_spec_barrier(void)=0A=
>> +{=0A=
>> +	struct device_node *np =3D of_find_node_by_name(NULL, "cpus");=0A=
>> +=0A=
>> +	if (np) {=0A=
>> +		struct property *prop;=0A=
>> +=0A=
>> +		prop =3D of_find_property(np,=0A=
>> +		       "fsl,needs-spec-barrier-for-bounds-check", NULL);=0A=
>> +		if (prop)=0A=
>> +			setup_barrier_nospec();=0A=
>> +		of_node_put(np);=0A=
>> +	}=0A=
>> +}=0A=
> Why is this in board code?=0A=
=0A=
I will move it away from the board code.=0A=
=0A=
>=0A=
> Should there be a way for the user to choose not to enable this (editing =
the=0A=
> device tree doesn't count), for a use case that is not sufficiently secur=
ity=0A=
> sensitive to justify the performance loss?  What is the performance impac=
t of=0A=
> this patch?=0A=
=0A=
My reason was that on the other architectures Spectre variant 1=0A=
mitigations are not disabled either. But I think that it might be a good=0A=
idea to add a bootarg parameter to disable the barrier.=0A=
=0A=
Regards,=0A=
=0A=
Diana=0A=
=0A=
