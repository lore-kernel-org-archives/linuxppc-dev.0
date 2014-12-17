Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D55EA1A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 03:42:08 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 16:42:05 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7989817E76CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:31:29 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBHFUsoC48693402
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:30:54 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBHFUrKc027360
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 08:30:53 -0700
Subject: [PATCH v2 0/4] VPHN parsing fixes
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Dec 2014 10:40:46 +0100
Message-ID: <20141217094007.16957.70423.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This series addresses remarks from Ben and Michael (see individual patches).
The most notable changes are:
- the parsing code being pull out into a separate file in patch 3/4. This
  allows to write userland tests like the one below.
- a full rewrite of the parsing logic in patch 4/4

--
#include <stdio.h>
#include <byteswap.h>

typedef unsigned long u64;
typedef unsigned int u32;
typedef unsigned short u16;
typedef enum { false = 0, true } bool;

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define cpu_to_be32(x)		bswap_32(x)
#define be32_to_cpu(x)		bswap_32(x)
#define be16_to_cpup(x)		bswap_16(*x)
#define cpu_to_be64(x)		bswap_64(x)
#else
#define cpu_to_be32(x)		(x)
#define be32_to_cpu(x)		(x)
#define be16_to_cpup(x)		(*x)
#define cpu_to_be64(x)		(x)
#endif

#define pr_debug(...) printf(__VA_ARGS__)

#include "vphn.c"

void print_packed(const long *packed)
{
	char *p = (char*) packed;
	int i;

	printf("\nRegisters:\n");
	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
		printf("0x%016lx\n", packed[i]);

	printf("\nMemory layout:\n");
	for (i = 0; i < 6; i++) {
		printf("0x %02hhx %02hhx %02hhx %02hhx"
		       " %02hhx %02hhx %02hhx %02hhx\n",
		       *(p + 0), *(p + 1), *(p + 2), *(p + 3),
		       *(p + 4), *(p + 5), *(p + 6), *(p + 7));
		p += 8;
	}

	putchar('\n');
}

void print_unpacked(const __be32 *unpacked)
{
	int i;

	printf("\nVPHN associativity:\n");
	for (i = 0; i <= be32_to_cpu(unpacked[0]); i++)
		printf("0x%08x\n", be32_to_cpu(unpacked[i]));

	putchar('\n');
}

int main(int argc, char **argv)
{
	int i;
	struct {
		const char *descr;
		long packed[VPHN_REGISTER_COUNT];
	} data[] = {
		{
			"16-bit and 32-bit",
			0x8001800280038004,
			0x8005800680078008,
			0x000000090000000a,
			0x0000000b0000000c,
			0xffffffffffffffff,
			0xffffffffffffffff
		},
		{
			"filled with 16-bit",
			0x8001800280038004,
			0x8005800680078008,
			0x8009800a800b800c,
			0x800d800e800f8010,
			0x8011801280138014,
			0x8015801680178018,
		},
		{
			"filled with 32-bit",
			0x0000000100000002,
			0x0000000300000004,
			0x0000000500000006,
			0x0000000700000008,
			0x000000090000000a,
			0x0000000b0000000c,
		},
		{
			"32-bit has all ones in 16 lower bits",
			0x0001ffff80028003,
			0xffffffffffffffff,
			0xffffffffffffffff,
			0xffffffffffffffff,
			0xffffffffffffffff,
			0xffffffffffffffff,
		},
		{
			"32-bit accross two 64-bit registers",
			0x8001000000020000,
			0x0003000000048005,
			0xffffffffffffffff,
			0xffffffffffffffff,
			0xffffffffffffffff,
			0xffffffffffffffff,
		},
		{
			"Truncated last 32-bit",
			0x0000000100000002,
			0x0000000300000004,
			0x0000000500000006,
			0x0000000700000008,
			0x000000090000000a,
			0x0000000b800c0bad,
		},
	};

	for (i = 0; i < sizeof(data) / sizeof(data[0]); i++) {
		__be32 unpacked[VPHN_ASSOC_BUFSIZE] = { 0 };
		printf("\n==================================================\n");
		printf("\nSet #%d: %s\n", i, data[i].descr);
		printf("\n==================================================\n");
		print_packed(data[i].packed);
		vphn_unpack_associativity(data[i].packed, unpacked);
		print_unpacked(unpacked);
	}

	return 0;
}

---

Greg Kurz (4):
      powerpc/vphn: clarify the H_HOME_NODE_ASSOCIATIVITY API
      powerpc/vphn: move endianness fixing to vphn_unpack_associativity()
      powerpc/vphn: move VPHN parsing logic to a separate file
      powerpc/vphn: parsing code rewrite


 arch/powerpc/mm/Makefile |    1 +
 arch/powerpc/mm/numa.c   |   55 ++----------------------------------
 arch/powerpc/mm/vphn.c   |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/vphn.h   |   16 +++++++++++
 4 files changed, 90 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/mm/vphn.c
 create mode 100644 arch/powerpc/mm/vphn.h

--
Greg
