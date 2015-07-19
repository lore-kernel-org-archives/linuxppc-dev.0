Return-Path: <vthakkar1994@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462BF1A045F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 03:24:02 +1000 (AEST)
Received: by pacom8 with SMTP id om8so1345091pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 10:23:59 -0700 (PDT)
Date: Sun, 19 Jul 2015 22:53:52 +0530
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: Remove use of macro DEFINE_PCI_DEVICE_TABLE
Message-ID: <20150719172352.GA14386@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Macro DEFINE_PCI_DEVICE_TABLE is deprecated. So, here use
struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE with
the goal of getting rid of this macro completely.

The Coccinelle semantic patch that performs this transformation
is as follows:

@@
identifier a;
declarer name DEFINE_PCI_DEVICE_TABLE;
initializer i;
@@
- DEFINE_PCI_DEVICE_TABLE(a)
+ const struct pci_device_id a[]
= i;

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/misc/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 32ad097..3ed0621 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -133,7 +133,7 @@ u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off)
 	return (val >> ((off & 0x3) * 8)) & 0xff;
 }
 
-static DEFINE_PCI_DEVICE_TABLE(cxl_pci_tbl) = {
+static const struct pci_device_id cxl_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
-- 
1.9.1
