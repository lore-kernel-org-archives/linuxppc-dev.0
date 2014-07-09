Return-Path: <kmadhu@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E85F91A0009
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 02:08:44 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CE451400F1
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 02:08:44 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kmadhu@linux.vnet.ibm.com>;
 Wed, 9 Jul 2014 21:38:38 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 58F8E1258048
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2014 21:38:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s69GA7Ts64487592
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2014 21:40:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s69G8ZUT005302
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2014 21:38:36 +0530
Message-ID: <53BD68FF.7000307@linux.vnet.ibm.com>
Date: Wed, 09 Jul 2014 21:38:31 +0530
From: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fail remap_4k_pfn() if PFN doesn't fit inside PTE
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


remap_4k_pfn() silently truncates upper bits of input 4K PFN if
it cannot be contained in PTE. This leads invalid memory mapping
and could result in a system crash when the memory is accessed.
This patch fails remap_4k_pfn() and returns -EINVAL if the input
4K PFN cannot be contained in PTE.
Used a helper inline function in the failure case so that the
remap_4k_pfn() macro can still be used in expression contexts.

Signed-off-by: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-hash64-64k.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
index d836d94..10af7f1 100644
--- a/arch/powerpc/include/asm/pte-hash64-64k.h
+++ b/arch/powerpc/include/asm/pte-hash64-64k.h
@@ -74,8 +74,15 @@
 #define pte_pagesize_index(mm, addr, pte)	\
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)

+static inline int bad_4k_pfn(void)
+{
+	WARN_ON(1);
+	return -EINVAL;
+}
+
 #define remap_4k_pfn(vma, addr, pfn, prot)				\
-	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
-			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
+	((pfn >= (1UL << (64 - PTE_RPN_SHIFT))) ? bad_4k_pfn() :	\
+		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
+			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))

 #endif	/* __ASSEMBLY__ */
-- 
2.0.1
