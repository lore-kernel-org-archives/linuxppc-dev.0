Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMBv6SC4zF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:35 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id h4-v6so888561qtj.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:35 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 4/9] powerpc/pkeys: Save the pkey registers before fork
Date: Tue, 17 Jul 2018 06:51:05 -0700
Message-Id: <1531835470-32691-5-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
References: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a thread forks the contents of AMR, IAMR, UAMOR registers in the
newly forked thread are not inherited.

Save the registers before forking, for content of those
registers to be automatically copied into the new thread.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/kernel/process.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ef4aea..991d097 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -583,6 +583,7 @@ static void save_all(struct task_struct *tsk)
 		__giveup_spe(tsk);
 
 	msr_check_and_clear(msr_all_available);
+	thread_pkey_regs_save(&tsk->thread);
 }
 
 void flush_all_to_thread(struct task_struct *tsk)
-- 
1.7.1
