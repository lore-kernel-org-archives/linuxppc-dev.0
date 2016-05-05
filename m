Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0nHb04NMzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:54:35 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id gh9so7334017pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 00:54:34 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] powerpc/mm: Ensure "special" zones are empty
Date: Thu,  5 May 2016 17:54:09 +1000
Message-Id: <1462434849-14935-2-git-send-email-oohall@gmail.com>
In-Reply-To: <1462434849-14935-1-git-send-email-oohall@gmail.com>
References: <1462434849-14935-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mm zone mechanism was traditionally used by arch specific code to
partition memory into allocation zones. However there are several zones
that are managed by the mm subsystem rather than the architecture. Most
architectures set the max PFN of these special zones to zero, however on
powerpc we set them to ~0ul. This, in conjunction with a bug in
free_area_init_nodes() results in all of system memory being placed in
ZONE_DEVICE when enabled. Device memory cannot be used for regular kernel
memory allocations so this will cause a kernel panic at boot.

Given the planned addition of more mm managed zones (ZONE_CMA) we should
aim to be consistent with every other architecture and set the max PFN for
these zones to zero.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Cc: linux-mm@kvack.org
---
 arch/powerpc/mm/mem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8f4c19789a38..f0a058ebb6d7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -239,8 +239,14 @@ static int __init mark_nonram_nosave(void)
 
 static bool zone_limits_final;
 
+/*
+ * The memory zones past TOP_ZONE are managed by generic mm code.
+ * These should be set to zero since that's what every other
+ * architecture does.
+ */
 static unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-	[0 ... MAX_NR_ZONES - 1] = ~0UL
+	[0        ... TOP_ZONE     - 1] = ~0UL,
+	[TOP_ZONE ... MAX_NR_ZONES - 1] = 0
 };
 
 /*
-- 
2.5.5
