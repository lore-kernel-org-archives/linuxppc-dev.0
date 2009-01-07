Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BAC7E4752A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:12:56 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 15:12:54 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090107135457.234150@gmx.net>
Message-ID: <20090107141254.140990@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net>
Subject: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
To: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The AmigaOne uses the onboard VIA IDE controller in legacy mode (like the
Pegasos).

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 drivers/ide/via82cxxx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 2a812d3..086f476 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -450,6 +450,11 @@ static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_i
 		d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
 #endif
 
+#ifdef CONFIG_AMIGAONE
+	if (machine_is(amigaone))
+		d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
+#endif
+
 	d.udma_mask = via_config->udma_mask;
 
 	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-- 
1.5.6.5


-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
