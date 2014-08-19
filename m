Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE57B1A043C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:48:07 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4/4] powerpc/powernv: Check OPAL dump calls exist before using
Date: Tue, 19 Aug 2014 14:48:02 +1000
Message-Id: <1408423682-14297-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1408423682-14297-1-git-send-email-mikey@neuling.org>
References: <1408423682-14297-1-git-send-email-mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check that the OPAL_DUMP_READ token exists before initalising the elog
infrastructure.

This avoids littering the OPAL console with:
  "OPAL: Called with bad token 91"

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 85bb8ff..c7577f9 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -423,6 +423,10 @@ void __init opal_platform_dump_init(void)
 {
 	int rc;
 
+	/* ELOG not supported by firmware */
+	if (!opal_check_token(OPAL_DUMP_READ))
+		return;
+
 	dump_kset = kset_create_and_add("dump", NULL, opal_kobj);
 	if (!dump_kset) {
 		pr_warn("%s: Failed to create dump kset\n", __func__);
-- 
1.9.1
