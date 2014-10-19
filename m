Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3CDC1A0344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 08:51:30 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org
Subject: [PATCH] powerpc/pseries: Quieten relocation on exceptions warning
Date: Mon, 20 Oct 2014 08:51:29 +1100
Message-Id: <1413755489-28682-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hypervisor returns H_P2 if relocation on exceptions are
not supported. If we get this, just print a lower priority
informational message.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/setup.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 125c589..fcc9227 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -499,7 +499,11 @@ static void __init pSeries_setup_arch(void)
 
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		long rc;
-		if ((rc = pSeries_enable_reloc_on_exc()) != H_SUCCESS) {
+
+		rc = pSeries_enable_reloc_on_exc();
+		if (rc == H_P2) {
+			pr_info("Relocation on exceptions not supported\n");
+		} else if (rc != H_SUCCESS) {
 			pr_warn("Unable to enable relocation on exceptions: "
 				"%ld\n", rc);
 		}
-- 
1.9.1
