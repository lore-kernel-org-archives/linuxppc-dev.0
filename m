Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 80CB667C57
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:07:48 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k58MSWIK029888
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:28:32 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58M7kRu022520
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 17:07:47 -0500 (CDT)
Subject: [PATCH 9/10 v2] Prevent duplicate memory reservations for the
	Device Tree blob itself.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149804226.23938.295.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 17:03:46 -0500
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

 arch/powerpc/kernel/prom.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 969f4ab..0a2c2cb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1264,13 +1264,16 @@ static void __init early_reserve_mem(voi
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
@@ -1286,6 +1289,9 @@ #ifdef CONFIG_PPC32
 			size_32 = *(reserve_map_32++);
 			if (size_32 == 0)
 				break;
+			/* skip if the reservation is for the blob */
+			if (base_32 == self_base && size_32 == self_size)
+				continue;
 			DBG("reserving: %x -> %x\n", base_32, size_32);
 			lmb_reserve(base_32, size_32);
 		}
@@ -1297,6 +1303,9 @@ #endif
 		size = *(reserve_map++);
 		if (size == 0)
 			break;
+		/* skip if the reservation is for the blob */
+		if (base == self_base && size == self_size)
+			continue;
 		DBG("reserving: %llx -> %llx\n", base, size);
 		lmb_reserve(base, size);
 	}
