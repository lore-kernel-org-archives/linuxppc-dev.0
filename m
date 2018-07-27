Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cl2y1FMLzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 09:06:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	diana.craciun@nxp.com
Cc: oss@buserror.net,
	leoyang.li@nxp.com,
	bharat.bhushan@nxp.com
Subject: [PATCH v5 1/8] powerpc/64: Disable the speculation barrier from the
 command line
Date: Sat, 28 Jul 2018 09:06:32 +1000
Message-Id: <20180727230639.25413-2-mpe@ellerman.id.au>
In-Reply-To: <20180727230639.25413-1-mpe@ellerman.id.au>
References: <20180727230639.25413-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <diana.craciun@nxp.com>

The speculation barrier can be disabled from the command line
with the parameter: "nospectre_v1".

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

v5: No change.

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4cb8f1f7b593..79f9397998ed 100644
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
2.14.1
