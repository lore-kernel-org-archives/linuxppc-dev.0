Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT71C1jYdzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 20:37:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, keescook@chromium.org, leitao@debian.org,
 labbott@redhat.com, bsingharora@gmail.com, khandual@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash
Date: Thu, 18 May 2017 20:37:31 +1000
Message-Id: <1495103851-14916-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

virt_addr_valid() is supposed to tell you if it's OK to call virt_to_page() on
an address. What this means in practice is that it should only return true for
addresses in the linear mapping which are backed by a valid PFN.

We are failing to properly check that the address is in the linear mapping,
because virt_to_pfn() will return a valid looking PFN for more or less any
address. That bug is actually caused by __pa(), used in virt_to_pfn().

eg: __pa(0xc000000000010000) = 0x10000  # Good
    __pa(0xd000000000010000) = 0x10000  # Bad!
    __pa(0x0000000000010000) = 0x10000  # Bad!

This started happening after commit bdbc29c19b26 ("powerpc: Work around gcc
miscompilation of __pa() on 64-bit") (Aug 2013), where we changed the definition
of __pa() to work around a GCC bug. Prior to that we subtracted PAGE_OFFSET from
the value passed to __pa(), meaning __pa() of a 0xd or 0x0 address would give
you something bogus back.

Until we can verify if that GCC bug is no longer an issue, or come up with
another solution, this commit does the minimal fix to make virt_addr_valid()
work, by explicitly checking that the address is in the linear mapping region.

Fixes: bdbc29c19b26 ("powerpc: Work around gcc miscompilation of __pa() on 64-bit")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/page.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 2a32483c7b6c..8da5d4c1cab2 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,19 @@ extern long long virt_phys_offset;
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * On hash the vmalloc and other regions alias to the kernel region when passed
+ * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() can
+ * return true for some vmalloc addresses, which is incorrect. So explicitly
+ * check that the address is in the kernel region.
+ */
+#define virt_addr_valid(kaddr) (REGION_ID(kaddr) == KERNEL_REGION_ID && \
+				pfn_valid(virt_to_pfn(kaddr)))
+#else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#endif
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
-- 
2.7.4
