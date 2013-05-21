Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 298D12C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 13:23:28 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4L3NOwS032747
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 22:23:25 -0500
Message-ID: <1369106602.6387.35.camel@pasglop>
Subject: [PATCH] powerpc: Fix TLB cleanup at boot on POWER8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 21 May 2013 13:23:22 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TLB has 512 congruence classes (2048 entries 4 way set associative)
while P7 had 128

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/cpu_setup_power.S |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index a283b64..18b5b9c 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -135,8 +135,12 @@ __init_HFSCR:
 	blr
 
 __init_TLB:
-	/* Clear the TLB */
-	li	r6,128
+	/*
+	 * Clear the TLB using the "IS 3" form of tlbiel instruction
+	 * (invalidate by congruence class). P7 has 128 CCs, P8 has 512
+	 * so we just always do 512
+	 */
+	li	r6,512
 	mtctr	r6
 	li	r7,0xc00	/* IS field = 0b11 */
 	ptesync
