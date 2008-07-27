Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id E9FE2DDFA0
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:25:12 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/6] register_cpu_online should be __cpuinit
Date: Sun, 27 Jul 2008 00:24:51 -0500
Message-Id: <1217136295-18693-3-git-send-email-ntl@pobox.com>
In-Reply-To: <1217136295-18693-1-git-send-email-ntl@pobox.com>
References: <1217136295-18693-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is called only in cpu online paths.

(caught by CONFIG_DEBUG_SECTION_MISMATCH=y)

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 800e5e9..1568080 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -298,7 +298,7 @@ static struct sysdev_attribute pa6t_attrs[] = {
 };
 
 
-static void register_cpu_online(unsigned int cpu)
+static void __cpuinit register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
-- 
1.5.6.2
