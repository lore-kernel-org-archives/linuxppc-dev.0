Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 222AC2C0426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 16:57:04 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7T6uxrn011193
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 01:57:00 -0500
Message-ID: <1377759419.4028.26.camel@pasglop>
Subject: [PATCH] powerpc/scom: Create debugfs files using ibm,chip-id if
 available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 16:56:59 +1000
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

When creating the debugfs scom files, use "ibm,chip-id" as the scom%d
index rather than a simple made up number when possible.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/scom.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index 413622d..cb20d54 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -196,8 +196,13 @@ static int scom_debug_init(void)
 		return -1;
 
 	i = rc = 0;
-	for_each_node_with_property(dn, "scom-controller")
-		rc |= scom_debug_init_one(root, dn, i++);
+	for_each_node_with_property(dn, "scom-controller") {
+		int id = of_get_ibm_chip_id(dn);
+		if (id == -1)
+			id = i;
+		rc |= scom_debug_init_one(root, dn, id);
+		i++;
+	}
 
 	return rc;
 }
