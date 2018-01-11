Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHYmZ36n7zDqhB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:09:18 +1100 (AEDT)
Subject: [PATCH 4/5] powerpc/4xx: Improve a size determination in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
Message-ID: <8ac91d54-bd2b-42cb-f890-e3007489b758@users.sourceforge.net>
Date: Thu, 11 Jan 2018 19:03:53 +0100
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
Date: Thu, 11 Jan 2018 18:32:33 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/4xx/msi.c | 2 +-
 arch/powerpc/platforms/4xx/ocm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/msi.c
index d16b81303cb0..f693cab07752 100644
--- a/arch/powerpc/platforms/4xx/msi.c
+++ b/arch/powerpc/platforms/4xx/msi.c
@@ -223,7 +223,7 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 
 	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
 
-	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
+	msi = kzalloc(sizeof(*msi), GFP_KERNEL);
 	if (!msi)
 		return -ENOMEM;
 
diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 5a750d0ad446..11418f090bf4 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -335,7 +335,7 @@ void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
 		if (IS_ERR_VALUE(offset))
 			continue;
 
-		ocm_blk = kzalloc(sizeof(struct ocm_block), GFP_KERNEL);
+		ocm_blk = kzalloc(sizeof(*ocm_blk), GFP_KERNEL);
 		if (!ocm_blk) {
 			rh_free(ocm_reg->rh, offset);
 			break;
-- 
2.15.1
