Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4VyS6msczDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 19:22:40 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id zy2so3772746pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 02:22:40 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bsingharora@gmail.com, Oliver O'Halloran <oohall@gmail.com>,
 linux-mm@kvack.org
Subject: [PATCH v2] powerpc/mm: Ensure "special" zones are empty
Date: Wed, 11 May 2016 19:22:18 +1000
Message-Id: <1462958539-25552-1-git-send-email-oohall@gmail.com>
In-Reply-To: <3r3fQw4Xbnz9t79@ozlabs.org>
References: <3r3fQw4Xbnz9t79@ozlabs.org>
In-Reply-To: <3r3fQw4Xbnz9t79@ozlabs.org>
References: <3r3fQw4Xbnz9t79@ozlabs.org>
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
memory allocations so this will cause a kernel panic at boot. Given the
planned addition of more mm managed zones (ZONE_CMA) we should aim to be
consistent with every other architecture and set the max PFN for these
zones to zero.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org
---
 arch/powerpc/mm/mem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 879e0bc6f82e..f35e6605c422 100644
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
+	[0            ... TOP_ZONE        ] = ~0UL,
+	[TOP_ZONE + 1 ... MAX_NR_ZONES - 1] = 0
 };
 
 /*
-- 
2.5.5
