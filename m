Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 463BCB6FA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 22:38:47 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Anton Vorontsov <cbouatmailru@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] usb: Allocate pram dynamically.
Date: Tue, 23 Aug 2011 14:38:41 +0200
Message-Id: <1314103121-9857-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC832x does not have enough MURAM to do fixed MURAM allocation.
Change to dynamic allocation.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 drivers/usb/host/fhci-hcd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index c7c8392..98adbe8 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -622,12 +622,15 @@ static int __devinit of_fhci_probe(struct of_device *ofdev,
 		goto err_pram;
 	}
 
-	pram_addr = cpm_muram_alloc_fixed(iprop[2], FHCI_PRAM_SIZE);
+	pram_addr = cpm_muram_alloc(FHCI_PRAM_SIZE, 64);
 	if (IS_ERR_VALUE(pram_addr)) {
 		dev_err(dev, "failed to allocate usb pram\n");
 		ret = -ENOMEM;
 		goto err_pram;
 	}
+
+	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, QE_CR_SUBBLOCK_USB,
+		     QE_CR_PROTOCOL_UNSPECIFIED, pram_addr);
 	fhci->pram = cpm_muram_addr(pram_addr);
 
 	/* GPIOs and pins */
-- 
1.7.3.4
