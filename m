Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D4111A02D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 22:49:42 +1100 (AEDT)
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1FE49140188
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 22:49:40 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 11:49:37 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DB2502190046
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 11:49:24 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2HBnYMC11731364
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 11:49:35 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2HBnYGc028963
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 05:49:34 -0600
Date: Tue, 17 Mar 2015 12:49:32 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 5/5] selftests/powerpc: Add test for VPHN
Message-ID: <20150317124932.67fb8296@bahia.local>
In-Reply-To: <1426566089-1351-1-git-send-email-mpe@ellerman.id.au>
References: <20150223151444.21565.65452.stgit@bahia.local>
 <1426566089-1351-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 17 Mar 2015 15:21:29 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
> 
> The goal is to verify vphn_unpack_associativity() parses VPHN numbers
> correctly. We feed it with a variety of input values and compare with
> expected results.
> 
> PAPR+ does not say much about VPHN parsing: I came up with a list of
> tests that check many simple cases and some corner ones. I wouldn't
> dare to say the list is exhaustive though.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> [mpe: Rework harness logic and rename to test-vphn]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> 
> I reworked this a little bit, let me know if it looks OK to you.
> 
> I renamed the test to test-vphn, and I changed the test loop to only call the
> harness once, but report all the individual test results as well.
> 

I guess it is safe to assume we don't have an infinite loop bug hidding in
each individual test case.

I am okay with the changes. I don't know if it is needed but here's my:

Reviewed-by: Greg Kurz <gkurz@linux.vnet.ibm.com>


> 
>  tools/testing/selftests/powerpc/Makefile         |   2 +-
>  tools/testing/selftests/powerpc/utils.h          |   1 +
>  tools/testing/selftests/powerpc/vphn/.gitignore  |   1 +
>  tools/testing/selftests/powerpc/vphn/Makefile    |  13 +
>  tools/testing/selftests/powerpc/vphn/test-vphn.c | 410 +++++++++++++++++++++++
>  tools/testing/selftests/powerpc/vphn/vphn.c      |   1 +
>  tools/testing/selftests/powerpc/vphn/vphn.h      |   1 +
>  7 files changed, 428 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/vphn/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/vphn/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/vphn/test-vphn.c
>  create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.c
>  create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.h
> 
> diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
> index 1d5e7ad2c460..476b8dd9275f 100644
> --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
> 
>  export CC CFLAGS
> 
> -TARGETS = pmu copyloops mm tm primitives stringloops
> +TARGETS = pmu copyloops mm tm primitives stringloops vphn
> 
>  endif
> 
> diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
> index a93777ae0684..2ec455e37792 100644
> --- a/tools/testing/selftests/powerpc/utils.h
> +++ b/tools/testing/selftests/powerpc/utils.h
> @@ -15,6 +15,7 @@ typedef   signed long long s64;
> 
>  /* Just for familiarity */
>  typedef uint32_t u32;
> +typedef uint16_t u16;
>  typedef uint8_t u8;
> 
> 
> diff --git a/tools/testing/selftests/powerpc/vphn/.gitignore b/tools/testing/selftests/powerpc/vphn/.gitignore
> new file mode 100644
> index 000000000000..dd3039a0f638
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/vphn/.gitignore
> @@ -0,0 +1 @@
> +parse-vphn
> diff --git a/tools/testing/selftests/powerpc/vphn/Makefile b/tools/testing/selftests/powerpc/vphn/Makefile
> new file mode 100644
> index 000000000000..4bce3ca9d140
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/vphn/Makefile
> @@ -0,0 +1,13 @@
> +PROG := test-vphn
> +
> +all: $(PROG)
> +
> +$(PROG): ../harness.c
> +
> +run_tests: all
> +	./$(PROG)
> +
> +clean:
> +	rm -f $(PROG)
> +
> +.PHONY: all run_tests clean
> diff --git a/tools/testing/selftests/powerpc/vphn/test-vphn.c b/tools/testing/selftests/powerpc/vphn/test-vphn.c
> new file mode 100644
> index 000000000000..5742f6876b25
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/vphn/test-vphn.c
> @@ -0,0 +1,410 @@
> +#include <stdio.h>
> +#include <byteswap.h>
> +#include "utils.h"
> +#include "subunit.h"
> +
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +#define cpu_to_be32(x)		bswap_32(x)
> +#define be32_to_cpu(x)		bswap_32(x)
> +#define be16_to_cpup(x)		bswap_16(*x)
> +#define cpu_to_be64(x)		bswap_64(x)
> +#else
> +#define cpu_to_be32(x)		(x)
> +#define be32_to_cpu(x)		(x)
> +#define be16_to_cpup(x)		(*x)
> +#define cpu_to_be64(x)		(x)
> +#endif
> +
> +#include "vphn.c"
> +
> +static struct test {
> +	char *descr;
> +	long input[VPHN_REGISTER_COUNT];
> +	u32 expected[VPHN_ASSOC_BUFSIZE];
> +} all_tests[] = {
> +	{
> +		"vphn: no data",
> +		{
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +		},
> +		{
> +			0x00000000
> +		}
> +	},
> +	{
> +		"vphn: 1 x 16-bit value",
> +		{
> +			0x8001ffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +		},
> +		{
> +			0x00000001,
> +			0x00000001
> +		}
> +	},
> +	{
> +		"vphn: 2 x 16-bit values",
> +		{
> +			0x80018002ffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +		},
> +		{
> +			0x00000002,
> +			0x00000001,
> +			0x00000002
> +		}
> +	},
> +	{
> +		"vphn: 3 x 16-bit values",
> +		{
> +			0x800180028003ffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +		},
> +		{
> +			0x00000003,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003
> +		}
> +	},
> +	{
> +		"vphn: 4 x 16-bit values",
> +		{
> +			0x8001800280038004,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +		},
> +		{
> +			0x00000004,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003,
> +			0x00000004
> +		}
> +	},
> +	{
> +		/* Parsing the next 16-bit value out of the next 64-bit input
> +		 * value.
> +		 */
> +		"vphn: 5 x 16-bit values",
> +		{
> +			0x8001800280038004,
> +			0x8005ffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +		},
> +		{
> +			0x00000005,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003,
> +			0x00000004,
> +			0x00000005
> +		}
> +	},
> +	{
> +		/* Parse at most 6 x 64-bit input values */
> +		"vphn: 24 x 16-bit values",
> +		{
> +			0x8001800280038004,
> +			0x8005800680078008,
> +			0x8009800a800b800c,
> +			0x800d800e800f8010,
> +			0x8011801280138014,
> +			0x8015801680178018
> +		},
> +		{
> +			0x00000018,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003,
> +			0x00000004,
> +			0x00000005,
> +			0x00000006,
> +			0x00000007,
> +			0x00000008,
> +			0x00000009,
> +			0x0000000a,
> +			0x0000000b,
> +			0x0000000c,
> +			0x0000000d,
> +			0x0000000e,
> +			0x0000000f,
> +			0x00000010,
> +			0x00000011,
> +			0x00000012,
> +			0x00000013,
> +			0x00000014,
> +			0x00000015,
> +			0x00000016,
> +			0x00000017,
> +			0x00000018
> +		}
> +	},
> +	{
> +		"vphn: 1 x 32-bit value",
> +		{
> +			0x00000001ffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000001,
> +			0x00000001
> +		}
> +	},
> +	{
> +		"vphn: 2 x 32-bit values",
> +		{
> +			0x0000000100000002,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000002,
> +			0x00000001,
> +			0x00000002
> +		}
> +	},
> +	{
> +		/* Parsing the next 32-bit value out of the next 64-bit input
> +		 * value.
> +		 */
> +		"vphn: 3 x 32-bit values",
> +		{
> +			0x0000000100000002,
> +			0x00000003ffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000003,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003
> +		}
> +	},
> +	{
> +		/* Parse at most 6 x 64-bit input values */
> +		"vphn: 12 x 32-bit values",
> +		{
> +			0x0000000100000002,
> +			0x0000000300000004,
> +			0x0000000500000006,
> +			0x0000000700000008,
> +			0x000000090000000a,
> +			0x0000000b0000000c
> +		},
> +		{
> +			0x0000000c,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003,
> +			0x00000004,
> +			0x00000005,
> +			0x00000006,
> +			0x00000007,
> +			0x00000008,
> +			0x00000009,
> +			0x0000000a,
> +			0x0000000b,
> +			0x0000000c
> +		}
> +	},
> +	{
> +		"vphn: 16-bit value followed by 32-bit value",
> +		{
> +			0x800100000002ffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000002,
> +			0x00000001,
> +			0x00000002
> +		}
> +	},
> +	{
> +		"vphn: 32-bit value followed by 16-bit value",
> +		{
> +			0x000000018002ffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000002,
> +			0x00000001,
> +			0x00000002
> +		}
> +	},
> +	{
> +		/* Parse a 32-bit value split accross two consecutives 64-bit
> +		 * input values.
> +		 */
> +		"vphn: 16-bit value followed by 2 x 32-bit values",
> +		{
> +			0x8001000000020000,
> +			0x0003ffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000003,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003,
> +			0x00000004,
> +			0x00000005
> +		}
> +	},
> +	{
> +		/* The lower bits in 0x0001ffff don't get mixed up with the
> +		 * 0xffff terminator.
> +		 */
> +		"vphn: 32-bit value has all ones in 16 lower bits",
> +		{
> +			0x0001ffff80028003,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff,
> +			0xffffffffffffffff
> +		},
> +		{
> +			0x00000003,
> +			0x0001ffff,
> +			0x00000002,
> +			0x00000003
> +		}
> +	},
> +	{
> +		/* The following input doesn't follow the specification.
> +		 */
> +		"vphn: last 32-bit value is truncated",
> +		{
> +			0x0000000100000002,
> +			0x0000000300000004,
> +			0x0000000500000006,
> +			0x0000000700000008,
> +			0x000000090000000a,
> +			0x0000000b800c2bad
> +		},
> +		{
> +			0x0000000c,
> +			0x00000001,
> +			0x00000002,
> +			0x00000003,
> +			0x00000004,
> +			0x00000005,
> +			0x00000006,
> +			0x00000007,
> +			0x00000008,
> +			0x00000009,
> +			0x0000000a,
> +			0x0000000b,
> +			0x0000000c
> +		}
> +	},
> +	{
> +		"vphn: garbage after terminator",
> +		{
> +			0xffff2bad2bad2bad,
> +			0x2bad2bad2bad2bad,
> +			0x2bad2bad2bad2bad,
> +			0x2bad2bad2bad2bad,
> +			0x2bad2bad2bad2bad,
> +			0x2bad2bad2bad2bad
> +		},
> +		{
> +			0x00000000
> +		}
> +	},
> +	{
> +		NULL
> +	}
> +};
> +
> +static int test_one(struct test *test)
> +{
> +	__be32 output[VPHN_ASSOC_BUFSIZE] = { 0 };
> +	int i, len;
> +
> +	vphn_unpack_associativity(test->input, output);
> +
> +	len = be32_to_cpu(output[0]);
> +	if (len != test->expected[0]) {
> +		printf("expected %d elements, got %d\n", test->expected[0],
> +		       len);
> +		return 1;
> +	}
> +
> +	for (i = 1; i < len; i++) {
> +		u32 val = be32_to_cpu(output[i]);
> +		if (val != test->expected[i]) {
> +			printf("element #%d is 0x%x, should be 0x%x\n", i, val,
> +			       test->expected[i]);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int test_vphn(void)
> +{
> +	static struct test *test;
> +
> +	for (test = all_tests; test->descr; test++) {
> +		int ret;
> +
> +		ret = test_one(test);
> +		test_finish(test->descr, ret);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	return test_harness(test_vphn, "test-vphn");
> +}
> diff --git a/tools/testing/selftests/powerpc/vphn/vphn.c b/tools/testing/selftests/powerpc/vphn/vphn.c
> new file mode 120000
> index 000000000000..186b906e66d5
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/vphn/vphn.c
> @@ -0,0 +1 @@
> +../../../../../arch/powerpc/mm/vphn.c
> \ No newline at end of file
> diff --git a/tools/testing/selftests/powerpc/vphn/vphn.h b/tools/testing/selftests/powerpc/vphn/vphn.h
> new file mode 120000
> index 000000000000..7131efe38c65
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/vphn/vphn.h
> @@ -0,0 +1 @@
> +../../../../../arch/powerpc/mm/vphn.h
> \ No newline at end of file
