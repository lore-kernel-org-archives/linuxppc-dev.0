Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v9g7Y0qHnzDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 02:48:56 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0SFmngo035633
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 10:48:53 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 288rq0hrq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 10:48:53 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 28 Jan 2017 10:48:52 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Properly mask the ESID bits when building
 proto-VSID
Date: Sat, 28 Jan 2017 21:18:40 +0530
Message-Id: <20170128154840.32468-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

proto-vsid is built using both mmu context id and ESID. We should not have
overlapping bits between those. That will result in us having vsid
collision. With the current code we missed masking the top bits of effective
address. This implies for kernel address we ended up using the top 4 bits
as part of proto-vsid, which is wrong. For the kernel we should have the
below mapping

0xf000000000000000 -> 0x7ffff  (19 bits context + 6 bits ESID ).

Without the patch we endup with
0xf000000000000000 ->  0xf7ffff (0x7ffff | 0xf00000)

We didn't observe any issues till now possibly because we never end up
using a context value which could map to the same  VSID as kernel.

Fixes: c60ac5693c4 ("powerpc: Update kernel VSID range")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 2e6a823fa502..0735d5a8049f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -525,6 +525,8 @@ extern void slb_set_size(u16 size);
 #define ESID_BITS		18
 #define ESID_BITS_1T		6
 
+#define ESID_BITS_MASK		((1 << ESID_BITS) - 1)
+#define ESID_BITS_1T_MASK	((1 << ESID_BITS_1T) - 1)
 /*
  * 256MB segment
  * The proto-VSID space has 2^(CONTEX_BITS + ESID_BITS) - 1 segments
@@ -660,9 +662,9 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 
 	if (ssize == MMU_SEGSIZE_256M)
 		return vsid_scramble((context << ESID_BITS)
-				     | (ea >> SID_SHIFT), 256M);
+				     | ((ea >> SID_SHIFT) & ESID_BITS_MASK), 256M);
 	return vsid_scramble((context << ESID_BITS_1T)
-			     | (ea >> SID_SHIFT_1T), 1T);
+			     | ((ea >> SID_SHIFT_1T) & ESID_BITS_1T_MASK), 1T);
 }
 
 /*
-- 
2.10.2
