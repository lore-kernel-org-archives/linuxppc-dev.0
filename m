Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcd5Pf1zF1Nq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:13 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id p104so18823394wrc.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:12 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 20/21] powerpc: Add missing prototypes for ppc_select &
 ppc_fadvise64_64
Date: Sun, 25 Feb 2018 18:22:35 +0100
Message-Id: <20180225172236.29650-21-malat@debian.org>
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

Add missing prototypes for ppc_select & ppc_fadvise64_64 to header
asm-prototypes.h. Fix the following warnings (treated as errors in W=1)

  CC      arch/powerpc/kernel/syscalls.o
arch/powerpc/kernel/syscalls.c:87:1: error: no previous prototype for ‘ppc_select’ [-Werror=missing-prototypes]
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
 ^~~~~~~~~~
arch/powerpc/kernel/syscalls.c:119:6: error: no previous prototype for ‘ppc_fadvise64_64’ [-Werror=missing-prototypes]
 long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
      ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/asm-prototypes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7c23d9ead694..4d8b89b46018 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -93,7 +93,11 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 			 int ndbg, struct sig_dbg_op __user *dbg,
 			 int r6, int r7, int r8,
 			 struct pt_regs *regs);
+int
+ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp);
 #endif
+long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
+		      u32 len_high, u32 len_low);
 long sys_switch_endian(void);
 notrace unsigned int __check_irq_replay(void);
 void notrace restore_interrupts(void);
-- 
2.11.0
