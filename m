Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcN3FvhzF1P9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:00 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id q83so13299340wme.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:00 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 04/21] powerpc: Mark both tmp variables as unused
Date: Sun, 25 Feb 2018 18:22:19 +0100
Message-Id: <20180225172236.29650-5-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the value of `tmp` is never intended to be read, declare both `tmp`
variables as unused. Fix warning (treated as error in W=1):

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function ‘sys_swapcontext’:
arch/powerpc/kernel/signal_32.c:1048:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
  unsigned char tmp;
                ^~~
arch/powerpc/kernel/signal_32.c: In function ‘sys_debug_setcontext’:
arch/powerpc/kernel/signal_32.c:1234:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
  unsigned char tmp;
                ^~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/signal_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index a46de0035214..492f03451877 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1045,7 +1045,7 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 		     struct ucontext __user *new_ctx,
 		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
 {
-	unsigned char tmp;
+	unsigned char tmp __maybe_unused;
 	int ctx_has_vsx_region = 0;
 
 #ifdef CONFIG_PPC64
@@ -1231,7 +1231,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 {
 	struct sig_dbg_op op;
 	int i;
-	unsigned char tmp;
+	unsigned char tmp __maybe_unused;
 	unsigned long new_msr = regs->msr;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long new_dbcr0 = current->thread.debug.dbcr0;
-- 
2.11.0
