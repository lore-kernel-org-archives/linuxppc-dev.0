Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 095002C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 056/493] edac: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:05 -0500
Message-Id: <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: "Arvind R." <arvino55@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Borislav Petkov <bp@alien8.de>, Doug Thompson <dougthompson@xmission.com>,
 Olof Johansson <olof@lixom.net>, Egor Martovetsky <egor@pasemi.com>,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tim Small <tim@buttersideup.com>
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
Cc: Doug Thompson <dougthompson@xmission.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: Mark Gross <mark.gross@intel.com> 
Cc: Jason Uhlenkott <juhlenko@akamai.com> 
Cc: Mauro Carvalho Chehab <mchehab@redhat.com> 
Cc: Tim Small <tim@buttersideup.com> 
Cc: Ranganathan Desikan <ravi@jetztechnologies.com> 
Cc: "Arvind R." <arvino55@gmail.com> 
Cc: Egor Martovetsky <egor@pasemi.com> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: linux-edac@vger.kernel.org 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/edac/amd64_edac.c      | 2 +-
 drivers/edac/amd76x_edac.c     | 2 +-
 drivers/edac/cell_edac.c       | 2 +-
 drivers/edac/e752x_edac.c      | 2 +-
 drivers/edac/e7xxx_edac.c      | 2 +-
 drivers/edac/i3000_edac.c      | 2 +-
 drivers/edac/i3200_edac.c      | 2 +-
 drivers/edac/i5000_edac.c      | 2 +-
 drivers/edac/i5100_edac.c      | 2 +-
 drivers/edac/i5400_edac.c      | 2 +-
 drivers/edac/i7300_edac.c      | 2 +-
 drivers/edac/i7core_edac.c     | 2 +-
 drivers/edac/i82443bxgx_edac.c | 2 +-
 drivers/edac/i82860_edac.c     | 2 +-
 drivers/edac/i82875p_edac.c    | 2 +-
 drivers/edac/i82975x_edac.c    | 2 +-
 drivers/edac/mv64x60_edac.c    | 2 +-
 drivers/edac/pasemi_edac.c     | 2 +-
 drivers/edac/r82600_edac.c     | 2 +-
 drivers/edac/sb_edac.c         | 2 +-
 drivers/edac/tile_edac.c       | 2 +-
 drivers/edac/x38_edac.c        | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f74a684..c147e1e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2686,7 +2686,7 @@ MODULE_DEVICE_TABLE(pci, amd64_pci_table);
 static struct pci_driver amd64_pci_driver = {
 	.name		= EDAC_MOD_STR,
 	.probe		= amd64_probe_one_instance,
-	.remove		= __devexit_p(amd64_remove_one_instance),
+	.remove		= amd64_remove_one_instance,
 	.id_table	= amd64_pci_table,
 };
 
diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
index 29eeb68..0430c35 100644
--- a/drivers/edac/amd76x_edac.c
+++ b/drivers/edac/amd76x_edac.c
@@ -350,7 +350,7 @@ MODULE_DEVICE_TABLE(pci, amd76x_pci_tbl);
 static struct pci_driver amd76x_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = amd76x_init_one,
-	.remove = __devexit_p(amd76x_remove_one),
+	.remove = amd76x_remove_one,
 	.id_table = amd76x_pci_tbl,
 };
 
diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index a1bbd8e..b99bf19 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -247,7 +247,7 @@ static struct platform_driver cell_edac_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= cell_edac_probe,
-	.remove		= __devexit_p(cell_edac_remove),
+	.remove		= cell_edac_remove,
 };
 
 static int __init cell_edac_init(void)
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index a5ed6b7..697acd5 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(pci, e752x_pci_tbl);
 static struct pci_driver e752x_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = e752x_init_one,
-	.remove = __devexit_p(e752x_remove_one),
+	.remove = e752x_remove_one,
 	.id_table = e752x_pci_tbl,
 };
 
diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
index 9ff57f3..2b401ef 100644
--- a/drivers/edac/e7xxx_edac.c
+++ b/drivers/edac/e7xxx_edac.c
@@ -579,7 +579,7 @@ MODULE_DEVICE_TABLE(pci, e7xxx_pci_tbl);
 static struct pci_driver e7xxx_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = e7xxx_init_one,
-	.remove = __devexit_p(e7xxx_remove_one),
+	.remove = e7xxx_remove_one,
 	.id_table = e7xxx_pci_tbl,
 };
 
diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index d3d19cc..22d43a0 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -502,7 +502,7 @@ MODULE_DEVICE_TABLE(pci, i3000_pci_tbl);
 static struct pci_driver i3000_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = i3000_init_one,
-	.remove = __devexit_p(i3000_remove_one),
+	.remove = i3000_remove_one,
 	.id_table = i3000_pci_tbl,
 };
 
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index b6653a6..532fabb 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -467,7 +467,7 @@ MODULE_DEVICE_TABLE(pci, i3200_pci_tbl);
 static struct pci_driver i3200_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = i3200_init_one,
-	.remove = __devexit_p(i3200_remove_one),
+	.remove = i3200_remove_one,
 	.id_table = i3200_pci_tbl,
 };
 
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 6a49dd0..782b2880e 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1547,7 +1547,7 @@ MODULE_DEVICE_TABLE(pci, i5000_pci_tbl);
 static struct pci_driver i5000_driver = {
 	.name = KBUILD_BASENAME,
 	.probe = i5000_init_one,
-	.remove = __devexit_p(i5000_remove_one),
+	.remove = i5000_remove_one,
 	.id_table = i5000_pci_tbl,
 };
 
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index c4b5e5f..da5975e 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -1054,7 +1054,7 @@ MODULE_DEVICE_TABLE(pci, i5100_pci_tbl);
 static struct pci_driver i5100_driver = {
 	.name = KBUILD_BASENAME,
 	.probe = i5100_init_one,
-	.remove = __devexit_p(i5100_remove_one),
+	.remove = i5100_remove_one,
 	.id_table = i5100_pci_tbl,
 };
 
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 2772469..5c25d01 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1431,7 +1431,7 @@ MODULE_DEVICE_TABLE(pci, i5400_pci_tbl);
 static struct pci_driver i5400_driver = {
 	.name = "i5400_edac",
 	.probe = i5400_init_one,
-	.remove = __devexit_p(i5400_remove_one),
+	.remove = i5400_remove_one,
 	.id_table = i5400_pci_tbl,
 };
 
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 9d669cd..62629fd 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -1163,7 +1163,7 @@ MODULE_DEVICE_TABLE(pci, i7300_pci_tbl);
 static struct pci_driver i7300_driver = {
 	.name = "i7300_edac",
 	.probe = i7300_init_one,
-	.remove = __devexit_p(i7300_remove_one),
+	.remove = i7300_remove_one,
 	.id_table = i7300_pci_tbl,
 };
 
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 3672101..aa0a97e 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -2409,7 +2409,7 @@ MODULE_DEVICE_TABLE(pci, i7core_pci_tbl);
 static struct pci_driver i7core_driver = {
 	.name     = "i7core_edac",
 	.probe    = i7core_probe,
-	.remove   = __devexit_p(i7core_remove),
+	.remove   = i7core_remove,
 	.id_table = i7core_pci_tbl,
 };
 
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index 90f303d..454ba5a 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -399,7 +399,7 @@ MODULE_DEVICE_TABLE(pci, i82443bxgx_pci_tbl);
 static struct pci_driver i82443bxgx_edacmc_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = i82443bxgx_edacmc_init_one,
-	.remove = __devexit_p(i82443bxgx_edacmc_remove_one),
+	.remove = i82443bxgx_edacmc_remove_one,
 	.id_table = i82443bxgx_pci_tbl,
 };
 
diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
index 1faa749..040c1d5 100644
--- a/drivers/edac/i82860_edac.c
+++ b/drivers/edac/i82860_edac.c
@@ -302,7 +302,7 @@ MODULE_DEVICE_TABLE(pci, i82860_pci_tbl);
 static struct pci_driver i82860_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = i82860_init_one,
-	.remove = __devexit_p(i82860_remove_one),
+	.remove = i82860_remove_one,
 	.id_table = i82860_pci_tbl,
 };
 
diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index 3e416b1..a330640 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -541,7 +541,7 @@ MODULE_DEVICE_TABLE(pci, i82875p_pci_tbl);
 static struct pci_driver i82875p_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = i82875p_init_one,
-	.remove = __devexit_p(i82875p_remove_one),
+	.remove = i82875p_remove_one,
 	.id_table = i82875p_pci_tbl,
 };
 
diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 082e91e..b6478a9 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -733,7 +733,7 @@ MODULE_DEVICE_TABLE(pci, i82975x_pci_tbl);
 static struct pci_driver i82975x_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = i82975x_init_one,
-	.remove = __devexit_p(i82975x_remove_one),
+	.remove = i82975x_remove_one,
 	.id_table = i82975x_pci_tbl,
 };
 
diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 2b315c2..da27a7a 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -221,7 +221,7 @@ static int mv64x60_pci_err_remove(struct platform_device *pdev)
 
 static struct platform_driver mv64x60_pci_err_driver = {
 	.probe = mv64x60_pci_err_probe,
-	.remove = __devexit_p(mv64x60_pci_err_remove),
+	.remove = mv64x60_pci_err_remove,
 	.driver = {
 		   .name = "mv64x60_pci_err",
 	}
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 2d35b78..69f08d6 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -287,7 +287,7 @@ MODULE_DEVICE_TABLE(pci, pasemi_edac_pci_tbl);
 static struct pci_driver pasemi_edac_driver = {
 	.name = MODULE_NAME,
 	.probe = pasemi_edac_probe,
-	.remove = __devexit_p(pasemi_edac_remove),
+	.remove = pasemi_edac_remove,
 	.id_table = pasemi_edac_pci_tbl,
 };
 
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
index f854deb..664b4c1 100644
--- a/drivers/edac/r82600_edac.c
+++ b/drivers/edac/r82600_edac.c
@@ -397,7 +397,7 @@ MODULE_DEVICE_TABLE(pci, r82600_pci_tbl);
 static struct pci_driver r82600_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = r82600_init_one,
-	.remove = __devexit_p(r82600_remove_one),
+	.remove = r82600_remove_one,
 	.id_table = r82600_pci_tbl,
 };
 
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 9ad2424..79559f2 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1785,7 +1785,7 @@ MODULE_DEVICE_TABLE(pci, sbridge_pci_tbl);
 static struct pci_driver sbridge_driver = {
 	.name     = "sbridge_edac",
 	.probe    = sbridge_probe,
-	.remove   = __devexit_p(sbridge_remove),
+	.remove   = sbridge_remove,
 	.id_table = sbridge_pci_tbl,
 };
 
diff --git a/drivers/edac/tile_edac.c b/drivers/edac/tile_edac.c
index 1e904b7..89c3c6b 100644
--- a/drivers/edac/tile_edac.c
+++ b/drivers/edac/tile_edac.c
@@ -202,7 +202,7 @@ static struct platform_driver tile_edac_mc_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= tile_edac_mc_probe,
-	.remove		= __devexit_p(tile_edac_mc_remove),
+	.remove		= tile_edac_mc_remove,
 };
 
 /*
diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 08a9926..2301418 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -464,7 +464,7 @@ MODULE_DEVICE_TABLE(pci, x38_pci_tbl);
 static struct pci_driver x38_driver = {
 	.name = EDAC_MOD_STR,
 	.probe = x38_init_one,
-	.remove = __devexit_p(x38_remove_one),
+	.remove = x38_remove_one,
 	.id_table = x38_pci_tbl,
 };
 
-- 
1.8.0
