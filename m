Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 430FB2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 11:30:57 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q9M0UpdT003774
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2012 19:30:53 -0500
Message-ID: <1350865852.2476.143.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix OPAL debug entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 22 Oct 2012 11:30:52 +1100
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

OPAL provides the firmware base/entry in registers at boot time
for debugging purposes. We had a bug in the code trying to stash
these into the appropriate kernel globals (a line of code was
probably dropped by accident back when this was merged)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/head_64.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 58bddee..694e3fa 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -703,6 +703,7 @@ _INIT_STATIC(start_here_multiplatform)
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
 	/* Setup OPAL entry */
+	LOAD_REG_ADDR(r11, opal)
 	std	r28,0(r11);
 	std	r29,8(r11);
 #endif
