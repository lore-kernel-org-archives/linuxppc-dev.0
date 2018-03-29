Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BZLY3tsxzDrTt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 17:18:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/14] numa aware allocation for pacas, stacks, pagetables
In-Reply-To: <20180308120412.1cbe9ace@roar.ozlabs.ibm.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <87muzkdusj.fsf@concordia.ellerman.id.au>
 <20180308120412.1cbe9ace@roar.ozlabs.ibm.com>
Date: Thu, 29 Mar 2018 17:18:12 +1100
Message-ID: <87in9f1k2j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Wed, 07 Mar 2018 21:50:04 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > This series allows numa aware allocations for various early data
>> > structures for radix. Hash still has a bolted SLB limitation that
>> > prevents at least pacas and stacks from node-affine allocations.
>> >
>> > Fixed up a number of bugs, got pSeries working, added a couple more
>> > cases where page tables can be allocated node-local.=20=20
>>=20
>> Few problems in here:
>>=20
>> FAILURE kernel-build-linux =C2=BB powerpc,gcc_ubuntu_be,pmac32
>>   arch/powerpc/kernel/prom.c:748:2: error: implicit declaration of funct=
ion 'allocate_paca_ptrs' [-Werror=3Dimplicit-function-declaration]
>>=20
>> FAILURE kernel-build-linux =C2=BB powerpc,gcc_ubuntu_le,powernv
>>   arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has=
 no member named 'lppaca_ptr'
>>   arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has=
 no member named 'lppaca_ptr'
>>=20
>> Did I miss a follow-up or something?
>
> Here's a patch that applies to "powerpc/64: defer paca allocation
> until memory topology is discovered". The first hunk fixes the ppc32
> issue, and the second hunk avoids freeing the cpu_to_phys_id array
> if the platform didn't allocate it. But I've just realized that
> should go into the previous patch (which is missing the
> memblock_free).
> --
...
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 56f7a2b793e0..2ba05acc2973 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -854,8 +854,10 @@ static void smp_setup_pacas(void)
>  		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
>  	}
>=20=20
> -	memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
> -	cpu_to_phys_id =3D NULL;
> +	if (cpu_to_phys_id) {
> +		memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
> +		cpu_to_phys_id =3D NULL;
> +	}
>  }
>  #endif
=20
Where did you want that?

cheers
