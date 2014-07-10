Return-Path: <kmadhu@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D0841A0197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jul 2014 01:15:37 +1000 (EST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A838F140127
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2014 01:15:36 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kmadhu@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 20:45:34 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0D114125805F
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 20:45:15 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6AFGr6h60293238
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 20:46:54 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6AFFIlb031605
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 20:45:19 +0530
Message-ID: <53BEAE01.7000401@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 20:45:13 +0530
From: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH V3] powerpc : Fail remap_4k_pfn() if PFN doesn't fit inside PTE
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

remap_4k_pfn() silently truncates upper bits of input 4K PFN
if it cannot be contained in PTE. This leads invalid memory mapping and could
result in a system crash when the memory is accessed. This patch fails
remap_4k_pfn() and returns -EINVAL if the input 4K PFN cannot be contained in
PTE.

V3 : Added parentheses to protect 'pfn' and entire macro as suggested by Brian.
V2 : Rewritten to avoid helper function as suggested by Stephen Rothwell.

Signed-off-by: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-hash64-64k.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
index d836d94..b6d2d42 100644
--- a/arch/powerpc/include/asm/pte-hash64-64k.h
+++ b/arch/powerpc/include/asm/pte-hash64-64k.h
@@ -75,7 +75,8 @@
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)

 #define remap_4k_pfn(vma, addr, pfn, prot)				\
-	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
-			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
+	(WARN_ON(((pfn) >= (1UL << (64 - PTE_RPN_SHIFT)))) ? -EINVAL :	\
+		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
+			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))

 #endif	/* __ASSEMBLY__ */
-- 
2.0.1
