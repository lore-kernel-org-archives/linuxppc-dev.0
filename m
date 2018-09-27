Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF1BC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 17:21:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A734D2159D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 17:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A734D2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LhS80RgyzF385
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:21:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LhMs1ztJzF31F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 03:18:01 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42LhMn3wZKz9ttFc;
 Thu, 27 Sep 2018 19:17:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3Jw8qmyur8BT; Thu, 27 Sep 2018 19:17:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42LhMn3PHmz9ttBq;
 Thu, 27 Sep 2018 19:17:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 104568B8AF;
 Thu, 27 Sep 2018 19:17:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bxByy4QZAT70; Thu, 27 Sep 2018 19:17:57 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EBB18B8AE;
 Thu, 27 Sep 2018 19:17:57 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 577E86F1BA; Thu, 27 Sep 2018 17:17:57 +0000 (UTC)
Message-Id:
 <e5f8f6e3e5a5595be08127eefae8025ebbb691cc.1538068025.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] kdb: print real address of pointers instead of hashed
 addresses
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 27 Sep 2018 17:17:57 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927171757.tqZJFIUdB2J_N1_dizp49o2nzHSCbUIgDZ2d8gpBiPk@z>

Since commit ad67b74d2469 ("printk: hash addresses printed with %p"),
all pointers printed with %p are printed with hashed addresses
instead of real addresses in order to avoid leaking addresses in
dmesg and syslog. But this applies to kdb too, with is unfortunate:

    Entering kdb (current=0x(ptrval), pid 329) due to Keyboard Entry
    kdb> ps
    15 sleeping system daemon (state M) processes suppressed,
    use 'ps A' to see all.
    Task Addr       Pid   Parent [*] cpu State Thread     Command
    0x(ptrval)      329      328  1    0   R  0x(ptrval) *sh

    0x(ptrval)        1        0  0    0   S  0x(ptrval)  init
    0x(ptrval)        3        2  0    0   D  0x(ptrval)  rcu_gp
    0x(ptrval)        4        2  0    0   D  0x(ptrval)  rcu_par_gp
    0x(ptrval)        5        2  0    0   D  0x(ptrval)  kworker/0:0
    0x(ptrval)        6        2  0    0   D  0x(ptrval)  kworker/0:0H
    0x(ptrval)        7        2  0    0   D  0x(ptrval)  kworker/u2:0
    0x(ptrval)        8        2  0    0   D  0x(ptrval)  mm_percpu_wq
    0x(ptrval)       10        2  0    0   D  0x(ptrval)  rcu_preempt

The whole purpose of kdb is to debug, and for debugging real addresses
need to be known. In addition, data displayed by kdb doesn't go into
dmesg.

This patch replaces all %p by %px in kdb in order to display real
addresses.

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 kernel/debug/kdb/kdb_main.c    | 14 +++++++-------
 kernel/debug/kdb/kdb_support.c | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 2ddfce8f1e8f..f338d23b112b 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1192,7 +1192,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 	if (reason == KDB_REASON_DEBUG) {
 		/* special case below */
 	} else {
-		kdb_printf("\nEntering kdb (current=0x%p, pid %d) ",
+		kdb_printf("\nEntering kdb (current=0x%px, pid %d) ",
 			   kdb_current, kdb_current ? kdb_current->pid : 0);
 #if defined(CONFIG_SMP)
 		kdb_printf("on processor %d ", raw_smp_processor_id());
@@ -1208,7 +1208,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		 */
 		switch (db_result) {
 		case KDB_DB_BPT:
-			kdb_printf("\nEntering kdb (0x%p, pid %d) ",
+			kdb_printf("\nEntering kdb (0x%px, pid %d) ",
 				   kdb_current, kdb_current->pid);
 #if defined(CONFIG_SMP)
 			kdb_printf("on processor %d ", raw_smp_processor_id());
@@ -2048,7 +2048,7 @@ static int kdb_lsmod(int argc, const char **argv)
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
-		kdb_printf("%-20s%8u  0x%p ", mod->name,
+		kdb_printf("%-20s%8u  0x%px ", mod->name,
 			   mod->core_layout.size, (void *)mod);
 #ifdef CONFIG_MODULE_UNLOAD
 		kdb_printf("%4d ", module_refcount(mod));
@@ -2059,7 +2059,7 @@ static int kdb_lsmod(int argc, const char **argv)
 			kdb_printf(" (Loading)");
 		else
 			kdb_printf(" (Live)");
-		kdb_printf(" 0x%p", mod->core_layout.base);
+		kdb_printf(" 0x%px", mod->core_layout.base);
 
 #ifdef CONFIG_MODULE_UNLOAD
 		{
@@ -2341,7 +2341,7 @@ void kdb_ps1(const struct task_struct *p)
 		return;
 
 	cpu = kdb_process_cpu(p);
-	kdb_printf("0x%p %8d %8d  %d %4d   %c  0x%p %c%s\n",
+	kdb_printf("0x%px %8d %8d  %d %4d   %c  0x%px %c%s\n",
 		   (void *)p, p->pid, p->parent->pid,
 		   kdb_task_has_cpu(p), kdb_process_cpu(p),
 		   kdb_task_state_char(p),
@@ -2354,7 +2354,7 @@ void kdb_ps1(const struct task_struct *p)
 		} else {
 			if (KDB_TSK(cpu) != p)
 				kdb_printf("  Error: does not match running "
-				   "process table (0x%p)\n", KDB_TSK(cpu));
+				   "process table (0x%px)\n", KDB_TSK(cpu));
 		}
 	}
 }
@@ -2692,7 +2692,7 @@ int kdb_register_flags(char *cmd,
 	for_each_kdbcmd(kp, i) {
 		if (kp->cmd_name && (strcmp(kp->cmd_name, cmd) == 0)) {
 			kdb_printf("Duplicate kdb command registered: "
-				"%s, func %p help %s\n", cmd, func, help);
+				"%s, func %px help %s\n", cmd, func, help);
 			return 1;
 		}
 	}
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 990b3cc526c8..987eb73284d2 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -40,7 +40,7 @@
 int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
 {
 	if (KDB_DEBUG(AR))
-		kdb_printf("kdbgetsymval: symname=%s, symtab=%p\n", symname,
+		kdb_printf("kdbgetsymval: symname=%s, symtab=%px\n", symname,
 			   symtab);
 	memset(symtab, 0, sizeof(*symtab));
 	symtab->sym_start = kallsyms_lookup_name(symname);
@@ -88,7 +88,7 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 	char *knt1 = NULL;
 
 	if (KDB_DEBUG(AR))
-		kdb_printf("kdbnearsym: addr=0x%lx, symtab=%p\n", addr, symtab);
+		kdb_printf("kdbnearsym: addr=0x%lx, symtab=%px\n", addr, symtab);
 	memset(symtab, 0, sizeof(*symtab));
 
 	if (addr < 4096)
@@ -149,7 +149,7 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 		symtab->mod_name = "kernel";
 	if (KDB_DEBUG(AR))
 		kdb_printf("kdbnearsym: returns %d symtab->sym_start=0x%lx, "
-		   "symtab->mod_name=%p, symtab->sym_name=%p (%s)\n", ret,
+		   "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
 		   symtab->sym_start, symtab->mod_name, symtab->sym_name,
 		   symtab->sym_name);
 
@@ -887,13 +887,13 @@ void debug_kusage(void)
 		   __func__, dah_first);
 	if (dah_first) {
 		h_used = (struct debug_alloc_header *)debug_alloc_pool;
-		kdb_printf("%s: h_used %p size %d\n", __func__, h_used,
+		kdb_printf("%s: h_used %px size %d\n", __func__, h_used,
 			   h_used->size);
 	}
 	do {
 		h_used = (struct debug_alloc_header *)
 			  ((char *)h_free + dah_overhead + h_free->size);
-		kdb_printf("%s: h_used %p size %d caller %p\n",
+		kdb_printf("%s: h_used %px size %d caller %px\n",
 			   __func__, h_used, h_used->size, h_used->caller);
 		h_free = (struct debug_alloc_header *)
 			  (debug_alloc_pool + h_free->next);
@@ -902,7 +902,7 @@ void debug_kusage(void)
 		  ((char *)h_free + dah_overhead + h_free->size);
 	if ((char *)h_used - debug_alloc_pool !=
 	    sizeof(debug_alloc_pool_aligned))
-		kdb_printf("%s: h_used %p size %d caller %p\n",
+		kdb_printf("%s: h_used %px size %d caller %px\n",
 			   __func__, h_used, h_used->size, h_used->caller);
 out:
 	spin_unlock(&dap_lock);
-- 
2.13.3

