Return-Path: <srs0=gqm2=lg=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wvpR1LfYzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 16:37:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41wvpR0dXNz8tPw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 16:37:03 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41wvpQ3gPxz9s5b
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 16:37:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7N6aeNI010824
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 02:37:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m1qkg0fb1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 02:37:00 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Aug 2018 07:36:58 +0100
Subject: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 23 Aug 2018 12:06:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
during MCE recovery path.), the SLB error recovery is broken. The new
change now does not add index value to RB[52-63] that selects the SLB
entry while rebolting, instead it assumes that the shadow save area
already have index embeded correctly in esid field. While all valid bolted
save areas do contain index value set correctly, there is a case where
3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
esid entry. This patch fixes that.

Without this patch the SLB rebolt code overwrites the 1st entry of kernel
linear mapping and causes SLB recovery to fail.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 0b095fa54049..9f574e59d178 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -70,7 +70,7 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
 
 static inline void slb_shadow_clear(enum slb_index index)
 {
-	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
+	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, cpu_to_be64(index));
 }
 
 static inline void create_shadowed_slbe(unsigned long ea, int ssize,
