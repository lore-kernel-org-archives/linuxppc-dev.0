Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ww5hH4qcpzDqkx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 05:57:35 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v5OJvQvU028935
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 14:57:27 -0500
Message-ID: <1498334247.31581.93.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/xive: Silence message about VP block allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 24 Jun 2017 14:57:27 -0500
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

There is no reason for that message to be pr_info(), it will be printed
every time we start a KVM guest.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/sysdev/xive/native.c
b/arch/powerpc/sysdev/xive/native.c
index ab9ecce..0f95476b 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -633,8 +633,8 @@ u32 xive_native_alloc_vp_block(u32 max_vcpus)
        if (max_vcpus > (1 << order))
                order++;
 
-       pr_info("VP block alloc, for max VCPUs %d use order %d\n",
-               max_vcpus, order);
+       pr_debug("VP block alloc, for max VCPUs %d use order %d\n",
+                max_vcpus, order);
 
        for (;;) {
                rc = opal_xive_alloc_vp_block(order);
