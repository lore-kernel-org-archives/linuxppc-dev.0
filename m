Return-Path: <kautuk.consul.1980@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq1Fv1B85zDqZ4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:19:15 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id zy2so1403915pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 03:19:15 -0700 (PDT)
From: Kautuk Consul <kautuk.consul.1980@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Kautuk Consul <kautuk.consul.1980@gmail.com>
Subject: [PATCH 1/1] powerpc: get_wchan(): solve possible race scenario due to
 parallel wakeup
Date: Tue, 19 Apr 2016 15:48:21 +0530
Message-Id: <1461061101-31196-1-git-send-email-kautuk.consul.1980@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a check for p->state == TASK_RUNNING so that any wake-ups on
task_struct p in the interim lead to 0 being returned by get_wchan().

Signed-off-by: Kautuk Consul <kautuk.consul.1980@gmail.com>
---
 arch/powerpc/kernel/process.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b8500b4..f233352 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1785,7 +1785,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 	do {
 		sp = *(unsigned long *)sp;
-		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD))
+		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD) ||
+		    p->state == TASK_RUNNING)
 			return 0;
 		if (count > 0) {
 			ip = ((unsigned long *)sp)[STACK_FRAME_LR_SAVE];
-- 
1.7.9.5
