Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8174B1A1066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:14:52 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 15:14:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6AD3F17D805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:15:02 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1NFEkcT62324776
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:46 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NFEkSQ032232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 08:14:46 -0700
Subject: [PATCH v3 5/5] selftests, powerpc: Add test for VPHN
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Feb 2015 16:14:44 +0100
Message-ID: <20150223151444.21565.65452.stgit@bahia.local>
In-Reply-To: <20150223151412.21565.2251.stgit@bahia.local>
References: <20150223151412.21565.2251.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The goal is to verify vphn_unpack_associativity() parses VPHN numbers
correctly. We feed it with a variety of input values and compare with
expected results.

PAPR+ does not say much about VPHN parsing: I came up with a list of
tests that check many simple cases and some corner ones. I wouldn't
dare to say the list is exhaustive though.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile          |    2 
 tools/testing/selftests/powerpc/utils.h           |    1 
 tools/testing/selftests/powerpc/vphn/.gitignore   |    1 
 tools/testing/selftests/powerpc/vphn/Makefile     |   15 +
 tools/testing/selftests/powerpc/vphn/parse-vphn.c |  403 +++++++++++++++++++++
 tools/testing/selftests/powerpc/vphn/vphn.c       |    1 
 tools/testing/selftests/powerpc/vphn/vphn.h       |    1 
 7 files changed, 423 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/vphn/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/vphn/Makefile
 create mode 100644 tools/testing/selftests/powerpc/vphn/parse-vphn.c
 create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.c
 create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.h

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 1d5e7ad..476b8dd 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CC CFLAGS
 
-TARGETS = pmu copyloops mm tm primitives stringloops
+TARGETS = pmu copyloops mm tm primitives stringloops vphn
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index a93777a..2ec455e 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -15,6 +15,7 @@ typedef   signed long long s64;
 
 /* Just for familiarity */
 typedef uint32_t u32;
+typedef uint16_t u16;
 typedef uint8_t u8;
 
 
diff --git a/tools/testing/selftests/powerpc/vphn/.gitignore b/tools/testing/selftests/powerpc/vphn/.gitignore
new file mode 100644
index 0000000..dd3039a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vphn/.gitignore
@@ -0,0 +1 @@
+parse-vphn
diff --git a/tools/testing/selftests/powerpc/vphn/Makefile b/tools/testing/selftests/powerpc/vphn/Makefile
new file mode 100644
index 0000000..f1f7bd5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vphn/Makefile
@@ -0,0 +1,15 @@
+PROGS := parse-vphn
+
+all: $(PROGS)
+
+$(PROGS): ../harness.c
+
+run_tests: all
+	@-for PROG in $(PROGS); do \
+		./$$PROG; \
+	done;
+
+clean:
+	rm -f $(PROGS) *.o
+
+.PHONY: all run_tests clean
diff --git a/tools/testing/selftests/powerpc/vphn/parse-vphn.c b/tools/testing/selftests/powerpc/vphn/parse-vphn.c
new file mode 100644
index 0000000..49b6c43
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vphn/parse-vphn.c
@@ -0,0 +1,403 @@
+#include <stdio.h>
+#include <byteswap.h>
+#include "utils.h"
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define cpu_to_be32(x)		bswap_32(x)
+#define be32_to_cpu(x)		bswap_32(x)
+#define be16_to_cpup(x)		bswap_16(*x)
+#define cpu_to_be64(x)		bswap_64(x)
+#else
+#define cpu_to_be32(x)		(x)
+#define be32_to_cpu(x)		(x)
+#define be16_to_cpup(x)		(*x)
+#define cpu_to_be64(x)		(x)
+#endif
+
+#include "vphn.c"
+
+static struct test {
+	char *descr;
+	long input[VPHN_REGISTER_COUNT];
+	u32 expected[VPHN_ASSOC_BUFSIZE];
+} all_tests[] = {
+	{
+		"vphn: no data",
+		{
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+		},
+		{
+			0x00000000
+		}
+	},
+	{
+		"vphn: 1 x 16-bit value",
+		{
+			0x8001ffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+		},
+		{
+			0x00000001,
+			0x00000001
+		}
+	},
+	{
+		"vphn: 2 x 16-bit values",
+		{
+			0x80018002ffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+		},
+		{
+			0x00000002,
+			0x00000001,
+			0x00000002
+		}
+	},
+	{
+		"vphn: 3 x 16-bit values",
+		{
+			0x800180028003ffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+		},
+		{
+			0x00000003,
+			0x00000001,
+			0x00000002,
+			0x00000003
+		}
+	},
+	{
+		"vphn: 4 x 16-bit values",
+		{
+			0x8001800280038004,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+		},
+		{
+			0x00000004,
+			0x00000001,
+			0x00000002,
+			0x00000003,
+			0x00000004
+		}
+	},
+	{
+		/* Parsing the next 16-bit value out of the next 64-bit input
+		 * value.
+		 */
+		"vphn: 5 x 16-bit values",
+		{
+			0x8001800280038004,
+			0x8005ffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+		},
+		{
+			0x00000005,
+			0x00000001,
+			0x00000002,
+			0x00000003,
+			0x00000004,
+			0x00000005
+		}
+	},
+	{
+		/* Parse at most 6 x 64-bit input values */
+		"vphn: 24 x 16-bit values",
+		{
+			0x8001800280038004,
+			0x8005800680078008,
+			0x8009800a800b800c,
+			0x800d800e800f8010,
+			0x8011801280138014,
+			0x8015801680178018
+		},
+		{
+			0x00000018,
+			0x00000001,
+			0x00000002,
+			0x00000003,
+			0x00000004,
+			0x00000005,
+			0x00000006,
+			0x00000007,
+			0x00000008,
+			0x00000009,
+			0x0000000a,
+			0x0000000b,
+			0x0000000c,
+			0x0000000d,
+			0x0000000e,
+			0x0000000f,
+			0x00000010,
+			0x00000011,
+			0x00000012,
+			0x00000013,
+			0x00000014,
+			0x00000015,
+			0x00000016,
+			0x00000017,
+			0x00000018
+		}
+	},
+	{
+		"vphn: 1 x 32-bit value",
+		{
+			0x00000001ffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000001,
+			0x00000001
+		}
+	},
+	{
+		"vphn: 2 x 32-bit values",
+		{
+			0x0000000100000002,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000002,
+			0x00000001,
+			0x00000002
+		}
+	},
+	{
+		/* Parsing the next 32-bit value out of the next 64-bit input
+		 * value.
+		 */
+		"vphn: 3 x 32-bit values",
+		{
+			0x0000000100000002,
+			0x00000003ffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000003,
+			0x00000001,
+			0x00000002,
+			0x00000003
+		}
+	},
+	{
+		/* Parse at most 6 x 64-bit input values */
+		"vphn: 12 x 32-bit values",
+		{
+			0x0000000100000002,
+			0x0000000300000004,
+			0x0000000500000006,
+			0x0000000700000008,
+			0x000000090000000a,
+			0x0000000b0000000c
+		},
+		{
+			0x0000000c,
+			0x00000001,
+			0x00000002,
+			0x00000003,
+			0x00000004,
+			0x00000005,
+			0x00000006,
+			0x00000007,
+			0x00000008,
+			0x00000009,
+			0x0000000a,
+			0x0000000b,
+			0x0000000c
+		}
+	},
+	{
+		"vphn: 16-bit value followed by 32-bit value",
+		{
+			0x800100000002ffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000002,
+			0x00000001,
+			0x00000002
+		}
+	},
+	{
+		"vphn: 32-bit value followed by 16-bit value",
+		{
+			0x000000018002ffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000002,
+			0x00000001,
+			0x00000002
+		}
+	},
+	{
+		/* Parse a 32-bit value split accross two consecutives 64-bit
+		 * input values.
+		 */
+		"vphn: 16-bit value followed by 2 x 32-bit values",
+		{
+			0x8001000000020000,
+			0x0003ffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000003,
+			0x00000001,
+			0x00000002,
+			0x00000003,
+			0x00000004,
+			0x00000005
+		}
+	},
+	{
+		/* The lower bits in 0x0001ffff don't get mixed up with the
+		 * 0xffff terminator.
+		 */
+		"vphn: 32-bit value has all ones in 16 lower bits",
+		{
+			0x0001ffff80028003,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff,
+			0xffffffffffffffff
+		},
+		{
+			0x00000003,
+			0x0001ffff,
+			0x00000002,
+			0x00000003
+		}
+	},
+	{
+		/* The following input doesn't follow the specification.
+		 */
+		"vphn: last 32-bit value is truncated",
+		{
+			0x0000000100000002,
+			0x0000000300000004,
+			0x0000000500000006,
+			0x0000000700000008,
+			0x000000090000000a,
+			0x0000000b800c2bad
+		},
+		{
+			0x0000000c,
+			0x00000001,
+			0x00000002,
+			0x00000003,
+			0x00000004,
+			0x00000005,
+			0x00000006,
+			0x00000007,
+			0x00000008,
+			0x00000009,
+			0x0000000a,
+			0x0000000b,
+			0x0000000c
+		}
+	},
+	{
+		"vphn: garbage after terminator",
+		{
+			0xffff2bad2bad2bad,
+			0x2bad2bad2bad2bad,
+			0x2bad2bad2bad2bad,
+			0x2bad2bad2bad2bad,
+			0x2bad2bad2bad2bad,
+			0x2bad2bad2bad2bad
+		},
+		{
+			0x00000000
+		}
+	},
+	{
+		NULL
+	}
+};
+
+static struct test *test;
+
+static int test_vphn(void)
+{
+	__be32 output[VPHN_ASSOC_BUFSIZE] = { 0 };
+	int i, len;
+
+	vphn_unpack_associativity(test->input, output);
+
+	len = be32_to_cpu(output[0]);
+	if (len != test->expected[0]) {
+		printf("expected %d elements, got %d\n", test->expected[0],
+		       len);
+		return 1;
+	}
+
+	for (i = 1; i < len; i++) {
+		u32 val = be32_to_cpu(output[i]);
+		if (val != test->expected[i]) {
+			printf("element #%d is 0x%x, should be 0x%x\n", i, val,
+			       test->expected[i]);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	for (test = all_tests; test->descr; test++) {
+		int ret;
+
+		ret = test_harness(test_vphn, test->descr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/powerpc/vphn/vphn.c b/tools/testing/selftests/powerpc/vphn/vphn.c
new file mode 120000
index 0000000..186b906
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vphn/vphn.c
@@ -0,0 +1 @@
+../../../../../arch/powerpc/mm/vphn.c
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/vphn/vphn.h b/tools/testing/selftests/powerpc/vphn/vphn.h
new file mode 120000
index 0000000..7131efe
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vphn/vphn.h
@@ -0,0 +1 @@
+../../../../../arch/powerpc/mm/vphn.h
\ No newline at end of file
