Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 398111A09D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 05:08:11 +1100 (AEDT)
Received: by mail-la0-f46.google.com with SMTP id q1so2944500lam.19
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 10:08:07 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: mm: slice.c:  Remove unused function
Date: Sun,  7 Dec 2014 19:10:46 +0100
Message-Id: <1417975847-14153-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: Michael Neuling <mikey@neuling.org>,
 "jmarchan@redhat.com" <jmarchan@redhat.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function slice_set_psize() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/mm/slice.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index ded0ea1..0f432a7 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -645,35 +645,6 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
 
-void slice_set_psize(struct mm_struct *mm, unsigned long address,
-		     unsigned int psize)
-{
-	unsigned char *hpsizes;
-	unsigned long i, flags;
-	u64 *lpsizes;
-
-	spin_lock_irqsave(&slice_convert_lock, flags);
-	if (address < SLICE_LOW_TOP) {
-		i = GET_LOW_SLICE_INDEX(address);
-		lpsizes = &mm->context.low_slices_psize;
-		*lpsizes = (*lpsizes & ~(0xful << (i * 4))) |
-			((unsigned long) psize << (i * 4));
-	} else {
-		int index, mask_index;
-		i = GET_HIGH_SLICE_INDEX(address);
-		hpsizes = mm->context.high_slices_psize;
-		mask_index = i & 0x1;
-		index = i >> 1;
-		hpsizes[index] = (hpsizes[index] &
-				  ~(0xf << (mask_index * 4))) |
-			(((unsigned long)psize) << (mask_index * 4));
-	}
-
-	spin_unlock_irqrestore(&slice_convert_lock, flags);
-
-	copro_flush_all_slbs(mm);
-}
-
 void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
-- 
1.7.10.4
