Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wp63P6S4dzDqLQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:53:21 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: [PATCH] powerpc: Fix /proc/cpuinfo revision for POWER9 DD2
Date: Thu, 15 Jun 2017 11:53:16 +1000
Message-Id: <20170615015316.17070-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The P9 PVR bits 12-15 don't indicate a revision but instead different
chip configurations.  From BookIV we have:
   Bits      Configuration
    0 :    Scale out 12 cores
    1 :    Scale out 24 cores
    2 :    Scale up  12 cores
    3 :    Scale up  24 cores

DD1 doesn't use this but DD2 does. Linux will mostly use the "Scale
out 24 core" configuration (ie. SMT4 not SMT8) which results in a PVR
of 0x004e1200. The reported revision in /proc/cpuinfo is hence
reported incorrectly as "18.0".

This patch fixes this to mask off only the relevant bits for the major
revision (ie. bits 8-11) for POWER9.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/setup-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 857129acf9..94a948207c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -335,6 +335,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				maj = ((pvr >> 8) & 0xFF) - 1;
 				min = pvr & 0xFF;
 				break;
+			case 0x004e: /* POWER9 bits 12-15 give chip type */
+				maj = (pvr >> 8) & 0x0F;
+				min = pvr & 0xFF;
+				break;
 			default:
 				maj = (pvr >> 8) & 0xFF;
 				min = pvr & 0xFF;
-- 
2.11.0
