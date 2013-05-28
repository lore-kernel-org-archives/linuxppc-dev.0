Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC55F2C0337
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 18:00:28 +1000 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/sysfs: disable hotplug for the boot cpu
Date: Tue, 28 May 2013 15:59:44 +0800
Message-ID: <1369727984-21505-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
References: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some features depend on the boot cpu, for instance, hibernate/suspend.
So disable hotplug for the boot cpu.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 arch/powerpc/kernel/sysfs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index e68a845..294b1c4e 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -655,8 +655,10 @@ static int __init topology_init(void)
 		 * CPU.  For instance, the boot cpu might never be valid
 		 * for hotplugging.
 		 */
-		if (ppc_md.cpu_die)
+		if (ppc_md.cpu_die && cpu != boot_cpuid)
 			c->hotpluggable = 1;
+		else
+			c->hotpluggable = 0;
 
 		if (cpu_online(cpu) || c->hotpluggable) {
 			register_cpu(c, cpu);
-- 
1.7.3
