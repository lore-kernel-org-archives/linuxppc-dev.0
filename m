Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPG6lFtzDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:37:54 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3T75a076067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:44 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vrtc7r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:44 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:37:43 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 06/17] powerpc/mm/slice: Update slice mask printing to use
 bitmap printing.
Date: Wed, 22 Mar 2017 09:06:52 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now get output like below which is much better.

[    0.935306]  good_mask low_slice: 0-15
[    0.935360]  good_mask high_slice: 0-511

Compared to

[    0.953414]  good_mask:1111111111111111 - 1111111111111.........

I also fixed an error with slice_dbg printing.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index e1c42b54f5c5..ee3cfc5d9bbc 100644
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
