Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA4201A010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 20:45:40 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7CF951400D2
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 20:45:40 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 13 Nov 2014 19:45:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B3BDF2BB005C
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 20:45:33 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAD9jIxW34996258
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 20:45:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAD9jVeN021081
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 20:45:33 +1100
Message-ID: <54647DA7.1070000@linux.vnet.ibm.com>
Date: Thu, 13 Nov 2014 15:15:11 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V4 7/8] powerpc, ptrace: Enable support for miscellaneous
 debug registers
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1415683597-22819-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1415683597-22819-8-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, dhowells@redhat.com, tglx@linutronix.de, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, davem@davemloft.net,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/2014 10:56 AM, Anshuman Khandual wrote:
> This patch enables get and set of miscellaneous debug registers through
> ptrace PTRACE_GETREGSET-PTRACE_SETREGSET interface by implementing new
> powerpc specific register set REGSET_MISC support corresponding to the
> new ELF core note NT_PPC_MISC added previously in this regard.

Right now this one does not compile for "ppc64e_defconfig" and
"pmac32_defconfig" config options. The patch below will fix it
and would be part of next revision.

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 61a2581..be566eb 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1326,6 +1326,7 @@ static int tm_cvmx_set(struct task_struct *target,
 }
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+#ifdef CONFIG_PPC64
 /*
  * get_misc_dbg
  *
@@ -1339,6 +1340,9 @@ static int tm_cvmx_set(struct task_struct *target,
  *	unsigned long ppr;
  *	unsigned long tar;
  * };
+ *
+ * The data element 'tar' will be valid only if the
+ * kernel has CONFIG_PPC_BOOK3S_64 config option enabled.
  */
 static int get_misc_dbg(struct task_struct *target,
 			const struct user_regset *regset, unsigned int pos,
@@ -1348,7 +1352,10 @@ static int get_misc_dbg(struct task_struct *target,
 
 	/* Build test */
 	BUILD_BUG_ON(TSO(dscr) + 2 * sizeof(unsigned long) != TSO(ppr));
+
+#ifdef CONFIG_PPC_BOOK3S_64
 	BUILD_BUG_ON(TSO(ppr) + sizeof(unsigned long) != TSO(tar));
+#endif
 
 	/* DSCR register */
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
@@ -1362,12 +1369,14 @@ static int get_misc_dbg(struct task_struct *target,
 						sizeof(unsigned long),
 						2 * sizeof(unsigned long));
 
+#ifdef CONFIG_PPC_BOOK3S_64
 	/* TAR register */
 	if (!ret)
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 						&target->thread.tar,
 						2 * sizeof(unsigned long),
 						3 * sizeof(unsigned long));
+#endif
 	return ret;
 }
 
@@ -1384,6 +1393,9 @@ static int get_misc_dbg(struct task_struct *target,
  *	unsigned long ppr;
  *	unsigned long tar;
  * };
+ *
+ * The data element 'tar' will be valid only if the
+ * kernel has CONFIG_PPC_BOOK3S_64 config option enabled.
  */
 static int set_misc_dbg(struct task_struct *target,
 			const struct user_regset *regset, unsigned int pos,
@@ -1394,7 +1406,10 @@ static int set_misc_dbg(struct task_struct *target,
 
 	/* Build test */
 	BUILD_BUG_ON(TSO(dscr) + 2 * sizeof(unsigned long) != TSO(ppr));
+
+#ifdef CONFIG_PPC_BOOK3S_64
 	BUILD_BUG_ON(TSO(ppr) + sizeof(unsigned long) != TSO(tar));
+#endif
 
 	/* DSCR register */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
@@ -1407,15 +1422,17 @@ static int set_misc_dbg(struct task_struct *target,
 						&target->thread.ppr,
 						sizeof(unsigned long),
 						2 * sizeof(unsigned long));
-
+#ifdef CONFIG_PPC_BOOK3S_64
 	/* TAR register */
 	if (!ret)
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 						&target->thread.tar,
 						2 * sizeof(unsigned long),
 						3 * sizeof(unsigned long));
+#endif
 	return ret;
 }
+#endif /* CONFIG_PPC64 */
 
 /*
  * These are our native regset flavors.
@@ -1438,7 +1455,9 @@ enum powerpc_regset {
 	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 #endif
+#ifdef CONFIG_PPC64
 	REGSET_MISC		/* Miscellaneous debug registers */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1495,11 +1514,13 @@ static const struct user_regset native_regsets[] = {
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+#ifdef CONFIG_PPC64
 	[REGSET_MISC] = {
 		.core_note_type = NT_PPC_MISC, .n = ELF_NMISCREG,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.get = get_misc_dbg, .set = set_misc_dbg
 	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_native_view = {
