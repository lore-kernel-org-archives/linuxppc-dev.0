Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcS33GMzF1NX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:04 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id q83so13299496wme.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:04 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 08/21] powerpc: Make function __giveup_fpu static
Date: Sun, 25 Feb 2018 18:22:23 +0100
Message-Id: <20180225172236.29650-9-malat@debian.org>
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

When CONFIG_PPC_FPU is defined the prototype exposed in asm/switch_to.h is:

  extern void giveup_fpu(struct task_struct *);

Change the function prototype of __giveup_fpu to static. Fix warning
(treated as error in W=1):

  CC      arch/powerpc/kernel/process.o
arch/powerpc/kernel/process.c:176:6: error: no previous prototype for ‘__giveup_fpu’ [-Werror=missing-prototypes]
 void __giveup_fpu(struct task_struct *tsk)
      ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1738c4127b32..3ac98c0463d6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -173,7 +173,7 @@ void __msr_check_and_clear(unsigned long bits)
 EXPORT_SYMBOL(__msr_check_and_clear);
 
 #ifdef CONFIG_PPC_FPU
-void __giveup_fpu(struct task_struct *tsk)
+static void __giveup_fpu(struct task_struct *tsk)
 {
 	unsigned long msr;
 
-- 
2.11.0
