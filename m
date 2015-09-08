Return-Path: <tim.gardner@canonical.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E65B21A1F43
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 04:13:31 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so133541156pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2015 11:13:29 -0700 (PDT)
From: tim.gardner@canonical.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] powerpc: define empty enable_kernel_vsx() when CONFIG_VSX=n
Date: Tue,  8 Sep 2015 12:13:11 -0600
Message-Id: <1441735991-29199-1-git-send-email-tim.gardner@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tim Gardner <tim.gardner@canonical.com>

commit 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx()
routine available") neglected to define an empty inline replacement for
enable_kernel_vsx() when CONFIG_VSX=n.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 arch/powerpc/include/asm/switch_to.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 15cca17..dea61a0 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -29,7 +29,6 @@ static inline void save_early_sprs(struct thread_struct *prev) {}
 
 extern void enable_kernel_fp(void);
 extern void enable_kernel_altivec(void);
-extern void enable_kernel_vsx(void);
 extern int emulate_altivec(struct pt_regs *);
 extern void __giveup_vsx(struct task_struct *);
 extern void giveup_vsx(struct task_struct *);
@@ -69,10 +68,14 @@ static inline void giveup_altivec(struct task_struct *t)
 
 #ifdef CONFIG_VSX
 extern void flush_vsx_to_thread(struct task_struct *);
+extern void enable_kernel_vsx(void);
 #else
 static inline void flush_vsx_to_thread(struct task_struct *t)
 {
 }
+static inline void enable_kernel_vsx(void)
+{
+}
 #endif
 
 #ifdef CONFIG_SPE
-- 
1.9.1
