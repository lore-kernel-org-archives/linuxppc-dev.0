Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZD4XHKzDrpw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:40 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85Nh1It144474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:38 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259dmh0abs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:38 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 742402CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:33 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjXlv3342776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:33 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjXQr031651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:33 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 04/20] powerpc: Return the new MSR from msr_check_and_set()
Date: Tue,  6 Sep 2016 09:44:32 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-5-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

msr_check_and_set() always performs a mfmsr() to determine if it needs
to perform an mtmsr(), as mfmsr() can be a costly operation
msr_check_and_set() could return the MSR now on the CPU to avoid
callers of msr_check_and_set having to make their own mfmsr() call.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 2 +-
 arch/powerpc/kernel/process.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f69f40f..0a3dde9 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1247,7 +1247,7 @@ static inline void mtmsr_isync(unsigned long val)
 				     : "memory")
 #endif
 
-extern void msr_check_and_set(unsigned long bits);
+extern unsigned long msr_check_and_set(unsigned long bits);
 extern bool strict_msr_control;
 extern void __msr_check_and_clear(unsigned long bits);
 static inline void msr_check_and_clear(unsigned long bits)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 82308fd..c42581b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -110,7 +110,7 @@ static int __init enable_strict_msr_control(char *str)
 }
 early_param("ppc_strict_facility_enable", enable_strict_msr_control);
 
-void msr_check_and_set(unsigned long bits)
+unsigned long msr_check_and_set(unsigned long bits)
 {
 	unsigned long oldmsr = mfmsr();
 	unsigned long newmsr;
@@ -124,6 +124,8 @@ void msr_check_and_set(unsigned long bits)
 
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
+
+	return newmsr;
 }
 
 void __msr_check_and_clear(unsigned long bits)
-- 
2.9.3
