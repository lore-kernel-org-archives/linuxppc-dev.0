Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A01DDE04A
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 09:01:28 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NM3LU8015956
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:03:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NM1OqE249142
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:01:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NM1N6j013526
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:01:24 -0500
Date: Sat, 23 Feb 2008 16:00:50 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: arnd@arndb.de
Subject: [PATCH 2/2][POWERPC] Ignore disabled serial ports
Message-ID: <20080223160050.4c8e7c68@zod.rchland.ibm.com>
In-Reply-To: <20080223155823.2c85d829@zod.rchland.ibm.com>
References: <20080223155823.2c85d829@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, davem@davemloft.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some SoC chips have multiple serial ports on board.  The usability of these
ports can rely on various factors, ranging from pin sharing to unpopulated
connectors.  This uses the new of_device_is_disabled function to check for
and ignore disabled UARTs.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/legacy_serial.c |    4 ++++
 drivers/serial/of_serial.c          |    5 +++++
 2 files changed, 9 insertions(+)

--- linux-2.6.orig/drivers/serial/of_serial.c
+++ linux-2.6/drivers/serial/of_serial.c
@@ -72,6 +72,11 @@ static int __devinit of_platform_serial_
 	int port_type;
 	int ret;
 
+	if (of_device_is_disabled(ofdev->node)) {
+		dev_info(&ofdev->dev, "Disabled serial port.  Ignored\n");
+		return -ENODEV;
+	}
+
 	if (of_find_property(ofdev->node, "used-by-rtas", NULL))
 		return -EBUSY;
 
--- linux-2.6.orig/arch/powerpc/kernel/legacy_serial.c
+++ linux-2.6/arch/powerpc/kernel/legacy_serial.c
@@ -54,6 +54,10 @@ static int __init add_legacy_port(struct
 	u32 clock = BASE_BAUD * 16;
 	int index;
 
+	/* Check the status property if present.  Ignore disabled devices */
+	if (of_device_is_disabled(np))
+		return -1;
+
 	/* get clock freq. if present */
 	clk = of_get_property(np, "clock-frequency", NULL);
 	if (clk && *clk)
