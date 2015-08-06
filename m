Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E1731A0808
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 23:05:20 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CEB6A1402BD
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 23:05:19 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 18:35:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EEC0F1258063
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 18:38:23 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t76D5CTX5308890
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 18:35:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t76D597s012876
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 18:35:10 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH] powerpc/prom: Use DRCONF flags while processing detected LMBs
Date: Thu,  6 Aug 2015 18:35:07 +0530
Message-Id: <1438866307-19637-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch just replaces hard coded values with existing
DRCONF flags while procesing detected LMBs from the device
tree. This does not change any functionality.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 8b888b1..70a8cab 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -476,9 +476,10 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 		flags = of_read_number(&dm[3], 1);
 		/* skip DRC index, pad, assoc. list index, flags */
 		dm += 4;
-		/* skip this block if the reserved bit is set in flags (0x80)
-		   or if the block is not assigned to this partition (0x8) */
-		if ((flags & 0x80) || !(flags & 0x8))
+		/* skip this block if the reserved bit is set in flags
+		   or if the block is not assigned to this partition */
+		if ((flags & DRCONF_MEM_RESERVED) ||
+				!(flags & DRCONF_MEM_ASSIGNED))
 			continue;
 		size = memblock_size;
 		rngs = 1;
-- 
2.1.0
