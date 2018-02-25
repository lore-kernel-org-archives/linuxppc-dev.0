Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcc2lHtzF1N4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:12 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id m207so12992799wma.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:12 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 17/21] powerpc: Add missing prototype for sys_debug_setcontext
Date: Sun, 25 Feb 2018 18:22:32 +0100
Message-Id: <20180225172236.29650-18-malat@debian.org>
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

In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
the function sys_debug_setcontext was added without a prototype.

Fix compilation warning (treated as error in W=1):

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
 int sys_debug_setcontext(struct ucontext __user *ctx,
     ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/asm-prototypes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 0af1925e30db..7c23d9ead694 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -89,6 +89,10 @@ int sys_swapcontext(struct ucontext __user *old_ctx,
 long sys_swapcontext(struct ucontext __user *old_ctx,
 		    struct ucontext __user *new_ctx,
 		    int ctx_size, int r6, int r7, int r8, struct pt_regs *regs);
+int sys_debug_setcontext(struct ucontext __user *ctx,
+			 int ndbg, struct sig_dbg_op __user *dbg,
+			 int r6, int r7, int r8,
+			 struct pt_regs *regs);
 #endif
 long sys_switch_endian(void);
 notrace unsigned int __check_irq_replay(void);
-- 
2.11.0
