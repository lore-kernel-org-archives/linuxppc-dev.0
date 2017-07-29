Return-Path: <lin.sunze@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKHL01zC2zDrLv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 17:25:12 +1000 (AEST)
Received: by mail-pg0-f68.google.com with SMTP id v190so25593081pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 00:25:12 -0700 (PDT)
From: SZ Lin <sz.lin@moxa.com>
To: ashleydlai@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterhuewe@gmx.de, tpmdd@selhorst.ne, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 SZ Lin <sz.lin@moxa.com>
Subject: [PATCH 4/5] Remove unneccessary 'out of memory' message
Date: Sat, 29 Jul 2017 15:24:32 +0800
Message-Id: <20170729072433.13194-5-sz.lin@moxa.com>
In-Reply-To: <20170729072433.13194-1-sz.lin@moxa.com>
References: <20170729072433.13194-1-sz.lin@moxa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WARNING: Possible unnecessary 'out of memory' message
+                       if (!ibmvtpm->rtce_buf) {
+                               dev_err(ibmvtpm->dev, "Failed to allocate memory for rtce buffer\n");

WARNING: Possible unnecessary 'out of memory' message
+       if (!ibmvtpm) {
+               dev_err(dev, "kzalloc for ibmvtpm failed\n");

Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index e53b9fb517d9..e75a674b44ac 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -501,10 +501,8 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 			ibmvtpm->rtce_size = be16_to_cpu(crq->len);
 			ibmvtpm->rtce_buf = kmalloc(ibmvtpm->rtce_size,
 						    GFP_ATOMIC);
-			if (!ibmvtpm->rtce_buf) {
-				dev_err(ibmvtpm->dev, "Failed to allocate memory for rtce buffer\n");
+			if (!ibmvtpm->rtce_buf)
 				return;
-			}
 
 			ibmvtpm->rtce_dma_handle = dma_map_single(ibmvtpm->dev,
 				ibmvtpm->rtce_buf, ibmvtpm->rtce_size,
@@ -584,10 +582,8 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		return PTR_ERR(chip);
 
 	ibmvtpm = kzalloc(sizeof(struct ibmvtpm_dev), GFP_KERNEL);
-	if (!ibmvtpm) {
-		dev_err(dev, "kzalloc for ibmvtpm failed\n");
+	if (!ibmvtpm)
 		goto cleanup;
-	}
 
 	ibmvtpm->dev = dev;
 	ibmvtpm->vdev = vio_dev;
-- 
2.13.3
