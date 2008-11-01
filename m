Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id EA349DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 11:29:26 +1100 (EST)
Message-ID: <490BA2E5.8010309@consentry.com>
Date: Fri, 31 Oct 2008 17:29:25 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c-cpm: Detect and report NAK right away instead of timing
	out.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the driver report an ENXIO error immediately upon NAK instead of
waiting for another interrupt and getting a timeout.

Signed-off-by: Mike Ditto <mditto@consentry.com>
---
When reading from a device that is not present or declines to respond
to, e.g., a non-existent register address, CPM immediately reports a
NAK condition in the TxBD, but the driver kept waiting until a timeout,
which takes 1 second and causes an ugly console error message.

Index: linux/drivers/i2c/busses/i2c-cpm.c
===================================================================
retrieving revision 1.3
diff -u -p -r1.3 i2c-cpm.c
--- linux/drivers/i2c/busses/i2c-cpm.c	31 Oct 2008 06:36:08 -0000	1.3
+++ linux/drivers/i2c/busses/i2c-cpm.c	1 Nov 2008 00:12:45 -0000
@@ -369,6 +369,7 @@ static int cpm_i2c_xfer(struct i2c_adapt
 		pmsg = &msgs[tptr];
 		if (pmsg->flags & I2C_M_RD)
 			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
+				(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_NAK) ||
 				!(in_be16(&rbdf[rptr].cbd_sc) & BD_SC_EMPTY),
 				1 * HZ);
 		else
