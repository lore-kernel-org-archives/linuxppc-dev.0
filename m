Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415kyW4xyczDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:29:23 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id h5-v6so4221815qtm.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:29:23 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: [PATCH v2 2/6] powerpc/pkeys: Save the pkey registers before fork
Date: Wed, 13 Jun 2018 17:29:00 -0700
Message-Id: <1528936144-6696-3-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
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

CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Florian Weimer <fweimer@redhat.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
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
