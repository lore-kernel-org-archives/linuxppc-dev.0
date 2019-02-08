Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DCAC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:45:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDF02075C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="O40UEtSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDF02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wydj59BXzDqcP
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:45:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="O40UEtSQ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wyXh24qkzDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 01:40:52 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43wyXY6gw7z9vBwc;
 Fri,  8 Feb 2019 15:40:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=O40UEtSQ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id zYTMgxMD0fV5; Fri,  8 Feb 2019 15:40:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43wyXY5PXkz9vBwZ;
 Fri,  8 Feb 2019 15:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549636845; bh=5GG72cfsOyRs1FMwnBMqAfDwn15LcXCsOplueh6doO0=;
 h=From:Subject:To:Cc:Date:From;
 b=O40UEtSQxXdfDb/419Re+wWnkIIt+yZhnDbLDDNb+AktAn0M8c+EZhMz44A9SPEx8
 DK2jD4twcM9JkfHglLX+MThSGZxrk3Tg84BzSvr1ikAfnrITj2QJCO19Ec21WRzBcN
 dhupWUw05SB2gjleGFvIcmOH7kvp0Y/UNFFhEIjE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B10F8B8DA;
 Fri,  8 Feb 2019 15:40:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ejnY7pB_f5qS; Fri,  8 Feb 2019 15:40:47 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 05AF48B756;
 Fri,  8 Feb 2019 15:40:47 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id CB010656D3; Fri,  8 Feb 2019 14:40:46 +0000 (UTC)
Message-Id: <a952f14712b90f182c0fcace434b2a0e9f21ed9f.1549636481.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1] powerpc/accounting: do not account system time on
 transition to user.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri,  8 Feb 2019 14:40:46 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Time spent in kernel mode don't need to be accounted on transition
to user space. As far as the time spent in user is known, it
is possible to calculate the time spent in kernel by substracting
the time spent in user.

To do so, this patch modifies vtime_delta() to substract the
time spent in user since the last call to vtime_delta().

This patch gives a 2% improvment of null_syscall() selftest on a 83xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
But surprisingly, this patch degrades the null_syscall selftest by 20% on the 8xx. Any idea of the reason ?

 arch/powerpc/include/asm/accounting.h | 1 +
 arch/powerpc/include/asm/ppc_asm.h    | 8 +-------
 arch/powerpc/kernel/asm-offsets.c     | 8 ++------
 arch/powerpc/kernel/time.c            | 4 +++-
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/accounting.h b/arch/powerpc/include/asm/accounting.h
index c607c5d835cc..2f1ff5f9fd7a 100644
--- a/arch/powerpc/include/asm/accounting.h
+++ b/arch/powerpc/include/asm/accounting.h
@@ -27,6 +27,7 @@ struct cpu_accounting_data {
 	/* Internal counters */
 	unsigned long starttime;	/* TB value snapshot */
 	unsigned long starttime_user;	/* TB value on exit to usermode */
+	unsigned long utime_asm;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	unsigned long startspurr;	/* SPURR value snapshot */
 	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index e0637730a8e7..be17d570d484 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -28,9 +28,8 @@
 #define ACCOUNT_STOLEN_TIME
 #else
 #define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)				\
-	MFTB(ra);			/* get timebase */		\
 	PPC_LL	rb, ACCOUNT_STARTTIME_USER(ptr);			\
-	PPC_STL	ra, ACCOUNT_STARTTIME(ptr);				\
+	MFTB(ra);			/* get timebase */		\
 	subf	rb,rb,ra;		/* subtract start value */	\
 	PPC_LL	ra, ACCOUNT_USER_TIME(ptr);				\
 	add	ra,ra,rb;		/* add on to user time */	\
@@ -38,12 +37,7 @@
 
 #define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)				\
 	MFTB(ra);			/* get timebase */		\
-	PPC_LL	rb, ACCOUNT_STARTTIME(ptr);				\
 	PPC_STL	ra, ACCOUNT_STARTTIME_USER(ptr);			\
-	subf	rb,rb,ra;		/* subtract start value */	\
-	PPC_LL	ra, ACCOUNT_SYSTEM_TIME(ptr);				\
-	add	ra,ra,rb;		/* add on to system time */	\
-	PPC_STL	ra, ACCOUNT_SYSTEM_TIME(ptr)
 
 #ifdef CONFIG_PPC_SPLPAR
 #define ACCOUNT_STOLEN_TIME						\
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7a1b93c5af63..f2ba7735f56f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -260,19 +260,15 @@ int main(void)
 	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
 	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
 	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
-	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
 	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
-	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
-	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
+	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime_asm);
 	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
 	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
 	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
 #else /* CONFIG_PPC64 */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	OFFSET(ACCOUNT_STARTTIME, thread_info, accounting.starttime);
 	OFFSET(ACCOUNT_STARTTIME_USER, thread_info, accounting.starttime_user);
-	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime);
-	OFFSET(ACCOUNT_SYSTEM_TIME, thread_info, accounting.stime);
+	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime_asm);
 #endif
 #endif /* CONFIG_PPC64 */
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc0503ef9c9c..79420643b45f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -331,8 +331,10 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	WARN_ON_ONCE(!irqs_disabled());
 
 	now = mftb();
-	stime = now - acct->starttime;
+	stime = now - acct->starttime - acct->utime_asm;
 	acct->starttime = now;
+	acct->utime += acct->utime_asm;
+	acct->utime_asm = 0;
 
 	*stime_scaled = vtime_delta_scaled(acct, now, stime);
 
-- 
2.13.3

