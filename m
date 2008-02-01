Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 659F0DDF20
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 08:52:27 +1100 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JVK00E3EY3DE4C0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 01 Feb 2008 14:52:25 -0700 (MST)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JVK0097FY3CMO20@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 01 Feb 2008 14:52:25 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JVK00C6PY3BAW10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 01 Feb 2008 14:52:23 -0700 (MST)
Date: Fri, 01 Feb 2008 14:51:41 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] Fix incorrectly tagged __devinitdata structures
To: jwboyer@gmail.com, paulus@samba.org, linuxppc-dev@ozlabs.org,
	jacmet@gmail.com
Message-id: <20080201215059.18641.74367.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Fix compile errors in the xilinxfb, xsysace and uartlite drivers used
by the Xilinx Virtex platform

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Paul, Josh: this fixes a compile error in mainline.

 drivers/block/xsysace.c   |    2 +-
 drivers/serial/uartlite.c |    2 +-
 drivers/video/xilinxfb.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 78ebfff..1110e1b 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1202,7 +1202,7 @@ static int __devexit ace_of_remove(struct of_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id __devinit ace_of_match[] = {
+static struct of_device_id ace_of_match[] __devinitdata = {
 	{ .compatible = "xilinx,xsysace", },
 	{},
 };
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 8094340..c54a5ad 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -618,7 +618,7 @@ static int __devexit ulite_of_remove(struct of_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id __devinit ulite_of_match[] = {
+static struct of_device_id ulite_of_match[] __devinitdata = {
 	{ .type = "serial", .compatible = "xilinx,uartlite", },
 	{},
 };
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index e38d3b7..c92e99e 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -459,7 +459,7 @@ static int __devexit xilinxfb_of_remove(struct of_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id __devinit xilinxfb_of_match[] = {
+static struct of_device_id xilinxfb_of_match[] __devinitdata = {
 	{ .compatible = "xilinx,ml300-fb", },
 	{},
 };
