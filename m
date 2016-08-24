Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK2FN0j2rzDrcL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 19:34:15 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7O9SfmQ089520
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 05:34:13 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250qp44c0m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 05:34:13 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 Aug 2016 03:34:12 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/mm/radix: Use different RTS encoding for
 different POWER9 revs
Date: Wed, 24 Aug 2016 15:03:37 +0530
In-Reply-To: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1472031219-18759-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 DD1 uses RTS - 28 for the RTS value but other revisions use
RTS - 31.  This makes this distinction for the different revisions

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index df294224e280..a2fe8fbfbd3d 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -233,14 +233,19 @@ static inline unsigned long radix__get_tree_size(void)
 {
 	unsigned long rts_field;
 	/*
-	 * we support 52 bits, hence 52-31 = 21, 0b10101
+	 * We support 52 bits, hence:
+	 *  DD1    52-28 = 24, 0b11000
+	 *  Others 52-31 = 21, 0b10101
 	 * RTS encoding details
 	 * bits 0 - 3 of rts -> bits 6 - 8 unsigned long
 	 * bits 4 - 5 of rts -> bits 62 - 63 of unsigned long
 	 */
-	rts_field = (0x5UL << 5); /* 6 - 8 bits */
-	rts_field |= (0x2UL << 61);
-
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		rts_field = (0x3UL << 61);
+	else {
+		rts_field = (0x5UL << 5); /* 6 - 8 bits */
+		rts_field |= (0x2UL << 61);
+	}
 	return rts_field;
 }
 #endif /* __ASSEMBLY__ */
-- 
2.7.4
