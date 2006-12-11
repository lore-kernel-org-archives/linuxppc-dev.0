Return-Path: <htejun@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id D122067BD3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 01:03:06 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1412115wxd
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 06:03:05 -0800 (PST)
Date: Mon, 11 Dec 2006 23:02:58 +0900
From: Tejun Heo <htejun@gmail.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH] libata: don't initialize sg in ata_exec_internal() if DMA_NONE
Message-ID: <20061211140258.GB18947@htj.dyndns.org>
References: <200612081914.41810.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612081914.41810.arnd.bergmann@de.ibm.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
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

Hello, Arnd Bergmann.

Thanks for spotting and fixing this but ata_exec_internal_nodma() is
almost identical to ata_do_simple_cmd() and ata_exec_internal() itself
needs fixing anyway.  This patch just fixes ata_exec_internal().  I'll
follow up with conversion to ata_do_simple_cmd().

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 011c0a8..70e02e9 100644
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
@@ -1354,10 +1354,15 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
 	struct scatterlist sg;
+	unsigned int n_elem = 0;
 
-	sg_init_one(&sg, buf, buflen);
+	if (dma_dir != DMA_NONE) {
+		WARN_ON(!buf);
+		sg_init_one(&sg, buf, buflen);
+		n_elem++;
+	}
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, n_elem);
 }
 
 /**
