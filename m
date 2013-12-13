Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D6E942C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 15:56:13 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id rBD4u8jb000519
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 22:56:09 -0600
Message-ID: <1386910566.15730.77.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix OPAL LPC access in Little Endian
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 13 Dec 2013 15:56:06 +1100
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

We are passing pointers to the firmware for reads, we need to properly
convert the result as OPAL is always BE.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index e7e59e4..79d83ca 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -24,25 +24,25 @@ static int opal_lpc_chip_id = -1;
 static u8 opal_lpc_inb(unsigned long port)
 {
 	int64_t rc;
-	uint32_t data;
+	__be32 data;
 
 	if (opal_lpc_chip_id < 0 || port > 0xffff)
 		return 0xff;
 	rc = opal_lpc_read(opal_lpc_chip_id, OPAL_LPC_IO, port, &data, 1);
-	return rc ? 0xff : data;
+	return rc ? 0xff : be32_to_cpu(data);
 }
 
 static __le16 __opal_lpc_inw(unsigned long port)
 {
 	int64_t rc;
-	uint32_t data;
+	__be32 data;
 
 	if (opal_lpc_chip_id < 0 || port > 0xfffe)
 		return 0xffff;
 	if (port & 1)
 		return (__le16)opal_lpc_inb(port) << 8 | opal_lpc_inb(port + 1);
 	rc = opal_lpc_read(opal_lpc_chip_id, OPAL_LPC_IO, port, &data, 2);
-	return rc ? 0xffff : data;
+	return rc ? 0xffff : be32_to_cpu(data);
 }
 static u16 opal_lpc_inw(unsigned long port)
 {
@@ -52,7 +52,7 @@ static u16 opal_lpc_inw(unsigned long port)
 static __le32 __opal_lpc_inl(unsigned long port)
 {
 	int64_t rc;
-	uint32_t data;
+	__be32 data;
 
 	if (opal_lpc_chip_id < 0 || port > 0xfffc)
 		return 0xffffffff;
@@ -62,7 +62,7 @@ static __le32 __opal_lpc_inl(unsigned long port)
 		       (__le32)opal_lpc_inb(port + 2) <<  8 |
 			       opal_lpc_inb(port + 3);
 	rc = opal_lpc_read(opal_lpc_chip_id, OPAL_LPC_IO, port, &data, 4);
-	return rc ? 0xffffffff : data;
+	return rc ? 0xffffffff : be32_to_cpu(data);
 }
 
 static u32 opal_lpc_inl(unsigned long port)
