Return-Path: <ananth@in.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5BCABDDF54
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 21:59:16 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1FAx7dD004596
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 05:59:07 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1FAx6qI279840
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 05:59:06 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1FAx6nL016477
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 05:59:06 -0500
Date: Fri, 15 Feb 2008 16:29:17 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: kill sparse warnings in kprobes
Message-ID: <20080215105917.GB6721@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, harvey.harrison@gmail.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Fix sparse warnings in powerpc kprobes:

  CHECK   arch/powerpc/kernel/kprobes.c
arch/powerpc/kernel/kprobes.c:277:6: warning: symbol 'kretprobe_trampoline_holder' was not declared. Should it be static?
arch/powerpc/kernel/kprobes.c:287:15: warning: symbol 'trampoline_probe_handler' was not declared. Should it be static?
arch/powerpc/kernel/kprobes.c:525:16: warning: symbol 'jprobe_return_end' was not declared. Should it be static?

Fix along the same lines as http://lkml.org/lkml/2008/2/13/642

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/kprobes.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.25-rc1/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.25-rc1.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.25-rc1/arch/powerpc/kernel/kprobes.c
@@ -274,7 +274,7 @@ no_kprobe:
  * 	- When the probed function returns, this probe
  * 		causes the handlers to fire
  */
-void kretprobe_trampoline_holder(void)
+static void __used kretprobe_trampoline_holder(void)
 {
 	asm volatile(".global kretprobe_trampoline\n"
 			"kretprobe_trampoline:\n"
@@ -284,7 +284,8 @@ void kretprobe_trampoline_holder(void)
 /*
  * Called when the probe at kretprobe trampoline is hit
  */
-int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes trampoline_probe_handler(struct kprobe *p,
+						struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
@@ -517,12 +518,12 @@ int __kprobes setjmp_pre_handler(struct 
 	return 1;
 }
 
-void __kprobes jprobe_return(void)
+void __used __kprobes jprobe_return(void)
 {
 	asm volatile("trap" ::: "memory");
 }
 
-void __kprobes jprobe_return_end(void)
+static void __used __kprobes jprobe_return_end(void)
 {
 };
 
