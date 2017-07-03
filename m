Return-Path: <joel.stan@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1D3c1TlTzDr14
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 14:02:04 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c24so9696681pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Jul 2017 21:02:04 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] powerpc/powernv/idle: Put pnv_cpu_offline behind HOTPLUG_CPU
Date: Mon,  3 Jul 2017 13:31:52 +0930
Message-Id: <20170703040152.5144-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 900612315788 ("powerpc/powernv/smp: Add busy-wait loop as fall back
for CPU-Hotplug") the idle code uses generic_check_cpu_restart(), but that
function is not available when CONFIG_HOTPLUG_CPU is disabled.

arch/powerpc/platforms/powernv/idle.c: In function ‘pnv_cpu_offline’:
arch/powerpc/platforms/powernv/idle.c:286:11: error: implicit declaration of
function ‘generic_check_cpu_restart’ [-Werror=implicit-function-declaration]
   while (!generic_check_cpu_restart(cpu)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~

The callers of pnv_cpu_offline are behind CONFIG_HOTPLUG_CPU, so fix the build
error by putting this code behind the same gard.

Fixes: 900612315788 ("powerpc/powernv/smp: Add busy-wait loop as fall back for CPU-Hotplug").
Cc: <stable@vger.kernel.org> # 4.12
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 445f30a2c5ef..b15d108db216 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -261,6 +261,8 @@ static u64 pnv_deepest_stop_psscr_val;
 static u64 pnv_deepest_stop_psscr_mask;
 static bool deepest_stop_found;
 
+#ifdef CONFIG_HOTPLUG_CPU
+
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
@@ -294,6 +296,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 	return srr1;
 }
 
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * Power ISA 3.0 idle initialization.
  *
-- 
2.13.2
