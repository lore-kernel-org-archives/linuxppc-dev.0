Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHYdP3wwVzF0h7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:03:04 +1100 (AEDT)
Subject: [PATCH 3/5] powerpc/4xx: Delete an error message for a failed memory
 allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
Message-ID: <92f46132-b654-cc73-a589-4abf8ab3122a@users.sourceforge.net>
Date: Thu, 11 Jan 2018 19:02:45 +0100
MIME-Version: 1.0
In-Reply-To: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 11 Jan 2018 18:28:54 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/4xx/msi.c | 5 ++---
 arch/powerpc/platforms/4xx/ocm.c | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/msi.c
index d50417e23add..d16b81303cb0 100644
--- a/arch/powerpc/platforms/4xx/msi.c
+++ b/arch/powerpc/platforms/4xx/msi.c
@@ -224,10 +224,9 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
 
 	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
-	if (!msi) {
-		dev_err(&dev->dev, "No memory for MSI structure\n");
+	if (!msi)
 		return -ENOMEM;
-	}
+
 	dev->dev.platform_data = msi;
 
 	/* Get MSI ranges */
diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 8cb601e8bed7..5a750d0ad446 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -337,7 +337,6 @@ void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
 
 		ocm_blk = kzalloc(sizeof(struct ocm_block), GFP_KERNEL);
 		if (!ocm_blk) {
-			printk(KERN_ERR "PPC4XX OCM: could not allocate ocm block");
 			rh_free(ocm_reg->rh, offset);
 			break;
 		}
@@ -391,10 +390,8 @@ static int __init ppc4xx_ocm_init(void)
 		return 0;
 
 	ocm_nodes = kzalloc((count * sizeof(struct ocm_info)), GFP_KERNEL);
-	if (!ocm_nodes) {
-		printk(KERN_ERR "PPC4XX OCM: failed to allocate OCM nodes!\n");
+	if (!ocm_nodes)
 		return -ENOMEM;
-	}
 
 	ocm_count = count;
 	count = 0;
-- 
2.15.1
