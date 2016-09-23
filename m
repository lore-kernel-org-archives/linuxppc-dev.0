Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgNVB2cmGzDsmj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:58 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N6HbPt073768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:55 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25mqb79a2x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:54 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 23 Sep 2016 16:18:51 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4B1D22BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N6Im0a6160842
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N6Il2x007746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 04/20] powerpc: Return the new MSR from msr_check_and_set()
Date: Fri, 23 Sep 2016 16:18:10 +1000
In-Reply-To: <20160923061826.30790-1-cyrilbur@gmail.com>
References: <20160923061826.30790-1-cyrilbur@gmail.com>
Message-Id: <20160923061826.30790-5-cyrilbur@gmail.com>
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
index 9dddabc..a8f63bc 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1250,7 +1250,7 @@ static inline void mtmsr_isync(unsigned long val)
 				     : "memory")
 #endif
 
-extern void msr_check_and_set(unsigned long bits);
+extern unsigned long msr_check_and_set(unsigned long bits);
 extern bool strict_msr_control;
 extern void __msr_check_and_clear(unsigned long bits);
 static inline void msr_check_and_clear(unsigned long bits)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5029567..34ee5f2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -111,7 +111,7 @@ static int __init enable_strict_msr_control(char *str)
 }
 early_param("ppc_strict_facility_enable", enable_strict_msr_control);
 
-void msr_check_and_set(unsigned long bits)
+unsigned long msr_check_and_set(unsigned long bits)
 {
 	unsigned long oldmsr = mfmsr();
 	unsigned long newmsr;
@@ -125,6 +125,8 @@ void msr_check_and_set(unsigned long bits)
 
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
+
+	return newmsr;
 }
 
 void __msr_check_and_clear(unsigned long bits)
-- 
2.10.0
