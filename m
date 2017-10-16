Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFkRl6QfmzDrF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 14:33:07 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p9so1130114pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 20:33:07 -0700 (PDT)
Message-ID: <1508124778.10123.3.camel@gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc:selftest update memcmp_64 selftest for
 VMX implementation
From: Cyril Bur <cyrilbur@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Christophe LEROY
 <christophe.leroy@c-s.fr>
Date: Mon, 16 Oct 2017 14:32:58 +1100
In-Reply-To: <1507869000-24336-4-git-send-email-wei.guo.simon@gmail.com>
References: <1507869000-24336-1-git-send-email-wei.guo.simon@gmail.com>
 <1507869000-24336-4-git-send-email-wei.guo.simon@gmail.com>
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

On Fri, 2017-10-13 at 12:30 +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch adjust selftest memcmp_64 so that memcmp selftest can be
> compiled successfully.
> 

Do they not compile at the moment?

> It also adds testcases for:
> - memcmp over 4K bytes size.
> - s1/s2 with different/random offset on 16 bytes boundary.
> - enter/exit_vmx_ops pairness.
> 

This is a great idea, just a thought though - perhaps it might make
more sense to have each condition be tested for in a separate binary
rather than a single binary that tests everything.

> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  4 +-
>  .../selftests/powerpc/stringloops/asm/ppc_asm.h    | 22 +++++
>  .../testing/selftests/powerpc/stringloops/memcmp.c | 98 +++++++++++++++++-----
>  3 files changed, 100 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
> index 80d34a9..51bf6fa 100644
> --- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
> +++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
> @@ -35,11 +35,11 @@
>  	li	r3,0
>  	blr
>  
> -FUNC_START(enter_vmx_copy)
> +FUNC_START(enter_vmx_ops)
>  	li	r3,1
>  	blr
>  
> -FUNC_START(exit_vmx_copy)
> +FUNC_START(exit_vmx_ops)
>  	blr
>  
>  FUNC_START(memcpy_power7)
> diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> index 11bece8..3326992 100644
> --- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> +++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> @@ -1,3 +1,5 @@
> +#ifndef _PPC_ASM_H
> +#define __PPC_ASM_H
>  #include <ppc-asm.h>
>  
>  #ifndef r1
> @@ -5,3 +7,23 @@
>  #endif
>  
>  #define _GLOBAL(A) FUNC_START(test_ ## A)
> +
> +#define CONFIG_ALTIVEC
> +
> +#define R14 r14
> +#define R15 r15
> +#define R16 r16
> +#define R17 r17
> +#define R18 r18
> +#define R19 r19
> +#define R20 r20
> +#define R21 r21
> +#define R22 r22
> +#define R29 r29
> +#define R30 r30
> +#define R31 r31
> +
> +#define STACKFRAMESIZE	256
> +#define STK_REG(i)	(112 + ((i)-14)*8)
> +
> +#endif
> diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
> index 30b1222..f5225f6 100644
> --- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
> +++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
> @@ -1,20 +1,40 @@
>  #include <malloc.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <time.h>
>  #include "utils.h"
>  
>  #define SIZE 256
>  #define ITERATIONS 10000
>  
> +#define LARGE_SIZE (5 * 1024)
> +#define LARGE_ITERATIONS 1000
> +#define LARGE_MAX_OFFSET 32
> +#define LARGE_SIZE_START 4096
> +
> +#define MAX_OFFSET_DIFF_S1_S2 48
> +
> +int vmx_count;
> +int enter_vmx_ops(void)
> +{
> +	vmx_count++;
> +	return 1;
> +}
> +
> +void exit_vmx_ops(void)
> +{
> +	vmx_count--;
> +}
>  int test_memcmp(const void *s1, const void *s2, size_t n);
>  
>  /* test all offsets and lengths */
> -static void test_one(char *s1, char *s2)
> +static void test_one(char *s1, char *s2, unsigned long max_offset,
> +		unsigned long size_start, unsigned long max_size)
>  {
>  	unsigned long offset, size;
>  
> -	for (offset = 0; offset < SIZE; offset++) {
> -		for (size = 0; size < (SIZE-offset); size++) {
> +	for (offset = 0; offset < max_offset; offset++) {
> +		for (size = size_start; size < (max_size - offset); size++) {
>  			int x, y;
>  			unsigned long i;
>  
> @@ -34,70 +54,104 @@ static void test_one(char *s1, char *s2)
>  				printf("\n");
>  				abort();
>  			}
> +
> +			if (vmx_count != 0) {
> +				printf("vmx enter/exit not paired.(offset:%ld size:%ld s1:%p s2:%p vc:%d\n",
> +					offset, size, s1, s2, vmx_count);
> +				printf("\n");
> +				abort();
> +			}
>  		}
>  	}
>  }
>  
> -static int testcase(void)
> +static int testcase(bool islarge)
>  {
>  	char *s1;
>  	char *s2;
>  	unsigned long i;
>  
> -	s1 = memalign(128, SIZE);
> +	unsigned long comp_size = (islarge ? LARGE_SIZE : SIZE);
> +	unsigned long alloc_size = comp_size + MAX_OFFSET_DIFF_S1_S2;
> +	int iterations = islarge ? LARGE_ITERATIONS : ITERATIONS;
> +
> +	s1 = memalign(128, alloc_size);
>  	if (!s1) {
>  		perror("memalign");
>  		exit(1);
>  	}
>  
> -	s2 = memalign(128, SIZE);
> +	s2 = memalign(128, alloc_size);
>  	if (!s2) {
>  		perror("memalign");
>  		exit(1);
>  	}
>  
> -	srandom(1);
> +	srandom(time(0));
>  
> -	for (i = 0; i < ITERATIONS; i++) {
> +	for (i = 0; i < iterations; i++) {
>  		unsigned long j;
>  		unsigned long change;
> +		char *rand_s1 = s1;
> +		char *rand_s2 = s2;
>  
> -		for (j = 0; j < SIZE; j++)
> +		for (j = 0; j < alloc_size; j++)
>  			s1[j] = random();
>  
> -		memcpy(s2, s1, SIZE);
> +		rand_s1 += random() % MAX_OFFSET_DIFF_S1_S2;
> +		rand_s2 += random() % MAX_OFFSET_DIFF_S1_S2;
> +		memcpy(rand_s2, rand_s1, comp_size);
>  
>  		/* change one byte */
> -		change = random() % SIZE;
> -		s2[change] = random() & 0xff;
> -
> -		test_one(s1, s2);
> +		change = random() % comp_size;
> +		rand_s2[change] = random() & 0xff;
> +
> +		if (islarge)
> +			test_one(rand_s1, rand_s2, LARGE_MAX_OFFSET,
> +					LARGE_SIZE_START, comp_size);
> +		else
> +			test_one(rand_s1, rand_s2, SIZE, 0, comp_size);
>  	}
>  
> -	srandom(1);
> +	srandom(time(0));
>  
> -	for (i = 0; i < ITERATIONS; i++) {
> +	for (i = 0; i < iterations; i++) {
>  		unsigned long j;
>  		unsigned long change;
> +		char *rand_s1 = s1;
> +		char *rand_s2 = s2;
>  
> -		for (j = 0; j < SIZE; j++)
> +		for (j = 0; j < alloc_size; j++)
>  			s1[j] = random();
>  
> -		memcpy(s2, s1, SIZE);
> +		rand_s1 += random() % MAX_OFFSET_DIFF_S1_S2;
> +		rand_s2 += random() % MAX_OFFSET_DIFF_S1_S2;
> +		memcpy(rand_s2, rand_s1, comp_size);
>  
>  		/* change multiple bytes, 1/8 of total */
> -		for (j = 0; j < SIZE / 8; j++) {
> -			change = random() % SIZE;
> +		for (j = 0; j < comp_size / 8; j++) {
> +			change = random() % comp_size;
>  			s2[change] = random() & 0xff;
>  		}
>  
> -		test_one(s1, s2);
> +		if (islarge)
> +			test_one(rand_s1, rand_s2, LARGE_MAX_OFFSET,
> +					LARGE_SIZE_START, comp_size);
> +		else
> +			test_one(rand_s1, rand_s2, SIZE, 0, comp_size);
>  	}
>  
>  	return 0;
>  }
>  
> +static int testcases(void)
> +{
> +	testcase(0);
> +	testcase(1);
> +	return 0;
> +}
> +
>  int main(void)
>  {
> -	return test_harness(testcase, "memcmp");
> +	return test_harness(testcases, "memcmp");
>  }
