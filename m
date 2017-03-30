Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3Fz00CTzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 06/19] powerpc/mm/slice: Update slice mask printing to use
 bitmap printing.
Date: Thu, 30 Mar 2017 23:03:54 +1100
Message-Id: <1490875447-4016-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We now get output like below which is much better.

[    0.935306]  good_mask low_slice: 0-15
[    0.935360]  good_mask high_slice: 0-511

Compared to

[    0.953414]  good_mask:1111111111111111 - 1111111111111.........

I also fixed an error with slice_dbg printing.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slice.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 7599c2703520..95e5a20b1b6a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -52,29 +52,13 @@ int _slice_debug = 1;
 
 static void slice_print_mask(const char *label, struct slice_mask mask)
 {
-	char	*p, buf[SLICE_NUM_LOW + 3 + SLICE_NUM_HIGH + 1];
-	int	i;
-
 	if (!_slice_debug)
 		return;
-	p = buf;
-	for (i = 0; i < SLICE_NUM_LOW; i++)
-		*(p++) = (mask.low_slices & (1 << i)) ? '1' : '0';
-	*(p++) = ' ';
-	*(p++) = '-';
-	*(p++) = ' ';
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
-		if (test_bit(i, mask.high_slices))
-			*(p++) = '1';
-		else
-			*(p++) = '0';
-	}
-	*(p++) = 0;
-
-	printk(KERN_DEBUG "%s:%s\n", label, buf);
+	pr_devel("%s low_slice: %*pbl\n", label, (int)SLICE_NUM_LOW, &mask.low_slices);
+	pr_devel("%s high_slice: %*pbl\n", label, (int)SLICE_NUM_HIGH, mask.high_slices);
 }
 
-#define slice_dbg(fmt...) do { if (_slice_debug) pr_debug(fmt); } while(0)
+#define slice_dbg(fmt...) do { if (_slice_debug) pr_devel(fmt); } while (0)
 
 #else
 
@@ -243,8 +227,8 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	}
 
 	slice_dbg(" lsps=%lx, hsps=%lx\n",
-		  mm->context.low_slices_psize,
-		  mm->context.high_slices_psize);
+		  (unsigned long)mm->context.low_slices_psize,
+		  (unsigned long)mm->context.high_slices_psize);
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
@@ -686,8 +670,8 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 
 
 	slice_dbg(" lsps=%lx, hsps=%lx\n",
-		  mm->context.low_slices_psize,
-		  mm->context.high_slices_psize);
+		  (unsigned long)mm->context.low_slices_psize,
+		  (unsigned long)mm->context.high_slices_psize);
 
  bail:
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
-- 
2.7.4
