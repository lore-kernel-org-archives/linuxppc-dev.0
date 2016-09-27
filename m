Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skGqq1ZT5zDrWP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:14:15 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3skGqp2S4Sz9sBr
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2016 09:14:14 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q2so1299751pfj.0
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 16:14:14 -0700 (PDT)
Subject: [PATCH] Fix "ibm,processor-radix-AP-encodings"
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Chris Smart <chris@distroguy.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <0612c46e-7e1b-3729-d84f-cefa886abb6d@gmail.com>
Date: Wed, 28 Sep 2016 09:13:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The top 3 bits of the lower order byte should contain the
AP encoding, we assume the top 3 bits of the MSB.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

 - Detected while reviewing Chris Smart's patch to add radix-AP-encoding
   to skiboot
 - Also fixed typo (sift/shift)

 arch/powerpc/mm/pgtable-radix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index af897d9..d525b0b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -245,10 +245,10 @@ static int __init radix_dt_scan_page_sizes(unsigned long node,
 
 		struct mmu_psize_def *def;
 
-		/* top 3 bit is AP encoding */
-		shift = be32_to_cpu(prop[0]) & ~(0xe << 28);
-		ap = be32_to_cpu(prop[0]) >> 29;
-		pr_info("Page size sift = %d AP=0x%x\n", shift, ap);
+		/* top 3 bits of the lower order byte is AP encoding */
+		shift = be32_to_cpu(prop[0]) & 0x1f;
+		ap = (be32_to_cpu(prop[0]) >> 5) & 0x7;
+		pr_info("Page size shift = %d AP=0x%x\n", shift, ap);
 
 		idx = get_idx_from_shift(shift);
 		if (idx < 0)
-- 
2.5.5
