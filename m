Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37C8E2C032E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 19:19:22 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r9A8JGfq024073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 03:19:18 -0500
Message-ID: <1381393155.4330.40.camel@pasglop>
Subject: [PATCH 3/3] powerpc/powernv: Add support for indirect XSCOM via sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 10 Oct 2013 19:19:15 +1100
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

Indirect XSCOM addresses normally have the top bit set (of the 64-bit
address). This doesn't work via the normal sysfs interface, so we use
a different encoding, which we need to convert before calling OPAL.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-xscom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 09a90d8..23e52f3 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -71,11 +71,33 @@ static int opal_xscom_err_xlate(int64_t rc)
 	}
 }
 
+static u64 opal_scom_unmangle(u64 reg)
+{
+	/*
+	 * XSCOM indirect addresses have the top bit set. Additionally
+	 * the reset of the top 3 nibbles is always 0.
+	 *
+	 * Because the sysfs interface uses signed offsets and shifts
+	 * the address left by 3, we basically cannot use the top 4 bits
+	 * of the 64-bit address, and thus cannot use the indirect bit.
+	 *
+	 * To deal with that, we support the indirect bit being in bit
+	 * 4 (IBM notation) instead of bit 0 in this API, we do the
+	 * conversion here. To leave room for further xscom address
+	 * expansion, we only clear out the top byte
+	 *
+	 */
+	if (reg & (1ull << 59))
+		reg = (reg & ~(0xffull << 56)) | (1ull << 63);
+	return reg;
+}
+
 static int opal_scom_read(scom_map_t map, u64 reg, u64 *value)
 {
 	struct opal_scom_map *m = map;
 	int64_t rc;
 
+	reg = opal_scom_unmangle(reg);
 	rc = opal_xscom_read(m->chip, m->addr + reg, (uint64_t *)__pa(value));
 	return opal_xscom_err_xlate(rc);
 }
@@ -85,6 +107,7 @@ static int opal_scom_write(scom_map_t map, u64 reg, u64 value)
 	struct opal_scom_map *m = map;
 	int64_t rc;
 
+	reg = opal_scom_unmangle(reg);
 	rc = opal_xscom_write(m->chip, m->addr + reg, value);
 	return opal_xscom_err_xlate(rc);
 }
