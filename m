Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcc3M2rzF1Ny
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:12 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id a20so13821496wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:12 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 18/21] powerpc: Add missing prototypes for sys_sigreturn &
 sys_rt_sigreturn
Date: Sun, 25 Feb 2018 18:22:33 +0100
Message-Id: <20180225172236.29650-19-malat@debian.org>
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

Two functions did not have a prototype defined in signal.h header. Fix the
following two warnings (treated as errors in W=1):

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c:1135:6: error: no previous prototype for ‘sys_rt_sigreturn’ [-Werror=missing-prototypes]
 long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
      ^~~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1422:6: error: no previous prototype for ‘sys_sigreturn’ [-Werror=missing-prototypes]
 long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
      ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/signal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 7c59d88b9d86..a6467f843acf 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -49,6 +49,11 @@ extern int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 #else /* CONFIG_PPC64 */
 
+extern long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
+		     struct pt_regs *regs);
+extern long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
+		       struct pt_regs *regs);
+
 static inline int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 				     struct task_struct *tsk)
 {
-- 
2.11.0
