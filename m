Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 9A8A62C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:33:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 117/493] tty: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:06 -0500
Message-Id: <1353349642-3677-117-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jiri Slaby <jirislaby@gmail.com> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/tty/cyclades.c     | 2 +-
 drivers/tty/hvc/hvc_opal.c | 2 +-
 drivers/tty/hvc/hvcs.c     | 2 +-
 drivers/tty/isicom.c       | 2 +-
 drivers/tty/moxa.c         | 2 +-
 drivers/tty/mxser.c        | 2 +-
 drivers/tty/nozomi.c       | 2 +-
 drivers/tty/synclink.c     | 2 +-
 drivers/tty/synclink_gt.c  | 2 +-
 drivers/tty/synclinkmp.c   | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 0a6a0bc..0244acf 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -3971,7 +3971,7 @@ static struct pci_driver cy_pci_driver = {
 	.name = "cyclades",
 	.id_table = cy_pci_dev_id,
 	.probe = cy_pci_probe,
-	.remove = __devexit_p(cy_pci_remove)
+	.remove = cy_pci_remove
 };
 #endif
 
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index a4f488f..f39337f 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -239,7 +239,7 @@ static int __devexit hvc_opal_remove(struct platform_device *dev)
 
 static struct platform_driver hvc_opal_driver = {
 	.probe		= hvc_opal_probe,
-	.remove		= __devexit_p(hvc_opal_remove),
+	.remove		= hvc_opal_remove,
 	.driver		= {
 		.name	= hvc_opal_name,
 		.owner	= THIS_MODULE,
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 744c3b8..888af58 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -874,7 +874,7 @@ static int __devexit hvcs_remove(struct vio_dev *dev)
 static struct vio_driver hvcs_vio_driver = {
 	.id_table	= hvcs_driver_table,
 	.probe		= hvcs_probe,
-	.remove		= __devexit_p(hvcs_remove),
+	.remove		= hvcs_remove,
 	.name		= hvcs_driver_name,
 };
 
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index d7492e1..4775747 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -168,7 +168,7 @@ static struct pci_driver isicom_driver = {
 	.name		= "isicom",
 	.id_table	= isicom_pci_tbl,
 	.probe		= isicom_probe,
-	.remove		= __devexit_p(isicom_remove)
+	.remove		= isicom_remove
 };
 
 static int prev_card = 3;	/*	start servicing isi_card[0]	*/
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 56e616b..c2d0cc3 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1029,7 +1029,7 @@ static struct pci_driver moxa_pci_driver = {
 	.name = "moxa",
 	.id_table = moxa_pcibrds,
 	.probe = moxa_pci_probe,
-	.remove = __devexit_p(moxa_pci_remove)
+	.remove = moxa_pci_remove
 };
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index cfda47d..f026797 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2666,7 +2666,7 @@ static struct pci_driver mxser_driver = {
 	.name = "mxser",
 	.id_table = mxser_pcibrds,
 	.probe = mxser_probe,
-	.remove = __devexit_p(mxser_remove)
+	.remove = mxser_remove
 };
 
 static int __init mxser_module_init(void)
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b917c94..dc0213e 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1903,7 +1903,7 @@ static struct pci_driver nozomi_driver = {
 	.name = NOZOMI_NAME,
 	.id_table = nozomi_pci_tbl,
 	.probe = nozomi_card_init,
-	.remove = __devexit_p(nozomi_card_exit),
+	.remove = nozomi_card_exit,
 };
 
 static __init int nozomi_init(void)
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 70e3a52..65b8669 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -898,7 +898,7 @@ static struct pci_driver synclink_pci_driver = {
 	.name		= "synclink",
 	.id_table	= synclink_pci_tbl,
 	.probe		= synclink_init_one,
-	.remove		= __devexit_p(synclink_remove_one),
+	.remove		= synclink_remove_one,
 };
 
 static struct tty_driver *serial_driver;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index b38e954..28a2ccf 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -110,7 +110,7 @@ static struct pci_driver pci_driver = {
 	.name		= "synclink_gt",
 	.id_table	= pci_table,
 	.probe		= init_one,
-	.remove		= __devexit_p(remove_one),
+	.remove		= remove_one,
 };
 
 static bool pci_registered;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index f17d9f3..3e56e1e 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -492,7 +492,7 @@ static struct pci_driver synclinkmp_pci_driver = {
 	.name		= "synclinkmp",
 	.id_table	= synclinkmp_pci_tbl,
 	.probe		= synclinkmp_init_one,
-	.remove		= __devexit_p(synclinkmp_remove_one),
+	.remove		= synclinkmp_remove_one,
 };
 
 
-- 
1.8.0
