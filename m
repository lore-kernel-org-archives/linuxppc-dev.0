Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1981D1A070B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 17:12:36 +1000 (EST)
Message-ID: <1412320345.30859.9.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix endian bug in LPC bus debugfs accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 03 Oct 2014 17:12:25 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When reading from the LPC, the OPAL FW calls return the value via pointer
to a uint32_t which is always returned big endian. Our internal inb/outb
implementation byteswaps that fine but our debugfs code is still broken.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---

diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index ad4b31d..dd2c285 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -191,6 +191,7 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
 {
 	struct lpc_debugfs_entry *lpc = filp->private_data;
 	u32 data, pos, len, todo;
+	__be32 bedata;
 	int rc;
 
 	if (!access_ok(VERIFY_WRITE, ubuf, count))
@@ -213,9 +214,10 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
 				len = 2;
 		}
 		rc = opal_lpc_read(opal_lpc_chip_id, lpc->lpc_type, pos,
-				   &data, len);
+				   &bedata, len);
 		if (rc)
 			return -ENXIO;
+		data = be32_to_cpu(bedata);
 		switch(len) {
 		case 4:
 			rc = __put_user((u32)data, (u32 __user *)ubuf);
