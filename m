Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2B50DE839
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:24:42 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m67ENh0V001094
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 00:23:43 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67EMx4c2527370
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 00:22:59 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67ENQCD003182
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 00:23:26 +1000
From: Srinivasa D S <srinivasa@in.ibm.com>
To: linuxppc-dev@ozlabs.org, Ananth Mavinakayanahalli <ananth@in.ibm.com>,
	benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC] [PATCH] task_pt_regs for powerpc systems
Date: Mon, 7 Jul 2008 19:52:27 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807071952.27427.srinivasa@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi
 task_pt_regs() macro defines pt_regs for the given task,  this macro is  
currently not defined for powerpc arch. We need this macro for 
upcoming utrace features. 
 Below attached patch  defines this macro for powerpc arch. Please let 
me know your comments on this.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>


---
 include/asm-powerpc/processor.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.26-rc9/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6.26-rc9.orig/include/asm-powerpc/processor.h
+++ linux-2.6.26-rc9/include/asm-powerpc/processor.h
@@ -214,6 +214,8 @@ struct thread_struct {
 #define thread_saved_pc(tsk)    \
         ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 
+#define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)
+
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
