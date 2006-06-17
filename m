Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79F7667B26
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:51:14 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1FrjdF-0004OG-M9
	for linuxppc-dev@ozlabs.org; Sat, 17 Jun 2006 17:51:10 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Prevent duplicate lmb reservations for Device Tree blob.
Date: Sat, 17 Jun 2006 17:51:09 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FrjdF-0004OG-M9@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---
We talked about preventing the device tree blob from being
reserved multiple times.   This patch implements it.

 arch/powerpc/kernel/prom.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d77d24a..6290232 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1267,13 +1267,16 @@ static void __init early_reserve_mem(voi
 {
 	u64 base, size;
 	u64 *reserve_map;
+	unsigned long self_base;
+	unsigned long self_size;
 
 	reserve_map = (u64 *)(((unsigned long)initial_boot_params) +
 					initial_boot_params->off_mem_rsvmap);
 
 	/* before we do anything, lets reserve the dt blob */
-	lmb_reserve(__pa((unsigned long)initial_boot_params),
-		    initial_boot_params->totalsize);
+	self_base = __pa((unsigned long)initial_boot_params);
+	self_size = initial_boot_params->totalsize;
+	lmb_reserve(self_base, self_size);
 
 #ifdef CONFIG_PPC32
 	/* 
@@ -1289,6 +1292,9 @@ #ifdef CONFIG_PPC32
 			size_32 = *(reserve_map_32++);
 			if (size_32 == 0)
 				break;
+			/* skip if the reservation is for the blob */
+			if (base_32 == self_base && size_32 == self_size)
+				continue;
 			DBG("reserving: %x -> %x\n", base_32, size_32);
 			lmb_reserve(base_32, size_32);
 		}
@@ -1300,6 +1306,9 @@ #endif
 		size = *(reserve_map++);
 		if (size == 0)
 			break;
+		/* skip if the reservation is for the blob */
+		if (base == self_base && size == self_size)
+			continue;
 		DBG("reserving: %llx -> %llx\n", base, size);
 		lmb_reserve(base, size);
 	}
