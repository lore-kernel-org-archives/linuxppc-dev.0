Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0F5M64MJzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 20:43:51 +1000 (AEST)
Message-ID: <1462358630.4115.76.camel@neuling.org>
Subject: Re: [PATCH 3/3] powerpc: Load Monitor Register Tests
From: Michael Neuling <mikey@neuling.org>
To: Jack Miller <jack@codezen.org>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, anton@samba.org
Date: Wed, 04 May 2016 20:43:50 +1000
In-Reply-To: <1461013724-12784-4-git-send-email-jack@codezen.org>
References: <201604190414.NkLxbSQl%fengguang.wu@intel.com>
 <1461013724-12784-1-git-send-email-jack@codezen.org>
 <1461013724-12784-4-git-send-email-jack@codezen.org>
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

On Mon, 2016-04-18 at 16:08 -0500, Jack Miller wrote:
> Adds two tests. One is a simple test to ensure that the new registers
> LMRR and LMSER are properly maintained. The other actually uses the
> existing EBB test infrastructure to test that LMRR and LMSER behave as
> documented.
>=20
> Signed-off-by: Jack Miller <jack@codezen.org>
> ---
> =C2=A0tools/testing/selftests/powerpc/pmu/ebb/Makefile=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0=C2=A02 +-
> =C2=A0tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c=C2=A0=C2=A0| 144 =
+++++++++++++++++++++
> =C2=A0tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h=C2=A0=C2=A0|=C2=
=A0=C2=A039 ++++++
> =C2=A0.../selftests/powerpc/pmu/ebb/ebb_lmr_regs.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A038 ++++++
> =C2=A0tools/testing/selftests/powerpc/pmu/ebb/reg.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A05 +

The new tests need to be added to .gitignore.

> =C2=A05 files changed, 227 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.=
c
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.=
h
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_=
regs.c
>=20
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/tes=
ting/selftests/powerpc/pmu/ebb/Makefile
> index 8d2279c4..6b0453e 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
> @@ -14,7 +14,7 @@ TEST_PROGS :=3D reg_access_test event_attributes_test c=
ycles_test	\
> =C2=A0	=C2=A0fork_cleanup_test ebb_on_child_test			\
> =C2=A0	=C2=A0ebb_on_willing_child_test back_to_back_ebbs_test	\
> =C2=A0	=C2=A0lost_exception_test no_handler_test			\
> -	=C2=A0cycles_with_mmcr2_test
> +	=C2=A0cycles_with_mmcr2_test ebb_lmr ebb_lmr_regs
> =C2=A0
> =C2=A0all: $(TEST_PROGS)
> =C2=A0
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c b/tools/te=
sting/selftests/powerpc/pmu/ebb/ebb_lmr.c
> new file mode 100644
> index 0000000..266062b7
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
> @@ -0,0 +1,144 @@
> +/*
> + * Copyright 2016, Jack Miller, IBM Corp.
> + * Licensed under GPLv2.
> + */
> +
> +#include=20
> +#include=20
> +
> +#include "ebb.h"
> +#include "ebb_lmr.h"
> +
> +#define SIZE		(32 * 1024 * 1024)	/* 32M */
> +#define LM_SIZE		0	/* Smallest encoding, 32M */
> +
> +#define SECTIONS	64	/* 1 per bit in LMSER */
> +#define SECTION_SIZE	(SIZE / SECTIONS)
> +#define SECTION_LONGS=C2=A0=C2=A0=C2=A0(SECTION_SIZE / sizeof(long))
> +
> +static unsigned long *test_mem;
> +
> +static int lmr_count =3D 0;
> +
> +void ebb_lmr_handler(void)
> +{
> +	lmr_count++;
> +}
> +
> +void ldmx_full_section(unsigned long *mem, int section)
> +{
> +	unsigned long *ptr;
> +	int i;
> +
> +	for (i =3D 0; i < SECTION_LONGS; i++) {
> +		ptr =3D &mem[(SECTION_LONGS * section) + i];
> +		ldmx((unsigned long) &ptr);
> +		ebb_lmr_reset();
> +	}
> +}
> +
> +unsigned long section_masks[] =3D {
> +	0x8000000000000000,
> +	0xFF00000000000000,
> +	0x0000000F70000000,
> +	0x8000000000000001,
> +	0xF0F0F0F0F0F0F0F0,
> +	0x0F0F0F0F0F0F0F0F,
> +	0x0
> +};
> +
> +int ebb_lmr_section_test(unsigned long *mem)
> +{
> +	unsigned long *mask =3D section_masks;
> +	int i;
> +
> +	for (; *mask; mask++) {
> +		mtspr(SPRN_LMSER, *mask);
> +		printf("Testing mask 0x%016lx\n", mfspr(SPRN_LMSER));
> +
> +		for (i =3D 0; i < 64; i++) {
> +			lmr_count =3D 0;
> +			ldmx_full_section(mem, i);
> +			if (*mask & (1UL << (63 - i)))
> +				FAIL_IF(lmr_count !=3D SECTION_LONGS);
> +			else
> +				FAIL_IF(lmr_count);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int ebb_lmr(void)
> +{
> +	int i;
> +
> +	SKIP_IF(!ebb_is_supported());

We skip this test currently as EBB is not enabled on POWER9.

On POWER8 we enable EBB in the PMU code. Should we do this elsewhere for
POWER9 since EBB doesn't directly require the PMU?

Anyway once I fix that, tests pass.

Mikey

> +	SKIP_IF(!lmr_is_supported());
> +
> +	setup_ebb_handler(ebb_lmr_handler);
> +
> +	ebb_global_enable();
> +
> +	FAIL_IF(posix_memalign((void **)&test_mem, SIZE, SIZE) !=3D 0);
> +
> +	mtspr(SPRN_LMSER, 0);
> +
> +	FAIL_IF(mfspr(SPRN_LMSER) !=3D 0);
> +
> +	mtspr(SPRN_LMRR, ((unsigned long)test_mem | LM_SIZE));
> +
> +	FAIL_IF(mfspr(SPRN_LMRR) !=3D ((unsigned long)test_mem | LM_SIZE));
> +
> +	/* Read every single byte to ensure we get no false positives */
> +	for (i =3D 0; i < SECTIONS; i++)
> +		ldmx_full_section(test_mem, i);
> +
> +	FAIL_IF(lmr_count !=3D 0);
> +
> +	/* Turn on the first section */
> +
> +	mtspr(SPRN_LMSER, (1UL << 63));
> +	FAIL_IF(mfspr(SPRN_LMSER) !=3D (1UL << 63));
> +
> +	/* Enable LM (BESCR) */
> +
> +	mtspr(SPRN_BESCR, mfspr(SPRN_BESCR) | BESCR_LME);
> +	FAIL_IF(!(mfspr(SPRN_BESCR) & BESCR_LME));
> +
> +	ldmx((unsigned long)&test_mem);
> +
> +	FAIL_IF(lmr_count !=3D 1);	// exactly one exception
> +	FAIL_IF(mfspr(SPRN_BESCR) & BESCR_LME);	// LM now disabled
> +	FAIL_IF(!(mfspr(SPRN_BESCR) & BESCR_LMEO));	// occurred bit set
> +
> +	printf("Simple LMR EBB OK\n");
> +
> +	/* This shouldn't cause an EBB since it's been disabled */
> +	ldmx((unsigned long)&test_mem);
> +	FAIL_IF(lmr_count !=3D 1);
> +
> +	printf("LMR disable on EBB OK\n");
> +
> +	ebb_lmr_reset();
> +
> +	/* This should cause an EBB or reset is broken */
> +	ldmx((unsigned long)&test_mem);
> +	FAIL_IF(lmr_count !=3D 2);
> +
> +	printf("LMR reset EBB OK\n");
> +
> +	ebb_lmr_reset();
> +
> +	return ebb_lmr_section_test(test_mem);
> +}
> +
> +int main(void)
> +{
> +	int ret =3D test_harness(ebb_lmr, "ebb_lmr");
> +
> +	if (test_mem)
> +		free(test_mem);
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h b/tools/te=
sting/selftests/powerpc/pmu/ebb/ebb_lmr.h
> new file mode 100644
> index 0000000..7911756
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
> @@ -0,0 +1,39 @@
> +#ifndef _SELFTESTS_POWERPC_PMU_EBB_LMR_H
> +#define _SELFTESTS_POWERPC_PMU_EBB_LMR_H
> +
> +#include "reg.h"
> +
> +#ifndef PPC_FEATURE2_ARCH_3_00
> +#define PPC_FEATURE2_ARCH_3_00 0x00800000
> +#endif
> +
> +#define lmr_is_supported() have_hwcap2(PPC_FEATURE2_ARCH_3_00)
> +
> +static inline void ebb_lmr_reset(void)
> +{
> +	unsigned long bescr =3D mfspr(SPRN_BESCR);
> +	bescr &=3D ~(BESCR_LMEO);
> +	bescr |=3D BESCR_LME;
> +	mtspr(SPRN_BESCR, bescr);
> +}
> +
> +#define LDMX(t, a, b)\
> +=C2=A0=C2=A0=C2=A0=C2=A0(0x7c00026a |\
> +=C2=A0=C2=A0=C2=A0=C2=A0((t & 0x1f) << 21) |\
> +=C2=A0=C2=A0=C2=A0=C2=A0((a & 0x1f) << 16) |\
> +=C2=A0=C2=A0=C2=A0=C2=A0((b & 0x1f) << 11))
> +
> +static inline unsigned long ldmx(unsigned long address)
> +{
> +	unsigned long ret;
> +
> +	asm volatile ("mr 9, %1\r\n"
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0".long " __stringify(LDMX(9, 0, 9)=
) "\r\n"
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"mr %0, 9\r\n":"=3Dr"(ret)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:"r"(address)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:"r9");
> +
> +	return ret;
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c b/too=
ls/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
> new file mode 100644
> index 0000000..d2a4898
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2016, Jack Miller, IBM Corp.
> + * Licensed under GPLv2.
> + */
> +
> +#include=20
> +#include=20
> +#include=20
> +
> +#include "ebb.h"
> +#include "ebb_lmr.h"
> +
> +#define CHECKS 10000
> +
> +int ebb_lmr_regs(void)
> +{
> +	int i;
> +
> +	SKIP_IF(!ebb_is_supported());
> +	SKIP_IF(!lmr_is_supported());
> +
> +	ebb_global_enable();
> +
> +	for (i =3D 0; i < CHECKS; i++) {
> +		mtspr(SPRN_LMRR, i << 25);	// skip size and rsvd bits
> +		mtspr(SPRN_LMSER, i);
> +
> +		FAIL_IF(mfspr(SPRN_LMRR) !=3D (i << 25));
> +		FAIL_IF(mfspr(SPRN_LMSER) !=3D i);
> +	}
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	return test_harness(ebb_lmr_regs, "ebb_lmr_regs");
> +}
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg.h b/tools/testin=
g/selftests/powerpc/pmu/ebb/reg.h
> index 5921b0d..0659a7b 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/reg.h
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/reg.h
> @@ -34,6 +34,11 @@
> =C2=A0
> =C2=A0#define BESCR_PMEO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/* PMU Event-based exception Occurred */
> =C2=A0#define BESCR_PME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x1ul << 32) =
/* PMU Event-based exception Enable */
> +#define BESCR_LME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x1ul << 34) /* Lo=
ad Monitor Enable */
> +#define BESCR_LMEO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x1ul << 2)=C2=A0=C2=A0=
/* Load Monitor Exception Occurred */
> +
> +#define SPRN_LMRR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0813=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/* Load Monitor Region Register */
> +#define SPRN_LMSER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0814=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0/* Load Monitor Section Enable Register */
> =C2=A0
> =C2=A0#define SPRN_PMC1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0771
> =C2=A0#define SPRN_PMC2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0772
