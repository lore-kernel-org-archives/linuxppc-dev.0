Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXJfR0DthzDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:02:38 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc: Fix missing CR before {
Date: Wed, 16 Aug 2017 16:01:15 +1000
Message-Id: <20170816060118.24803-2-benh@kernel.crashing.org>
In-Reply-To: <20170816060118.24803-1-benh@kernel.crashing.org>
References: <20170816060118.24803-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 883216b4296a..14b9a3c46c5d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -230,7 +230,8 @@ void enable_kernel_fp(void)
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
-static int restore_fp(struct task_struct *tsk) {
+static int restore_fp(struct task_struct *tsk)
+{
 	if (tsk->thread.load_fp || msr_tm_active(tsk->thread.regs->msr)) {
 		load_fp_state(&current->thread.fp_state);
 		current->thread.load_fp++;
-- 
2.13.4
