Return-Path: <leosilva@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DF381A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 02:51:09 +1000 (AEST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leosilva@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 13:51:05 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 634781DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 12:50:02 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6DGpP1A5099688
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 13:51:25 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6DGp2k5010610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 13:51:02 -0300
Date: Mon, 13 Jul 2015 13:51:01 -0300
From: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>,
 pfsmorigo@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/2] Uncomment and make enable_kernel_vsx() routine available
Message-ID: <20150713165057.GA6594@bluepex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

enable_kernel_vsx() function was commented since anything was using
it. However, vmx-crypto driver uses VSX instructions which are
only available if VSX is enable. Otherwise it rises an exception oops.

This patch uncomment enable_kernel_vsx() routine and makes it available.

Signed-off-by: Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/switch_to.h | 1 +
 arch/powerpc/kernel/process.c        | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 58abeda..15cca17 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -29,6 +29,7 @@ static inline void save_early_sprs(struct thread_struct *prev) {}
 
 extern void enable_kernel_fp(void);
 extern void enable_kernel_altivec(void);
+extern void enable_kernel_vsx(void);
 extern int emulate_altivec(struct pt_regs *);
 extern void __giveup_vsx(struct task_struct *);
 extern void giveup_vsx(struct task_struct *);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8005e18..64e6e9d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -204,8 +204,6 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
-#if 0
-/* not currently used, but some crazy RAID module might want to later */
 void enable_kernel_vsx(void)
 {
 	WARN_ON(preemptible());
@@ -220,7 +218,6 @@ void enable_kernel_vsx(void)
 #endif /* CONFIG_SMP */
 }
 EXPORT_SYMBOL(enable_kernel_vsx);
-#endif
 
 void giveup_vsx(struct task_struct *tsk)
 {
-- 
2.1.0
