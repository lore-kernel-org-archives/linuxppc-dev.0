Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61947B71B2
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Feb 2012 02:06:11 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 8 Feb 2012 10:06:01 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D780F38C806C
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2012 10:05:24 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q18F5NPT147456
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Feb 2012 10:05:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q18F5Ev3008499
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Feb 2012 13:05:23 -0200
Date: Wed, 8 Feb 2012 20:23:13 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2 ] Implement GET_IP/SET_IP for powerpc architecture.
Message-ID: <20120208145124.GA16600@linux.vnet.ibm.com>
References: <20120202144125.GA6221@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120202144125.GA6221@linux.vnet.ibm.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this change, helpers such as instruction_pointer() et al, get defined
in the generic header in terms of GET_IP

Removed the unnecessary definition of profile_pc in !CONFIG_SMP case as
suggested by Mike Frysinger.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 78a2051..84cc784 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -83,8 +83,18 @@ struct pt_regs {
 
 #ifndef __ASSEMBLY__
 
-#define instruction_pointer(regs) ((regs)->nip)
-#define user_stack_pointer(regs) ((regs)->gpr[1])
+#define GET_IP(regs)		((regs)->nip)
+#define GET_USP(regs)		((regs)->gpr[1])
+#define GET_FP(regs)		(0)
+#define SET_FP(regs, val)
+
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#define profile_pc profile_pc
+#endif
+
+#include <asm-generic/ptrace.h>
+
 #define kernel_stack_pointer(regs) ((regs)->gpr[1])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
@@ -99,12 +109,6 @@ static inline long regs_return_value(struct pt_regs *regs)
 		return -regs->gpr[3];
 }
 
-#ifdef CONFIG_SMP
-extern unsigned long profile_pc(struct pt_regs *regs);
-#else
-#define profile_pc(regs) instruction_pointer(regs)
-#endif
-
 #ifdef __powerpc64__
 #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
 #else
