Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmSgZ1fGWzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 07:44:26 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id us13so8823060pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 14:44:26 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: scottwood@freescale.com
Cc: qiang.zhao@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux@roeck-us.net
Subject: [PATCH v1] Specific requirement of type casting for 64-bit
 architectures.
Date: Sat,  9 Jul 2016 03:14:02 +0530
Message-Id: <1468014242-13939-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
assigned in ucc_fast_tx_virtual_fifo_base_offset and
ucc_fast_rx_virtual_fifo_base_offset. It will work on 32-bit architectures
But data can be loss on 64-bit architectures if 'qe_muram_alloc' will
return greater then MAX value of 'unsigned int'.

-Passing value in IS_ERR_VALUE() is wrong, as they pass an 'unsigned int'
into a function, It will through this compilation warning.

"
 include/linux/err.h:21:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
 #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
                                                 ^
 include/linux/compiler.h:170:42: note: in definition of macro ‘unlikely’
 # define unlikely(x) __builtin_expect(!!(x), 0)
"

-Most users of IS_ERR_VALUE() in the kernel are wrong, as they
pass an 'unsigned int' into a function that takes an 'unsigned long'
argument. This happens to work because the type is sign-extended
on 64-bit architectures before it gets converted into an
unsigned type.

However, anything that passes an 'unsigned short' or 'unsigned int'
argument into IS_ERR_VALUE() is guaranteed to be broken, as are
8-bit integers and types that are wider than 'unsigned long'.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/soc/fsl/qe/ucc_fast.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index a768931..208b198 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -141,6 +141,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	struct ucc_fast __iomem *uf_regs;
 	u32 gumr;
 	int ret;
+	unsigned long ret_muram;
 
 	if (!uf_info)
 		return -EINVAL;
@@ -265,28 +266,34 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	gumr |= uf_info->mode;
 	out_be32(&uf_regs->gumr, gumr);
 
-	/* Allocate memory for Tx Virtual Fifo */
-	uccf->ucc_fast_tx_virtual_fifo_base_offset =
-	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+	ret_muram =
+		qe_muram_alloc(uf_info->utfs,
+			UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+
+	if (IS_ERR_VALUE(ret_muram)) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
 			__func__);
 		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
+	} else {
+		/* Allocate memory for Tx Virtual Fifo */
+		uccf->ucc_fast_tx_virtual_fifo_base_offset = (u32)ret_muram;
 	}
 
-	/* Allocate memory for Rx Virtual Fifo */
-	uccf->ucc_fast_rx_virtual_fifo_base_offset =
+	ret_muram =
 		qe_muram_alloc(uf_info->urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+	if (IS_ERR_VALUE(ret_muram)) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
 			__func__);
 		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
+	} else {
+		/* Allocate memory for Rx Virtual Fifo */
+		uccf->ucc_fast_rx_virtual_fifo_base_offset = (u32)ret_muram;
 	}
 
 	/* Set Virtual Fifo registers */
-- 
1.9.1
