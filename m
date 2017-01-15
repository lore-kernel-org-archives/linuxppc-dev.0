Return-Path: <bhumirks@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1PC93nFCzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 15:53:41 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y143so12034994pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 20:53:41 -0800 (PST)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, tyreld@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] scsi: ibmvscsi: constify dev_pm_ops structures
Date: Sun, 15 Jan 2017 10:23:17 +0530
Message-Id: <1484455997-24400-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Declare dev_pm_ops structures as const as they are only stored in the pm
field of a vio_driver structure. This field is of type const, so
dev_pm_ops structures having similar properties can be declared const.
Done using Coccinelle:

@r1 disable optional_qualifier@
identifier i;
position p;
@@
static struct dev_pm_ops i@p={...};

@ok@
identifier r1.i;
position p;
struct vio_driver x;
@@
x.pm=&i@p;

@bad@
position p!={r1.p,ok.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct dev_pm_ops i;

File sizes after cross compiling the .o files for powerpc architecture.

File size before:
  text	   data	    bss	    dec	    hex	filename
  57893	   5665	     20	  63578	   f85a	drivers/scsi/ibmvscsi/ibmvfc.o

File size after:
  text	   data	    bss	    dec	    hex	filename
  58077	   5481	     20	  63578	   f85a	drivers/scsi/ibmvscsi/ibmvfc.o

File size before:
   text	   data	    bss	    dec	    hex	filenam
  20990	   2816	     80	  23886	   5d4e	drivers/scsi/ibmvscsi/ibmvscsi.o

File size after:
  text	   data	    bss	    dec	    hex	filename
  21174	   2632	     80	  23886	   5d4e	drivers/scsi/ibmvscsi/ibmvscsi.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c   | 2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 78b72c2..1e1b343 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -4940,7 +4940,7 @@ static unsigned long ibmvfc_get_desired_dma(struct vio_dev *vdev)
 };
 MODULE_DEVICE_TABLE(vio, ibmvfc_device_table);
 
-static struct dev_pm_ops ibmvfc_pm_ops = {
+static const struct dev_pm_ops ibmvfc_pm_ops = {
 	.resume = ibmvfc_resume
 };
 
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 50cd011..b94e7b1 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2335,7 +2335,7 @@ static int ibmvscsi_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(vio, ibmvscsi_device_table);
 
-static struct dev_pm_ops ibmvscsi_pm_ops = {
+static const struct dev_pm_ops ibmvscsi_pm_ops = {
 	.resume = ibmvscsi_resume
 };
 
-- 
1.9.1
