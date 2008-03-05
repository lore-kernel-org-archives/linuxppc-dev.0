Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 66932DDEFC
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 14:02:11 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1200065pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Mar 2008 19:02:09 -0800 (PST)
Date: Tue, 4 Mar 2008 21:02:04 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: arnd@arndb.de
Subject: [PATCH][POWERPC] Fix of_serial section mismatch warnings
Message-ID: <20080304210204.6fde76c6@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the following section mismatches:

WARNING: drivers/built-in.o(.exit.text+0x5a): Section mismatch in reference from the function of_platform_serial_exit() to the variable .devinit.data:of_platform_serial_driver
The function __exit of_platform_serial_exit() references
a variable __devinitdata of_platform_serial_driver.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/serial/of_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/serial/of_serial.c
+++ linux-2.6/drivers/serial/of_serial.c
@@ -138,7 +138,7 @@ static struct of_device_id __devinitdata
 	{ /* end of list */ },
 };
 
-static struct of_platform_driver __devinitdata of_platform_serial_driver = {
+static struct of_platform_driver of_platform_serial_driver = {
 	.owner = THIS_MODULE,
 	.name = "of_serial",
 	.probe = of_platform_serial_probe,
