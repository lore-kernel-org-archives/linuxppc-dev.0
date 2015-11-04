Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA0A61A03BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 13:25:19 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 796FD141349
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2015 13:25:19 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 4 Nov 2015 12:25:18 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D0B192CE8050
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2015 13:25:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA42P6Kc11534458
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2015 13:25:14 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA42OfMY020141
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2015 13:24:42 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, imunsie@au1.ibm.com
Subject: [PATCH] cxl: use correct operator when writing pcie config space
 values
Date: Wed,  4 Nov 2015 13:24:09 +1100
Message-Id: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When writing a value to config space, cxl_pcie_write_config() calls
cxl_pcie_config_info() to obtain a mask and shift value, shifts the new
value accordingly, then uses the mask to combine the shifted value with the
existing value at the address as part of a read-modify-write pattern.

Currently, we use a logical OR operator rather than a bitwise OR operator,
which means any use of this function results in an incorrect value being
written. Replace the logical OR operator with a bitwise OR operator so the
value is written correctly.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/vphb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 94b5208..9be09bb 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -203,7 +203,7 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 	mask <<= shift;
 	val <<= shift;
 
-	v = (in_le32(ioaddr) & ~mask) || (val & mask);
+	v = (in_le32(ioaddr) & ~mask) | (val & mask);
 
 	out_le32(ioaddr, v);
 	return PCIBIOS_SUCCESSFUL;
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
