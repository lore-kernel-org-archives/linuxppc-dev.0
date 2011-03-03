Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 82142B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 04:55:11 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/9] dmatest: fix automatic buffer unmap type
Date: Thu,  3 Mar 2011 09:54:53 -0800
Message-Id: <1299174901-16762-2-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
References: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dmatest code relies on the DMAEngine API to automatically call
dma_unmap_single() on src buffers. The flags it passes are incorrect,
fix them.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/dmatest.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 5589358..7e1b0aa 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -285,7 +285,12 @@ static int dmatest_func(void *data)
 
 	set_user_nice(current, 10);
 
-	flags = DMA_CTRL_ACK | DMA_COMPL_SKIP_DEST_UNMAP | DMA_PREP_INTERRUPT;
+	/*
+	 * src buffers are freed by the DMAEngine code with dma_unmap_single()
+	 * dst buffers are freed by ourselves below
+	 */
+	flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT
+	      | DMA_COMPL_SKIP_DEST_UNMAP | DMA_COMPL_SRC_UNMAP_SINGLE;
 
 	while (!kthread_should_stop()
 	       && !(iterations && total_tests >= iterations)) {
-- 
1.7.3.4
