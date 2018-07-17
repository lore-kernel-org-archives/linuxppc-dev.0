Return-Path: <diana.craciun@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VHcY2VfgzF3Hp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 21:10:03 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v4 1/6] powerpc/fsl: Disable the speculation barrier from the
 command line
Date: Tue, 17 Jul 2018 14:09:52 +0300
Message-Id: <1531825797-14236-2-git-send-email-diana.craciun@nxp.com>
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

The speculation barrier can be disabled from the command line
with the parameter: "nospectre_v1".

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
History:

v2-->v3
- no changes

 arch/powerpc/kernel/security.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index a8b2773..2ebfc5b 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -16,6 +16,7 @@
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 bool barrier_nospec_enabled;
+static bool no_nospec;
 
 static void enable_barrier_nospec(bool enable)
 {
@@ -42,9 +43,18 @@ void setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	enable_barrier_nospec(enable);
+	if (!no_nospec)
+		enable_barrier_nospec(enable);
 }
 
+static int __init handle_nospectre_v1(char *p)
+{
+	no_nospec = true;
+
+	return 0;
+}
+early_param("nospectre_v1", handle_nospectre_v1);
+
 #ifdef CONFIG_DEBUG_FS
 static int barrier_nospec_set(void *data, u64 val)
 {
-- 
2.5.5
