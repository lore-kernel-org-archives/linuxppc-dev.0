Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id ADBD52C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 399/493] edac: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:48 -0500
Message-Id: <1353349642-3677-399-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/edac/pasemi_edac.c     | 2 +-
 drivers/edac/r82600_edac.c     | 2 +-
 drivers/edac/sb_edac.c         | 2 +-
 drivers/edac/tile_edac.c       | 2 +-
 drivers/edac/x38_edac.c        | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fbc9f43..735a33e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2612,7 +2612,7 @@ err_out:
 	return ret;
 }
 
-static void __devexit amd64_remove_one_instance(struct pci_dev *pdev)
+static void amd64_remove_one_instance(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
index af986bc..be17814 100644
--- a/drivers/edac/amd76x_edac.c
+++ b/drivers/edac/amd76x_edac.c
@@ -318,7 +318,7 @@ static int amd76x_init_one(struct pci_dev *pdev,
  *	structure for the device then delete the mci and free the
  *	resources.
  */
-static void __devexit amd76x_remove_one(struct pci_dev *pdev)
+static void amd76x_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index c276157..c2eaf33 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -233,7 +233,7 @@ static int cell_edac_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit cell_edac_remove(struct platform_device *pdev)
+static int cell_edac_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
 	if (mci)
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index ee69530..b2b3f00 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1402,7 +1402,7 @@ static int e752x_init_one(struct pci_dev *pdev,
 	return e752x_probe1(pdev, ent->driver_data);
 }
 
-static void __devexit e752x_remove_one(struct pci_dev *pdev)
+static void e752x_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct e752x_pvt *pvt;
diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
index 9ceb779..3ebf885 100644
--- a/drivers/edac/e7xxx_edac.c
+++ b/drivers/edac/e7xxx_edac.c
@@ -538,7 +538,7 @@ static int e7xxx_init_one(struct pci_dev *pdev,
 		-EIO : e7xxx_probe1(pdev, ent->driver_data);
 }
 
-static void __devexit e7xxx_remove_one(struct pci_dev *pdev)
+static void e7xxx_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct e7xxx_pvt *pvt;
diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index b39b54a..d945bac 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -472,7 +472,7 @@ static int i3000_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit i3000_remove_one(struct pci_dev *pdev)
+static void i3000_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 1c2a44a..2fb40e0 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -436,7 +436,7 @@ static int i3200_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit i3200_remove_one(struct pci_dev *pdev)
+static void i3200_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct i3200_priv *priv;
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index e67f0f9..7536f99 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1509,7 +1509,7 @@ static int i5000_init_one(struct pci_dev *pdev,
  *	i5000_remove_one	destructor for one instance of device
  *
  */
-static void __devexit i5000_remove_one(struct pci_dev *pdev)
+static void i5000_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index ed6b6d2..8a262e5d 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -1020,7 +1020,7 @@ bail:
 	return ret;
 }
 
-static void __devexit i5100_remove_one(struct pci_dev *pdev)
+static void i5100_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct i5100_priv *priv;
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index f49797a..afb1ba4 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1393,7 +1393,7 @@ static int i5400_init_one(struct pci_dev *pdev,
  *	i5400_remove_one	destructor for one instance of device
  *
  */
-static void __devexit i5400_remove_one(struct pci_dev *pdev)
+static void i5400_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index ad19604..9d1bf27 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -1122,7 +1122,7 @@ fail0:
  * i7300_remove_one() - Remove the driver
  * @pdev: struct pci_dev pointer
  */
-static void __devexit i7300_remove_one(struct pci_dev *pdev)
+static void i7300_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	char *tmp;
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index e61f775..9690793 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -2368,7 +2368,7 @@ fail0:
  *	i7core_remove	destructor for one instance of device
  *
  */
-static void __devexit i7core_remove(struct pci_dev *pdev)
+static void i7core_remove(struct pci_dev *pdev)
 {
 	struct i7core_dev *i7core_dev;
 
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index 2acb2a0..f3a23f2 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -369,7 +369,7 @@ static int i82443bxgx_edacmc_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit i82443bxgx_edacmc_remove_one(struct pci_dev *pdev)
+static void i82443bxgx_edacmc_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
index f99abb9..fe03ccc 100644
--- a/drivers/edac/i82860_edac.c
+++ b/drivers/edac/i82860_edac.c
@@ -273,7 +273,7 @@ static int i82860_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit i82860_remove_one(struct pci_dev *pdev)
+static void i82860_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index 8c0e858..d6772df 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -498,7 +498,7 @@ static int i82875p_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit i82875p_remove_one(struct pci_dev *pdev)
+static void i82875p_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct i82875p_pvt *pvt = NULL;
diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 06965a1..4816220 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -700,7 +700,7 @@ static int i82975x_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit i82975x_remove_one(struct pci_dev *pdev)
+static void i82975x_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct i82975x_pvt *pvt;
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 0c60c38..a7f6a85 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -266,7 +266,7 @@ fail:
 	return -ENODEV;
 }
 
-static void __devexit pasemi_edac_remove(struct pci_dev *pdev)
+static void pasemi_edac_remove(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
 
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
index b963b70..1af0501 100644
--- a/drivers/edac/r82600_edac.c
+++ b/drivers/edac/r82600_edac.c
@@ -368,7 +368,7 @@ static int r82600_init_one(struct pci_dev *pdev,
 	return r82600_probe1(pdev, ent->driver_data);
 }
 
-static void __devexit r82600_remove_one(struct pci_dev *pdev)
+static void r82600_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 24cb900..cf9551e 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1744,7 +1744,7 @@ fail0:
  *	sbridge_remove	destructor for one instance of device
  *
  */
-static void __devexit sbridge_remove(struct pci_dev *pdev)
+static void sbridge_remove(struct pci_dev *pdev)
 {
 	struct sbridge_dev *sbridge_dev;
 
diff --git a/drivers/edac/tile_edac.c b/drivers/edac/tile_edac.c
index 16966e0..a082053 100644
--- a/drivers/edac/tile_edac.c
+++ b/drivers/edac/tile_edac.c
@@ -186,7 +186,7 @@ static int tile_edac_mc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit tile_edac_mc_remove(struct platform_device *pdev)
+static int tile_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 7088028..f8063c0 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -435,7 +435,7 @@ static int x38_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-static void __devexit x38_remove_one(struct pci_dev *pdev)
+static void x38_remove_one(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 
-- 
1.8.0
