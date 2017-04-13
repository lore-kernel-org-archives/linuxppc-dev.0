Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3WK05pTNzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 16:36:20 +1000 (AEST)
Message-ID: <1492065380.4624.50.camel@neuling.org>
Subject: Re: [PATCH 1/3] powernv:idle: Use correct IDLE_THREAD_BITS in POWER8/9
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>,  Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>,  Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Apr 2017 16:36:20 +1000
In-Reply-To: <1b89d07b1a7ea140501a86b1ed246c5af1b0ce83.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <1b89d07b1a7ea140501a86b1ed246c5af1b0ce83.1491996797.git.ego@linux.vnet.ibm.com>
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

On Wed, 2017-04-12 at 17:16 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>=20
> This patch ensures that POWER8 and POWER9 processors use the correct
> value of IDLE_THREAD_BITS as POWER8 has 8 threads per core and hence
> the IDLE_THREAD_BITS should be 0xFF while POWER9 has only 4 threads
> per core and hence the IDLE_THREAD_BITS should be 0xF.

Why don't we derive this from the device tree rather than hard wiring it pe=
r cpu
type?

Mikey

>=20
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> =C2=A0arch/powerpc/include/asm/cpuidle.h=C2=A0=C2=A0=C2=A0=C2=A0| 3 ++-
> =C2=A0arch/powerpc/kernel/idle_book3s.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 9 =
++++++---
> =C2=A0arch/powerpc/platforms/powernv/idle.c | 5 ++++-
> =C2=A03 files changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cpuidle.h
> b/arch/powerpc/include/asm/cpuidle.h
> index 52586f9..fece6ca 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -34,7 +34,8 @@
> =C2=A0#define PNV_CORE_IDLE_THREAD_WINKLE_BITS_SHIFT	8
> =C2=A0#define PNV_CORE_IDLE_THREAD_WINKLE_BITS	0x0000FF00
> =C2=A0
> -#define PNV_CORE_IDLE_THREAD_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0	0x000000FF
> +#define PNV_CORE_IDLE_4THREAD_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0	0x0000000F
> +#define PNV_CORE_IDLE_8THREAD_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0	0x000000FF
> =C2=A0
> =C2=A0/*
> =C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D NOTE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S
> index 2b13fe2..9b747e9 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -223,7 +223,7 @@ lwarx_loop1:
> =C2=A0	add	r15,r15,r5			/* Add if winkle */
> =C2=A0	andc	r15,r15,r7			/* Clear thread bit */
> =C2=A0
> -	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
> +	andi.	r9,r15,PNV_CORE_IDLE_8THREAD_BITS
> =C2=A0
> =C2=A0/*
> =C2=A0 * If cr0 =3D 0, then current thread is the last thread of the core=
 entering
> @@ -582,8 +582,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> =C2=A0	stwcx.	r15,0,r14
> =C2=A0	bne-	1b
> =C2=A0	isync
> -
> -	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
> +BEGIN_FTR_SECTION
> +	andi.	r9,r15,PNV_CORE_IDLE_4THREAD_BITS
> +FTR_SECTION_ELSE
> +	andi.	r9,r15,PNV_CORE_IDLE_8THREAD_BITS
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> =C2=A0	cmpwi	cr2,r9,0
> =C2=A0
> =C2=A0	/*
> diff --git a/arch/powerpc/platforms/powernv/idle.c
> b/arch/powerpc/platforms/powernv/idle.c
> index 445f30a..d46920b 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -112,7 +112,10 @@ static void pnv_alloc_idle_core_states(void)
> =C2=A0		size_t paca_ptr_array_size;
> =C2=A0
> =C2=A0		core_idle_state =3D kmalloc_node(sizeof(u32), GFP_KERNEL,
> node);
> -		*core_idle_state =3D PNV_CORE_IDLE_THREAD_BITS;
> +		if (cpu_has_feature(CPU_FTR_ARCH_300))
> +			*core_idle_state =3D PNV_CORE_IDLE_4THREAD_BITS;
> +		else
> +			*core_idle_state =3D PNV_CORE_IDLE_8THREAD_BITS;
> =C2=A0		paca_ptr_array_size =3D (threads_per_core *
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sizeof(struct paca_st=
ruct *));
> =C2=A0
