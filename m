Return-Path: <anton@samba.org>
Date: Tue, 24 Dec 2013 12:02:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Make 64-bit non-VMX __copy_tofrom_user bi-endian
Message-ID: <20131224120259.454bc44c@kryten>
In-Reply-To: <1387459057.1305.1.camel@concordia>
References: <20131218092957.4a12cbcf@kryten> <20131218211502.034c3eb0@kryten>
 <1387459057.1305.1.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> > To try and catch any screw ups in our ppc64 memcpy and
> > copy_tofrom_user loops, I wrote a quick test:
> > 
> > http://ozlabs.org/~anton/junkcode/validate_kernel_copyloops.tar.gz
> 
> Nice! How's this look?

Love it!

At the moment my other copy_to/from_user tests run against the kernel
(testing we copy all data right up to a page fault and that we return
the correct number of bytes not copied etc). A small signal handler
that walks the exception entries and branches to the handler should be
all it takes to do it completely in userspace.

Anton

> 
> cheers
> 
> 
> selftests: Import Anton's memcpy / copy_tofrom_user tests
> 
> Turn Anton's memcpy / copy_tofrom_user test into something that can
> live in tools/testing/selftests.
> 
> It requires one turd in arch/powerpc/lib/memcpy_64.S, but it's pretty
> harmless IMHO.
> 
> We are sailing very close to the wind with the feature macros. We
> define them to nothing, which currently means we get a few extra nops
> and include the unaligned calls.
> 
> ---
>  arch/powerpc/lib/memcpy_64.S                       |  2 +
>  tools/testing/selftests/powerpc/Makefile           |  2 +-
>  tools/testing/selftests/powerpc/copyloops/Makefile | 29 +++++++
>  .../selftests/powerpc/copyloops/asm/ppc_asm.h      | 86
> +++++++++++++++++++ .../selftests/powerpc/copyloops/asm/processor.h
> |  0 .../selftests/powerpc/copyloops/copyuser_64.S      |  1 +
>  .../selftests/powerpc/copyloops/copyuser_power7.S  |  1 +
>  .../selftests/powerpc/copyloops/memcpy_64.S        |  1 +
>  .../selftests/powerpc/copyloops/memcpy_power7.S    |  1 +
>  .../testing/selftests/powerpc/copyloops/validate.c | 99
> ++++++++++++++++++++++
> tools/testing/selftests/powerpc/utils.h            |  3 + 11 files
> changed, 224 insertions(+), 1 deletion(-) create mode 100644
> tools/testing/selftests/powerpc/copyloops/Makefile create mode 100644
> tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h create mode
> 100644 tools/testing/selftests/powerpc/copyloops/asm/processor.h
> create mode 120000
> tools/testing/selftests/powerpc/copyloops/copyuser_64.S create mode
> 120000 tools/testing/selftests/powerpc/copyloops/copyuser_power7.S
> create mode 120000
> tools/testing/selftests/powerpc/copyloops/memcpy_64.S create mode
> 120000 tools/testing/selftests/powerpc/copyloops/memcpy_power7.S
> create mode 100644
> tools/testing/selftests/powerpc/copyloops/validate.c
> 
> diff --git a/arch/powerpc/lib/memcpy_64.S
> b/arch/powerpc/lib/memcpy_64.S index d2bbbc8..72ad055 100644
> --- a/arch/powerpc/lib/memcpy_64.S
> +++ b/arch/powerpc/lib/memcpy_64.S
> @@ -14,7 +14,9 @@ _GLOBAL(memcpy)
>  BEGIN_FTR_SECTION
>  	std	r3,48(r1)	/* save destination pointer for
> return value */ FTR_SECTION_ELSE
> +#ifndef SELFTEST
>  	b	memcpy_power7
> +#endif
>  ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
>  	PPC_MTOCRF(0x01,r5)
>  	cmpldi	cr1,r5,16
> diff --git a/tools/testing/selftests/powerpc/Makefile
> b/tools/testing/selftests/powerpc/Makefile index bd24ae5..316194f
> 100644 --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror
> -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR 
>  export CC CFLAGS
>  
> -TARGETS = pmu
> +TARGETS = pmu copyloops
>  
>  endif
>  
> diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile
> b/tools/testing/selftests/powerpc/copyloops/Makefile new file mode
> 100644 index 0000000..6f2d3be
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/Makefile
> @@ -0,0 +1,29 @@
> +# The loops are all 64-bit code
> +CFLAGS += -m64
> +CFLAGS += -I$(CURDIR)
> +CFLAGS += -D SELFTEST
> +
> +# Use our CFLAGS for the implicit .S rule
> +ASFLAGS = $(CFLAGS)
> +
> +PROGS := copyuser_64 copyuser_power7 memcpy_64 memcpy_power7
> +EXTRA_SOURCES := validate.c ../harness.c
> +
> +all: $(PROGS)
> +
> +copyuser_64:     CPPFLAGS += -D
> COPY_LOOP=test___copy_tofrom_user_base +copyuser_power7: CPPFLAGS +=
> -D COPY_LOOP=test___copy_tofrom_user_power7 +memcpy_64:
> CPPFLAGS += -D COPY_LOOP=test_memcpy +memcpy_power7:   CPPFLAGS += -D
> COPY_LOOP=test_memcpy_power7 +
> +$(PROGS): $(EXTRA_SOURCES)
> +
> +run_tests: all
> +	@-for PROG in $(PROGS); do \
> +		./$$PROG; \
> +	done;
> +
> +clean:
> +	rm -f $(PROGS) *.o
> +
> +.PHONY: all run_tests clean
> diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
> b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h new file
> mode 100644 index 0000000..ccd9c84
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
> @@ -0,0 +1,86 @@
> +#include <ppc-asm.h>
> +
> +#define CONFIG_ALTIVEC
> +
> +#define r1	1
> +
> +#define vr0     0
> +#define vr1     1
> +#define vr2     2
> +#define vr3     3
> +#define vr4     4
> +#define vr5     5
> +#define vr6     6
> +#define vr7     7
> +#define vr8     8
> +#define vr9     9
> +#define vr10    10
> +#define vr11    11
> +#define vr12    12
> +#define vr13    13
> +#define vr14    14
> +#define vr15    15
> +#define vr16    16
> +#define vr17    17
> +#define vr18    18
> +#define vr19    19
> +#define vr20    20
> +#define vr21    21
> +#define vr22    22
> +#define vr23    23
> +#define vr24    24
> +#define vr25    25
> +#define vr26    26
> +#define vr27    27
> +#define vr28    28
> +#define vr29    29
> +#define vr30    30
> +#define vr31    31
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
> +
> +#define STACKFRAMESIZE	256
> +#define STK_PARAM(i)	(48 + ((i)-3)*8)
> +#define STK_REG(i)	(112 + ((i)-14)*8)
> +
> +#define _GLOBAL(A) FUNC_START(test_ ## A)
> +
> +#define PPC_MTOCRF(A, B)	mtocrf A, B
> +
> +FUNC_START(enter_vmx_usercopy)
> +	li	r3,1
> +	blr
> +
> +FUNC_START(exit_vmx_usercopy)
> +	li	r3,0
> +	blr
> +
> +FUNC_START(enter_vmx_copy)
> +	li	r3,1
> +	blr
> +
> +FUNC_START(exit_vmx_copy)
> +	blr
> +
> +FUNC_START(memcpy_power7)
> +	blr
> +
> +FUNC_START(__copy_tofrom_user_power7)
> +	blr
> +
> +FUNC_START(__copy_tofrom_user_base)
> +	blr
> +
> +#define BEGIN_FTR_SECTION
> +#define FTR_SECTION_ELSE
> +#define ALT_FTR_SECTION_END_IFCLR(x)
> +#define ALT_FTR_SECTION_END(x, y)
> +#define END_FTR_SECTION_IFCLR(x)
> diff --git
> a/tools/testing/selftests/powerpc/copyloops/asm/processor.h
> b/tools/testing/selftests/powerpc/copyloops/asm/processor.h new file
> mode 100644 index 0000000..e69de29 diff --git
> a/tools/testing/selftests/powerpc/copyloops/copyuser_64.S
> b/tools/testing/selftests/powerpc/copyloops/copyuser_64.S new file
> mode 120000 index 0000000..f1c418a --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/copyuser_64.S
> @@ -0,0 +1 @@
> +../../../../../arch/powerpc/lib/copyuser_64.S
> \ No newline at end of file
> diff --git
> a/tools/testing/selftests/powerpc/copyloops/copyuser_power7.S
> b/tools/testing/selftests/powerpc/copyloops/copyuser_power7.S new
> file mode 120000 index 0000000..4786895 --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/copyuser_power7.S
> @@ -0,0 +1 @@
> +../../../../../arch/powerpc/lib/copyuser_power7.S
> \ No newline at end of file
> diff --git a/tools/testing/selftests/powerpc/copyloops/memcpy_64.S
> b/tools/testing/selftests/powerpc/copyloops/memcpy_64.S new file mode
> 120000 index 0000000..cce33fb
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/memcpy_64.S
> @@ -0,0 +1 @@
> +../../../../../arch/powerpc/lib/memcpy_64.S
> \ No newline at end of file
> diff --git
> a/tools/testing/selftests/powerpc/copyloops/memcpy_power7.S
> b/tools/testing/selftests/powerpc/copyloops/memcpy_power7.S new file
> mode 120000 index 0000000..0d6fbfa --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/memcpy_power7.S
> @@ -0,0 +1 @@
> +../../../../../arch/powerpc/lib/memcpy_power7.S
> \ No newline at end of file
> diff --git a/tools/testing/selftests/powerpc/copyloops/validate.c
> b/tools/testing/selftests/powerpc/copyloops/validate.c new file mode
> 100644 index 0000000..1750ff5
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/copyloops/validate.c
> @@ -0,0 +1,99 @@
> +#include <malloc.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +
> +#include "../utils.h"
> +
> +#define MAX_LEN 8192
> +#define MAX_OFFSET 16
> +#define MIN_REDZONE 128
> +#define BUFLEN (MAX_LEN+MAX_OFFSET+2*MIN_REDZONE)
> +#define POISON 0xa5
> +
> +unsigned long COPY_LOOP(void *to, const void *from, unsigned long
> size); +
> +static void do_one(char *src, char *dst, unsigned long src_off,
> +		   unsigned long dst_off, unsigned long len, void
> *redzone,
> +		   void *fill)
> +{
> +	char *srcp, *dstp;
> +	unsigned long ret;
> +	unsigned long i;
> +
> +	srcp = src + MIN_REDZONE + src_off;
> +	dstp = dst + MIN_REDZONE + dst_off;
> +
> +	memset(src, POISON, BUFLEN);
> +	memset(dst, POISON, BUFLEN);
> +	memcpy(srcp, fill, len);
> +
> +	ret = COPY_LOOP(dstp, srcp, len);
> +	if (ret && ret != (unsigned long)dstp) {
> +		printf("(%p,%p,%ld) returned %ld\n", dstp, srcp,
> len, ret);
> +		abort();
> +	}
> +
> +	if (memcmp(dstp, srcp, len)) {
> +		printf("(%p,%p,%ld) miscompare\n", dstp, srcp, len);
> +		printf("src: ");
> +		for (i = 0; i < len; i++)
> +			printf("%02x ", srcp[i]);
> +		printf("\ndst: ");
> +		for (i = 0; i < len; i++)
> +			printf("%02x ", dstp[i]);
> +		printf("\n");
> +		abort();
> +	}
> +
> +	if (memcmp(dst, redzone, dstp - dst)) {
> +		printf("(%p,%p,%ld) redzone before corrupted\n",
> +		       dstp, srcp, len);
> +		abort();
> +	}
> +
> +	if (memcmp(dstp+len, redzone, dst+BUFLEN-(dstp+len))) {
> +		printf("(%p,%p,%ld) redzone after corrupted\n",
> +		       dstp, srcp, len);
> +		abort();
> +	}
> +}
> +
> +int test_copy_loop(void)
> +{
> +	char *src, *dst, *redzone, *fill;
> +	unsigned long len, src_off, dst_off;
> +	unsigned long i;
> +
> +	src = memalign(BUFLEN, BUFLEN);
> +	dst = memalign(BUFLEN, BUFLEN);
> +	redzone = malloc(BUFLEN);
> +	fill = malloc(BUFLEN);
> +
> +	if (!src || !dst || !redzone || !fill) {
> +		fprintf(stderr, "malloc failed\n");
> +		exit(1);
> +	}
> +
> +	memset(redzone, POISON, BUFLEN);
> +
> +	/* Fill with sequential bytes */
> +	for (i = 0; i < BUFLEN; i++)
> +		fill[i] = i & 0xff;
> +
> +	for (len = 1; len < MAX_LEN; len++) {
> +		for (src_off = 0; src_off < MAX_OFFSET; src_off++) {
> +			for (dst_off = 0; dst_off < MAX_OFFSET;
> dst_off++) {
> +				do_one(src, dst, src_off, dst_off,
> len,
> +				       redzone, fill);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	return test_harness(test_copy_loop, str(COPY_LOOP));
> +}
> diff --git a/tools/testing/selftests/powerpc/utils.h
> b/tools/testing/selftests/powerpc/utils.h index 5851c4b..0de0644
> 100644 --- a/tools/testing/selftests/powerpc/utils.h
> +++ b/tools/testing/selftests/powerpc/utils.h
> @@ -31,4 +31,7 @@ do
> {
> \ }							\ } while
> (0) 
> +#define _str(s) #s
> +#define str(s) _str(s)
> +
>  #endif /* _SELFTESTS_POWERPC_UTILS_H */
