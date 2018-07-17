Return-Path: <diana.craciun@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VHcZ49GKzF3Hp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 21:10:06 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v4 4/6] powerpc/fsl: Enable cpu vulnerabilities reporting for
 NXP PPC BOOK3E
Date: Tue, 17 Jul 2018 14:09:55 +0300
Message-Id: <1531825797-14236-5-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
References: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NXP PPC Book3E platforms are not vulnerable to meltdown and
Spectre v4, so make them PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
History:

v2-->v3
- used the existing functions for spectre v1/v2

 arch/powerpc/Kconfig           | 7 ++++++-
 arch/powerpc/kernel/security.c | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75f..116c953 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -165,7 +165,7 @@ config PPC
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
+	select GENERIC_CPU_VULNERABILITIES	if PPC_NOSPEC
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_SMP_IDLE_THREAD
@@ -240,6 +240,11 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 
+config PPC_NOSPEC
+    bool
+    default y
+    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
+
 config GENERIC_CSUM
 	def_bool n
 
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 3a4e5c3..539c744 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -92,6 +92,7 @@ static __init int barrier_nospec_debugfs_init(void)
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
@@ -124,6 +125,7 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	return sprintf(buf, "Vulnerable\n");
 }
+#endif
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.5.5
