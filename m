Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 091ABDDEC2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 15:07:24 +1000 (EST)
Date: Fri, 19 Oct 2007 15:07:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: [PATCH] NULL terminate the pci_device_ids in pasemi_edac
Message-Id: <20071019150722.8d48eb1d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes:
drivers/edac/pasemi_edac: struct pci_device_id is 32 bytes.  The last of 1 is:
0x00 0x00 0x19 0x59 0x00 0x00 0xa0 0x0a 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
FATAL: drivers/edac/pasemi_edac: struct pci_device_id is not terminated with a NULL entry!

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/edac/pasemi_edac.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index e66cdd4..9007d06 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -270,6 +270,7 @@ static void __devexit pasemi_edac_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id pasemi_edac_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_PASEMI, 0xa00a) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, pasemi_edac_pci_tbl);
-- 
1.5.3.4
