Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 639922C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 07:00:05 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] rapidio: update asynchronous discovery initialization
Date: Tue,  9 Oct 2012 15:57:55 -0400
Message-Id: <1349812676-27057-3-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1349812676-27057-1-git-send-email-alexandre.bounine@idt.com>
References: <1349812676-27057-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update discovery process initialization based on Andrew Morton's comments:
https://lkml.org/lkml/2012/10/3/552.

This update processes all enumerating mports first and schedules discovery
work after that. If the initialization routine fails to allocate resources
needed to execute discovery, it abandons discovery for all ports. 

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
---
 drivers/rapidio/rio.c |   75 ++++++++++++++++++++++++++++++------------------
 1 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index d4bd690..c17ae22 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -1275,49 +1275,68 @@ static void __devinit disc_work_handler(struct work_struct *_work)
 	pr_debug("RIO: discovery work for mport %d %s\n",
 		 work->mport->id, work->mport->name);
 	rio_disc_mport(work->mport);
-
-	kfree(work);
 }
 
 int __devinit rio_init_mports(void)
 {
 	struct rio_mport *port;
 	struct rio_disc_work *work;
-	int no_disc = 0;
+	int n = 0;
+
+	if (!next_portid)
+		return -ENODEV;
 
+	/*
+	 * First, run enumerations and check if we need to perform discovery
+	 * on any of the registered mports.
+	 */
 	list_for_each_entry(port, &rio_mports, node) {
 		if (port->host_deviceid >= 0)
 			rio_enum_mport(port);
-		else if (!no_disc) {
-			if (!rio_wq) {
-				rio_wq = alloc_workqueue("riodisc", 0, 0);
-				if (!rio_wq) {
-					pr_err("RIO: unable allocate rio_wq\n");
-					no_disc = 1;
-					continue;
-				}
-			}
-
-			work = kzalloc(sizeof *work, GFP_KERNEL);
-			if (!work) {
-				pr_err("RIO: no memory for work struct\n");
-				no_disc = 1;
-				continue;
-			}
-
-			work->mport = port;
-			INIT_WORK(&work->work, disc_work_handler);
-			queue_work(rio_wq, &work->work);
-		}
+		else
+			n++;
+	}
+
+	if (!n)
+		goto no_disc;
+
+	/*
+	 * If we have mports that require discovery schedule a discovery work
+	 * for each of them. If the code below fails to allocate needed
+	 * resources, exit without error to keep results of enumeration
+	 * process (if any).
+	 * TODO: Implement restart of dicovery process for all or
+	 * individual discovering mports.
+	 */
+	rio_wq = alloc_workqueue("riodisc", 0, 0);
+	if (!rio_wq) {
+		pr_err("RIO: unable allocate rio_wq\n");
+		goto no_disc;
 	}
 
-	if (rio_wq) {
-		pr_debug("RIO: flush discovery workqueue\n");
-		flush_workqueue(rio_wq);
-		pr_debug("RIO: flush discovery workqueue finished\n");
+	work = kcalloc(n, sizeof *work, GFP_KERNEL);
+	if (!work) {
+		pr_err("RIO: no memory for work struct\n");
 		destroy_workqueue(rio_wq);
+		goto no_disc;
 	}
 
+	n = 0;
+	list_for_each_entry(port, &rio_mports, node) {
+		if (port->host_deviceid < 0) {
+			work[n].mport = port;
+			INIT_WORK(&work[n].work, disc_work_handler);
+			queue_work(rio_wq, &work[n].work);
+			n++;
+		}
+	}
+
+	flush_workqueue(rio_wq);
+	pr_debug("RIO: destroy discovery workqueue\n");
+	destroy_workqueue(rio_wq);
+	kfree(work);
+
+no_disc:
 	rio_init();
 
 	return 0;
-- 
1.7.8.4
