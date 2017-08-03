Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNg0N74LlzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 05:21:40 +1000 (AEST)
Subject: [PATCH 3/4] axonram: Return directly after a failed kzalloc() in
 axon_ram_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
Message-ID: <43bc7b50-b59b-89e9-9139-ae8a716016a7@users.sourceforge.net>
Date: Thu, 3 Aug 2017 21:15:49 +0200
MIME-Version: 1.0
In-Reply-To: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
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
Date: Thu, 3 Aug 2017 20:23:57 +0200

* Return directly after a call of the function "kzalloc" failed
  at the beginning.

* Delete a repeated check for the local variable "bank"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/sysdev/axonram.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index bf1506ec2ca4..93cc902350db 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -192,10 +192,8 @@ static int axon_ram_probe(struct platform_device *device)
 			device->dev.of_node->full_name);
 
 	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
-	if (bank == NULL) {
-		rc = -ENOMEM;
-		goto failed;
-	}
+	if (!bank)
+		return -ENOMEM;
 
 	device->dev.platform_data = bank;
 
@@ -291,25 +289,22 @@ static int axon_ram_probe(struct platform_device *device)
 	return 0;
 
 failed:
-	if (bank != NULL) {
-		if (bank->irq_id)
-			free_irq(bank->irq_id, device);
-		if (bank->disk != NULL) {
-			if (bank->disk->major > 0)
-				unregister_blkdev(bank->disk->major,
-						bank->disk->disk_name);
-			if (bank->disk->flags & GENHD_FL_UP)
-				del_gendisk(bank->disk);
-			put_disk(bank->disk);
-		}
-		kill_dax(bank->dax_dev);
-		put_dax(bank->dax_dev);
-		device->dev.platform_data = NULL;
-		if (bank->io_addr != 0)
-			iounmap((void __iomem *) bank->io_addr);
-		kfree(bank);
+	if (bank->irq_id)
+		free_irq(bank->irq_id, device);
+	if (bank->disk != NULL) {
+		if (bank->disk->major > 0)
+			unregister_blkdev(bank->disk->major,
+					bank->disk->disk_name);
+		if (bank->disk->flags & GENHD_FL_UP)
+			del_gendisk(bank->disk);
+		put_disk(bank->disk);
 	}
-
+	kill_dax(bank->dax_dev);
+	put_dax(bank->dax_dev);
+	device->dev.platform_data = NULL;
+	if (bank->io_addr != 0)
+		iounmap((void __iomem *) bank->io_addr);
+	kfree(bank);
 	return rc;
 }
 
-- 
2.13.4
