Return-Path: <"arvind@arvind.yadav.cs"@gmail.com>
Received: from arvind-ThinkPad-Edge-E431 (unknown [106.51.17.148])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rlhMB3VHgzDr08
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 01:27:34 +1000 (AEST)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: scottwood@freescale.com
Cc: qiang.zhao@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Remove lots of IS_ERR_VALUE abuses and compilation warning.
Date: Thu,  7 Jul 2016 20:57:29 +0530
Message-Id: <1467905249-3990-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    Passing value in IS_ERR_VALUE() is wrong, as they
    pass an 'int' into a function that takes an 'unsigned long'
    argument. This happens to work because the type is sign-extended
    on 64-bit architectures before it gets converted into an
    unsigned type.

    Passing an 'unsigned short' or 'unsigned int'
    argument into IS_ERR_VALUE() is guaranteed to be broken, as are
    8-bit integers and types that are wider than 'unsigned long'.

    Any user will get compilation warning for that do not pass an
    'unsigned long' argument.

    Commit '287980e49f; - This change is alreday fixes lots of other
    worst abusers.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/soc/fsl/qe/ucc_fast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index a768931..7cc783c 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -268,7 +268,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	/* Allocate memory for Tx Virtual Fifo */
 	uccf->ucc_fast_tx_virtual_fifo_base_offset =
 	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+	if (uccf->ucc_fast_tx_virtual_fifo_base_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
 			__func__);
 		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
@@ -281,7 +281,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		qe_muram_alloc(uf_info->urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+	if (uccf->ucc_fast_rx_virtual_fifo_base_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
 			__func__);
 		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
-- 
1.9.1
