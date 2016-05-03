Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWQ6xFGzDqmF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:26 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C8A6A2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UFp460031062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436ToML023271
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:51 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 4/7] powerpc/mm: Set MAX_ZONE_PFN to 0 for all zones beyond
 TOP_ZONE
Date: Tue,  3 May 2016 11:59:23 +0530
Message-Id: <1462256966-19321-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Oliver O'Halloran <oohall@gmail.com>

All the memory zones past TOP_ZONE are managed by generic mm code. Zone
max PFN should be set to 0 instead of ~0UL since that's what the generic
mm code expects. Without this, kernel assigns all pages into ZONE_DEVICE
zone which is not part of buddy allocator, hence kernel cannot allocate
any memory and even fails to boot.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/mem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index bcaede4..19d2c62 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -242,8 +242,14 @@ static int __init mark_nonram_nosave(void)
 
 static bool zone_limits_final;
 
+/*
+ * The memory zones past TOP_ZONE are managed by generic mm code.
+ * Zone max PFN should be set to 0 instead of ~0UL since that's
+ * what the generic mm code expects.
+ */
 static unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-	[0 ... MAX_NR_ZONES - 1] = ~0UL
+	[0        ... TOP_ZONE     - 1] = ~0UL,
+	[TOP_ZONE ... MAX_NR_ZONES - 1] = 0
 };
 
 /*
-- 
1.8.3.1
