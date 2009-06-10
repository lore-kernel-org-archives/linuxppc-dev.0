Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78B48B70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:23 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 21/33] ps3: ps3rom - Use ps3_system_bus_[gs]et_drvdata()
	instead of direct access
Date: Wed, 10 Jun 2009 16:38:56 +0200
Message-Id: <1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	cbe-oss-dev@ozlabs.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-scsi@vger.kernel.org
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/scsi/ps3rom.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index ca0dd33..db90caf 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -299,7 +299,7 @@ static irqreturn_t ps3rom_interrupt(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	host = dev->sbd.core.driver_data;
+	host = ps3_system_bus_get_drvdata(&dev->sbd);
 	priv = shost_priv(host);
 	cmd = priv->curr_cmd;
 
@@ -387,7 +387,7 @@ static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
 	}
 
 	priv = shost_priv(host);
-	dev->sbd.core.driver_data = host;
+	ps3_system_bus_set_drvdata(&dev->sbd, host);
 	priv->dev = dev;
 
 	/* One device/LUN per SCSI bus */
@@ -407,7 +407,7 @@ static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
 
 fail_host_put:
 	scsi_host_put(host);
-	dev->sbd.core.driver_data = NULL;
+	ps3_system_bus_set_drvdata(&dev->sbd, NULL);
 fail_teardown:
 	ps3stor_teardown(dev);
 fail_free_bounce:
@@ -418,12 +418,12 @@ fail_free_bounce:
 static int ps3rom_remove(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
-	struct Scsi_Host *host = dev->sbd.core.driver_data;
+	struct Scsi_Host *host = ps3_system_bus_get_drvdata(&dev->sbd);
 
 	scsi_remove_host(host);
 	ps3stor_teardown(dev);
 	scsi_host_put(host);
-	dev->sbd.core.driver_data = NULL;
+	ps3_system_bus_set_drvdata(&dev->sbd, NULL);
 	kfree(dev->bounce_buf);
 	return 0;
 }
-- 
1.6.2.4
