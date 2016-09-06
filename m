Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSpdZ2QLKzDrpH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 11:18:42 +1000 (AEST)
Message-ID: <1473124721.6491.45.camel@neuling.org>
Subject: Re: [PATCH 4/4] powerpc/mm: Update the HID bit when switching from
 radix to hash
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Sep 2016 11:18:41 +1000
In-Reply-To: <1472031219-18759-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1472031219-18759-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Wed, 2016-08-24 at 15:03 +0530, Aneesh Kumar K.V wrote:
> Power9 DD1 requires to update the hid0 register when switching from
> hash to radix.

One minor nit. =C2=A0This is bidirectional not just "hash to radix"

Could just be:

powerpc/mm: Update the HID bit when switching MMU modes

Power9 DD1 requires an update to the HID0 register when switching=C2=A0
MMU modes ie. radix <-> hash.

Otherwise...

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/reg.h=C2=A0=C2=A0|=C2=A0=C2=A03 +++
> =C2=A0arch/powerpc/mm/hash_utils_64.c | 25 +++++++++++++++++++++++++
> =C2=A0arch/powerpc/mm/pgtable-radix.c | 28 ++++++++++++++++++++++++++++
> =C2=A03 files changed, 56 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index f69f40f1519a..9dddabc2fced 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -475,6 +475,9 @@
> =C2=A0#define HID0_POWER8_1TO4LPAR	__MASK(51)
> =C2=A0#define HID0_POWER8_DYNLPARDIS	__MASK(48)
> =C2=A0
> +/* POWER9 HID0 bits */
> +#define HID0_POWER9_RADIX	__MASK(63 - 8)
> +
> =C2=A0#define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
> =C2=A0#ifdef CONFIG_6xx
> =C2=A0#define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index 0821556e16f4..35a6721b3d25 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -711,6 +711,29 @@ int remove_section_mapping(unsigned long start, unsi=
gned long end)
> =C2=A0}
> =C2=A0#endif /* CONFIG_MEMORY_HOTPLUG */
> =C2=A0
> +static void update_hid_for_hash(void)
> +{
> +	unsigned long hid0;
> +	unsigned long rb =3D 3UL << PPC_BITLSHIFT(53); /* IS =3D 3 */
> +
> +	asm volatile("ptesync": : :"memory");
> +	/* prs =3D 0, ric =3D 2, rs =3D 0, r =3D 1 is =3D 3 */
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: : "r"(rb), "i"(0), "i"(0), "i"(2), "r"=
(0) : "memory");
> +	asm volatile("eieio; tlbsync; ptesync; isync; slbia": : :"memory");
> +	/*
> +	=C2=A0* now switch the HID
> +	=C2=A0*/
> +	hid0=C2=A0=C2=A0=3D mfspr(SPRN_HID0);
> +	hid0 &=3D ~HID0_POWER9_RADIX;
> +	mtspr(SPRN_HID0, hid0);
> +	asm volatile("isync": : :"memory");
> +
> +	/* Wait for it to happen */
> +	while ((mfspr(SPRN_HID0) & HID0_POWER9_RADIX))
> +		cpu_relax();
> +}
> +
> =C2=A0static void __init hash_init_partition_table(phys_addr_t hash_table=
,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long htab_size)
> =C2=A0{
> @@ -737,6 +760,8 @@ static void __init hash_init_partition_table(phys_add=
r_t hash_table,
> =C2=A0	=C2=A0*/
> =C2=A0	partition_tb->patb1 =3D 0;
> =C2=A0	pr_info("Partition table %p\n", partition_tb);
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		update_hid_for_hash();
> =C2=A0	/*
> =C2=A0	=C2=A0* update partition table control register,
> =C2=A0	=C2=A0* 64 K size.
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-ra=
dix.c
> index af897d91d09f..8f086352e421 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -294,6 +294,32 @@ found:
> =C2=A0	return;
> =C2=A0}
> =C2=A0
> +static void update_hid_for_radix(void)
> +{
> +	unsigned long hid0;
> +	unsigned long rb =3D 3UL << PPC_BITLSHIFT(53); /* IS =3D 3 */
> +
> +	asm volatile("ptesync": : :"memory");
> +	/* prs =3D 0, ric =3D 2, rs =3D 0, r =3D 1 is =3D 3 */
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: : "r"(rb), "i"(1), "i"(0), "i"(2), "r"=
(0) : "memory");
> +	/* prs =3D 1, ric =3D 2, rs =3D 0, r =3D 1 is =3D 3 */
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: : "r"(rb), "i"(1), "i"(1), "i"(2), "r"=
(0) : "memory");
> +	asm volatile("eieio; tlbsync; ptesync; isync; slbia": : :"memory");
> +	/*
> +	=C2=A0* now switch the HID
> +	=C2=A0*/
> +	hid0=C2=A0=C2=A0=3D mfspr(SPRN_HID0);
> +	hid0 |=3D HID0_POWER9_RADIX;
> +	mtspr(SPRN_HID0, hid0);
> +	asm volatile("isync": : :"memory");
> +
> +	/* Wait for it to happen */
> +	while (!(mfspr(SPRN_HID0) & HID0_POWER9_RADIX))
> +		cpu_relax();
> +}
> +
> =C2=A0void __init radix__early_init_mmu(void)
> =C2=A0{
> =C2=A0	unsigned long lpcr;
> @@ -345,6 +371,8 @@ void __init radix__early_init_mmu(void)
> =C2=A0
> =C2=A0	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
> =C2=A0		radix_init_native();
> +		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +			update_hid_for_radix();
> =C2=A0		lpcr =3D mfspr(SPRN_LPCR);
> =C2=A0		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
> =C2=A0		radix_init_partition_table();
