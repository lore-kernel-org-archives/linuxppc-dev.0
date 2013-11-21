Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42A622C0146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 13:17:14 +1100 (EST)
Received: by mail-pd0-f177.google.com with SMTP id q10so5269597pdj.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 18:17:11 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: mm: use macro PGTABLE_EADDR_SIZE instead of
 digital
Date: Thu, 21 Nov 2013 10:17:54 +0800
Message-Id: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case of extending the eaddr in future, use this macro
PGTABLE_EADDR_SIZE to ease the maintenance of the code.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 17aa6df..e0b3cf4 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -35,7 +35,7 @@ _GLOBAL(slb_allocate_realmode)
 	 * check for bad kernel/user address
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
 	 */
-	rldicr. r9,r3,4,(63 - 46 - 4)
+	rldicr. r9,r3,4,(63 - PGTABLE_EADDR_SIZE - 4)
 	bne-	8f
 
 	srdi	r9,r3,60		/* get region */
-- 
1.8.1.4
