Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8N8B0rXyzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:29:44 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u7A7TTK0014180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:29:33 -0500
Message-ID: <1470814169.3015.100.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Print the kernel load address at the end of prom_init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 10 Aug 2016 17:29:29 +1000
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

This makes it easier to debug crashes that happen very early before
the kernel takes over Open Firmware by allowing us to relate the OF
reported crashing addresses to offsets within the kernel.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6ee4b72..2ea0ea5 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2940,7 +2940,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 
 	/* Don't print anything after quiesce under OPAL, it crashes OFW */
 	if (of_platform != PLATFORM_OPAL) {
-		prom_printf("Booting Linux via __start() ...\n");
+		prom_printf("Booting Linux via __start() @%lx ...\n", kbase);
 		prom_debug("->dt_header_start=0x%x\n", hdr);
 	}
 
