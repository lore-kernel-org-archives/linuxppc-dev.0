Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNp2jPTzDr8c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:14 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSZq7081048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:12 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24rqx1x78x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:07 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B000D3578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNT1tV32964692
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNT1hb003473
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:01 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 04/20] powerpc: Return the new MSR from msr_check_and_set()
Date: Fri, 12 Aug 2016 09:28:03 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-5-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mfmsr() is a fairly expensive call and callers of msr_check_and_set()
may want to make decisions bits in the MSR that it did not change but
may not know the value of.

This patch would avoid a two calls to mfmsr().

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
index 79f0615..216cf05 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -104,7 +104,7 @@ static int __init enable_strict_msr_control(char *str)
 }
 early_param("ppc_strict_facility_enable", enable_strict_msr_control);
 
-void msr_check_and_set(unsigned long bits)
+unsigned long msr_check_and_set(unsigned long bits)
 {
 	unsigned long oldmsr = mfmsr();
 	unsigned long newmsr;
@@ -118,6 +118,8 @@ void msr_check_and_set(unsigned long bits)
 
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
+
+	return newmsr;
 }
 
 void __msr_check_and_clear(unsigned long bits)
-- 
2.9.2
