Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id F3F91DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:14:51 +1000 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPD00E74D298Y40@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:21 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPD00DXYD28J910@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 03 Oct 2007 22:13:21 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPD00M8VD28BX80@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:20 -0600 (MDT)
Date: Wed, 03 Oct 2007 22:13:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] Sysace: Don't enable IRQ until after interrupt handler is
	registered
In-reply-to: <20071004041114.20868.34605.stgit@trillian.cg.shawcable.net>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Message-id: <20071004041328.20868.98483.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071004041114.20868.34605.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The previous patch to move the interrupt handler registration moved it
below enabling interrupts which could be a problem if the device is on
a shared interrupt line.  This patch fixes the order.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 5b73471..9e7652d 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1005,11 +1005,6 @@ static int __devinit ace_setup(struct ace_device *ace)
 	ace_out(ace, ACE_CTRL, ACE_CTRL_FORCECFGMODE |
 		ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ);
 
-	/* Enable interrupts */
-	val = ace_in(ace, ACE_CTRL);
-	val |= ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
-	ace_out(ace, ACE_CTRL, val);
-
 	/* Now we can hook up the irq handler */
 	if (ace->irq != NO_IRQ) {
 		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
@@ -1020,6 +1015,11 @@ static int __devinit ace_setup(struct ace_device *ace)
 		}
 	}
 
+	/* Enable interrupts */
+	val = ace_in(ace, ACE_CTRL);
+	val |= ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
+	ace_out(ace, ACE_CTRL, val);
+
 	/* Print the identification */
 	dev_info(ace->dev, "Xilinx SystemACE revision %i.%i.%i\n",
 		 (version >> 12) & 0xf, (version >> 8) & 0x0f, version & 0xff);
