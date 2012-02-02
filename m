Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 34E6E104785
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2012 01:52:59 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 2 Feb 2012 09:52:55 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F22526E804B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2012 09:52:43 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q12EqfSq206490
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Feb 2012 09:52:41 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q12EqV3m003635
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Feb 2012 07:52:34 -0700
Date: Thu, 2 Feb 2012 20:11:25 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Implement GET_IP/SET_IP for powerpc architecture.
Message-ID: <20120202144125.GA6221@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 78a2051..889408d 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -83,8 +83,20 @@ struct pt_regs {
 
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
+#else
+#define profile_pc(regs) GET_IP(regs)
+#endif
+
+#include <asm-generic/ptrace.h>
+
 #define kernel_stack_pointer(regs) ((regs)->gpr[1])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
@@ -99,12 +111,6 @@ static inline long regs_return_value(struct pt_regs *regs)
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
