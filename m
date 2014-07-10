Return-Path: <kmadhu@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 998001A0158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 18:42:28 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 02D86140141
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 18:42:27 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kmadhu@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 14:12:25 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 190FFE0045
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 14:13:49 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6A8hrck43974828
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 14:13:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6A8gLaC024058
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 14:12:21 +0530
Message-ID: <53BE51EB.5090208@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 14:12:19 +0530
From: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH V2] powerpc: Fail remap_4k_pfn() if PFN doesn't fit inside PTE
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

V2 : Rewritten to avoid helper function as suggested by Stephen Rothwell.
remap_4k_pfn() silently truncates upper bits of input 4K PFN if
it cannot be contained in PTE. This leads invalid memory mapping
and could result in a system crash when the memory is accessed.
This patch fails remap_4k_pfn() and returns -EINVAL if the input
4K PFN cannot be contained in PTE.

Signed-off-by: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-hash64-64k.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
index d836d94..b5178e4 100644
--- a/arch/powerpc/include/asm/pte-hash64-64k.h
+++ b/arch/powerpc/include/asm/pte-hash64-64k.h
@@ -75,7 +75,8 @@
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)

 #define remap_4k_pfn(vma, addr, pfn, prot)				\
-	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
+	WARN_ON((pfn >= (1UL << (64 - PTE_RPN_SHIFT)))) ? -EINVAL :	\
+		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
 			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))

 #endif	/* __ASSEMBLY__ */
-- 
2.0.1
