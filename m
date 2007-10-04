Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8AAF1DDE21
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:13:38 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPD00IYRD24BWB0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:16 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPD00ER3D24XO30@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 03 Oct 2007 22:13:16 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPD008M4D23Z5S1@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:13:16 -0600 (MDT)
Date: Wed, 03 Oct 2007 22:13:23 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/3] Sysace: sparse fixes
In-reply-to: <20071004041114.20868.34605.stgit@trillian.cg.shawcable.net>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Message-id: <20071004041323.20868.70997.stgit@trillian.cg.shawcable.net>
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

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 3847464..5b73471 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -195,7 +195,7 @@ struct ace_device {
 
 	/* Details of hardware device */
 	unsigned long physaddr;
-	void *baseaddr;
+	void __iomem *baseaddr;
 	int irq;
 	int bus_width;		/* 0 := 8 bit; 1 := 16 bit */
 	struct ace_reg_ops *reg_ops;
@@ -227,20 +227,20 @@ struct ace_reg_ops {
 /* 8 Bit bus width */
 static u16 ace_in_8(struct ace_device *ace, int reg)
 {
-	void *r = ace->baseaddr + reg;
+	void __iomem *r = ace->baseaddr + reg;
 	return in_8(r) | (in_8(r + 1) << 8);
 }
 
 static void ace_out_8(struct ace_device *ace, int reg, u16 val)
 {
-	void *r = ace->baseaddr + reg;
+	void __iomem *r = ace->baseaddr + reg;
 	out_8(r, val);
 	out_8(r + 1, val >> 8);
 }
 
 static void ace_datain_8(struct ace_device *ace)
 {
-	void *r = ace->baseaddr + 0x40;
+	void __iomem *r = ace->baseaddr + 0x40;
 	u8 *dst = ace->data_ptr;
 	int i = ACE_FIFO_SIZE;
 	while (i--)
@@ -250,7 +250,7 @@ static void ace_datain_8(struct ace_device *ace)
 
 static void ace_dataout_8(struct ace_device *ace)
 {
-	void *r = ace->baseaddr + 0x40;
+	void __iomem *r = ace->baseaddr + 0x40;
 	u8 *src = ace->data_ptr;
 	int i = ACE_FIFO_SIZE;
 	while (i--)
