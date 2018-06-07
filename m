Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411qBB6rXKzF34G
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 01:25:51 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57FOkd9076451
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 11:25:50 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5q15epb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:25:49 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 09:25:49 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w57FPivL10420658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 08:25:44 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A637BBE05B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E183BE058
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
Received: from pedro.localdomain (unknown [9.18.235.95])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/5] powerpc: Fix pmu get/set functions
Date: Thu,  7 Jun 2018 12:25:32 -0300
In-Reply-To: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
Message-Id: <20180607152534.29427-4-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PMU regset exposed through ptrace has 5 64-bit words, which are
all copied in and out. However, mmcr0 in the thread_struct is an
unsigned, which causes pmu_set to clobber the next variable in the
thread_struct (used_ebb), and pmu_get to return the same variable in
one half of the mmcr0 slot.
---
 arch/powerpc/kernel/ptrace.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index be8ca03a0bd5..69123feaef9e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1733,6 +1733,9 @@ static int pmu_get(struct task_struct *target,
 		      unsigned int pos, unsigned int count,
 		      void *kbuf, void __user *ubuf)
 {
+	int ret = 0;
+	unsigned long mmcr0 = target->thread.mmcr0;
+
 	/* Build tests */
 	BUILD_BUG_ON(TSO(siar) + sizeof(unsigned long) != TSO(sdar));
 	BUILD_BUG_ON(TSO(sdar) + sizeof(unsigned long) != TSO(sier));
@@ -1742,9 +1745,16 @@ static int pmu_get(struct task_struct *target,
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return -ENODEV;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-			&target->thread.siar, 0,
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+		&target->thread.siar, 0,
+		4 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&mmcr0, 4 * sizeof(unsigned long),
 			5 * sizeof(unsigned long));
+
+	return ret;
 }
 
 static int pmu_set(struct task_struct *target,
@@ -1754,6 +1764,12 @@ static int pmu_set(struct task_struct *target,
 {
 	int ret = 0;
 
+#ifdef __BIG_ENDIAN
+	int mmcr0_offset = sizeof(unsigned);
+#else
+	int mmcr0_offset = 0;
+#endif
+
 	/* Build tests */
 	BUILD_BUG_ON(TSO(siar) + sizeof(unsigned long) != TSO(sdar));
 	BUILD_BUG_ON(TSO(sdar) + sizeof(unsigned long) != TSO(sier));
@@ -1783,9 +1799,16 @@ static int pmu_set(struct task_struct *target,
 			4 * sizeof(unsigned long));
 
 	if (!ret)
+		ret = user_regset_copyin_ignore(&pos, &count, &kbuf,
+			&ubuf, 4 * sizeof(unsigned long),
+			4 * sizeof(unsigned long) + mmcr0_offset);
+
+	if (!ret)
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-			&target->thread.mmcr0, 4 * sizeof(unsigned long),
-			5 * sizeof(unsigned long));
+			&target->thread.mmcr0,
+			4 * sizeof(unsigned long) + mmcr0_offset,
+			4 * sizeof(unsigned long) + mmcr0_offset
+			+ sizeof (unsigned));
 	return ret;
 }
 #endif
-- 
2.13.6
