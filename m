Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E77A2C00E5
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Feb 2014 16:20:44 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s1S5Kd73012685
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Feb 2014 23:20:41 -0600
Message-ID: <1393564838.14012.71.camel@pasglop>
Subject: [PATCH 2/2] powerpc/powernv: Fix indirect XSCOM unmangling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Fri, 28 Feb 2014 16:20:38 +1100
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

We need to unmangle the full address, not just the register
number, and we also need to support the real indirect bit
being set for in-kernel uses.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org> [v3.13]
---
 arch/powerpc/platforms/powernv/opal-xscom.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 4fbf276..4cd2ea6 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -71,11 +71,11 @@ static int opal_xscom_err_xlate(int64_t rc)
 	}
 }
 
-static u64 opal_scom_unmangle(u64 reg)
+static u64 opal_scom_unmangle(u64 addr)
 {
 	/*
 	 * XSCOM indirect addresses have the top bit set. Additionally
-	 * the reset of the top 3 nibbles is always 0.
+	 * the rest of the top 3 nibbles is always 0.
 	 *
 	 * Because the debugfs interface uses signed offsets and shifts
 	 * the address left by 3, we basically cannot use the top 4 bits
@@ -86,10 +86,13 @@ static u64 opal_scom_unmangle(u64 reg)
 	 * conversion here. To leave room for further xscom address
 	 * expansion, we only clear out the top byte
 	 *
+	 * For in-kernel use, we also support the real indirect bit, so
+	 * we test for any of the top 5 bits
+	 *
 	 */
-	if (reg & (1ull << 59))
-		reg = (reg & ~(0xffull << 56)) | (1ull << 63);
-	return reg;
+	if (addr & (0x1full << 59))
+		addr = (addr & ~(0xffull << 56)) | (1ull << 63);
+	return addr;
 }
 
 static int opal_scom_read(scom_map_t map, u64 reg, u64 *value)
@@ -98,8 +101,8 @@ static int opal_scom_read(scom_map_t map, u64 reg, u64 *value)
 	int64_t rc;
 	__be64 v;
 
-	reg = opal_scom_unmangle(reg);
-	rc = opal_xscom_read(m->chip, m->addr + reg, (__be64 *)__pa(&v));
+	reg = opal_scom_unmangle(m->addr + reg);
+	rc = opal_xscom_read(m->chip, reg, (__be64 *)__pa(&v));
 	*value = be64_to_cpu(v);
 	return opal_xscom_err_xlate(rc);
 }
@@ -109,8 +112,8 @@ static int opal_scom_write(scom_map_t map, u64 reg, u64 value)
 	struct opal_scom_map *m = map;
 	int64_t rc;
 
-	reg = opal_scom_unmangle(reg);
-	rc = opal_xscom_write(m->chip, m->addr + reg, value);
+	reg = opal_scom_unmangle(m->addr + reg);
+	rc = opal_xscom_write(m->chip, reg, value);
 	return opal_xscom_err_xlate(rc);
 }
 
