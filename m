Return-Path: <diana.craciun@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Ccj6k0RzF3fx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 22:53:41 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v2 3/3] powerpc/fsl: Implement cpu_show_spectre_v1/v2 for NXP
 PowerPC Book3E
Date: Mon, 11 Jun 2018 15:53:28 +0300
Message-Id: <1528721608-15443-4-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/Kconfig           |  2 +-
 arch/powerpc/kernel/security.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 940c955..a781d60 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -170,7 +170,7 @@ config PPC
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64 || PPC_FSL_BOOK3E
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 797c975..aceaadc 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -183,3 +183,18 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (barrier_nospec_enabled)
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
-- 
2.5.5
