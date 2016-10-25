Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t36dD60fkzDvYX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 20:03:28 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9P8weQE119577
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:03:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269vdmm6hx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:03:26 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 25 Oct 2016 10:03:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5C91E219004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 10:02:37 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9P93LLg22937706
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 09:03:21 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9P93Jk4006609
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:03:20 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Noam Camus <noamc@ezchip.com>, sparclinux@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v2 3/5] s390: make cpu_relax a barrier again
Date: Tue, 25 Oct 2016 11:03:13 +0200
In-Reply-To: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1477386195-32736-4-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

stop_machine seemed to be the only important place for yielding during
cpu_relax. This was fixed by using cpu_relax_yield. Therefore, we can
now redefine cpu_relax to be a barrier instead on s390, making s390
identical to all other architectures.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index d05965b..5d262cf 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -236,7 +236,7 @@ static inline unsigned short stap(void)
  */
 void cpu_relax_yield(void);
 
-#define cpu_relax() cpu_relax_yield()
+#define cpu_relax() barrier()
 #define cpu_relax_lowlatency()  barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
-- 
2.5.5
