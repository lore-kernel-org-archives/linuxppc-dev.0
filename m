Return-Path: <htejun@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 481EA67D84
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 04:15:42 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so302194ana
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 09:15:38 -0800 (PST)
Date: Tue, 12 Dec 2006 02:15:31 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata: don't initialize sg in ata_exec_internal() if
	DMA_NONE (take #2)
Message-ID: <20061211171531.GC18947@htj.dyndns.org>
References: <200612081914.41810.arnd.bergmann@de.ibm.com>
	<20061211140258.GB18947@htj.dyndns.org>
	<457D7F5C.8040609@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <457D7F5C.8040609@pobox.com>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Calling sg_init_one() with NULL buf causes oops on certain
configurations.  Don't initialize sg in ata_exec_internal() if
DMA_NONE and make the function complain if @buf is NULL when dma_dir
isn't DMA_NONE.  While at it, fix comment.

The problem is discovered and initial patch was submitted by Arnd
Bergmann.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Modified as suggested.

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 011c0a8..0d51d13 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1332,7 +1332,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 }
 
 /**
- *	ata_exec_internal_sg - execute libata internal command
+ *	ata_exec_internal - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
@@ -1353,11 +1353,17 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct scatterlist sg;
+	struct scatterlist *psg = NULL, sg;
+	unsigned int n_elem = 0;
 
-	sg_init_one(&sg, buf, buflen);
+	if (dma_dir != DMA_NONE) {
+		WARN_ON(!buf);
+		sg_init_one(&sg, buf, buflen);
+		psg = &sg;
+		n_elem++;
+	}
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem);
 }
 
 /**
