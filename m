Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A2BF1A0222
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 14:31:22 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9602E1400AF
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2014 14:31:21 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s764VGHl009402
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2014 23:31:17 -0500
Message-ID: <1407299476.3073.61.camel@pasglop>
Subject: [PATCH] powerpc/ppc64: Print CPU/MMU/FW features at boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Wed, 06 Aug 2014 14:31:16 +1000
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

Helps debug funky firmware issues

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 93991ed..a06edf6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -451,6 +451,11 @@ void __init setup_system(void)
 	if (ppc64_caches.iline_size != 0x80)
 		printk("ppc64_caches.icache_line_size = 0x%x\n",
 		       ppc64_caches.iline_size);
+	printk("cpu_features                  = 0x%016lx\n", cur_cpu_spec->cpu_features);
+	printk("cpu_user_features             = 0x%08x 0x%08x\n",
+	       cur_cpu_spec->cpu_user_features, cur_cpu_spec->cpu_user_features2);
+	printk("mmu_features                  = 0x%08x\n", cur_cpu_spec->mmu_features);
+	printk("fw_features                   = 0x%016lx\n", powerpc_firmware_features);
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address)
 		printk("htab_address                  = 0x%p\n", htab_address);
