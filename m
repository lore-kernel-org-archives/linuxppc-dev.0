Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHtHD3qzqzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 19:32:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Fix mapped range information print during boot
In-Reply-To: <20170428142445.17615-1-khandual@linux.vnet.ibm.com>
References: <20170428142445.17615-1-khandual@linux.vnet.ibm.com>
Date: Wed, 03 May 2017 19:32:35 +1000
Message-ID: <87o9vauvyk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> This is a trivial fix patch regarding mapped ranges in radix MMU
> environment during boot. No functional change.
>
> Before the patch:
>
> $dmesg | grep Mapped
> [    0.000000] Mapped range 0x0 - 0x2000000000 with 0x40000000
> [    0.000000] Mapped range 0x200000000000 - 0x202000000000 with 0x40000000
>
> After the patch:
>
> $dmesg | grep Mapped
> [    0.000000] Mapped range 0x0000000000000000 - 0x0000002000000000 with 1024 MB
> [    0.000000] Mapped range 0x0000200000000000 - 0x0000202000000000 with 1024 MB

It's a bit better, how about this instead?

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c28165d8970b..519cfef569d1 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -8,9 +8,14 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+
+#define pr_fmt(fmt) "radix-mmu: " fmt
+
+#include <linux/kernel.h>
 #include <linux/sched/mm.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/string_helpers.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -112,10 +117,14 @@ static inline void __meminit print_mapping(unsigned long start,
 					   unsigned long end,
 					   unsigned long size)
 {
+	char buf[10];
+
 	if (end <= start)
 		return;
 
-	pr_info("Mapped range 0x%lx - 0x%lx with 0x%lx\n", start, end, size);
+	string_get_size(size, 1, STRING_UNITS_2, buf, sizeof(buf));
+
+	pr_info("Mapped 0x%016lx-0x%016lx with %s pages\n", start, end, buf);
 }
 
 static int __meminit create_physical_mapping(unsigned long start,


cheers
