Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whHb73DKwzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 00:42:11 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55EdH9T141725
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 10:42:08 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aw92cgm3s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 10:42:08 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 5 Jun 2017 11:42:06 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55Eg32217236220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 11:42:03 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v55Ef4C3030227
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 11:41:04 -0300
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/kernel: Initialize load_tm on task creation
Date: Mon,  5 Jun 2017 11:40:59 -0300
Message-Id: <1496673659-18499-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently tsk->thread.load_tm is not initialized in the task creation
and can contain garbage on a new task.

This is an undesired behaviour, since it affects the timing to enable
and disable the transactional memory laziness (disabling and enabling
the MSR TM bit, which affects TM reclaim and recheckpoint in the
scheduling process).

CC: Anton Blanchard <anton@samba.org>
Fixes: 5d176f751ee3c6eededd984ad409bff201f436a7
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a9435397eab8..2ad725ef4368 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1687,6 +1687,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_tfhar = 0;
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
+	current->thread.load_tm = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 }
 EXPORT_SYMBOL(start_thread);
-- 
2.11.0
