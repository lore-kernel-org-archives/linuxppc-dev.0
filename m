Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcV3Vp1zF1Nq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:06 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id s5so18866044wra.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:06 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 09/21] powerpc: Make function save_all static
Date: Sun, 25 Feb 2018 18:22:24 +0100
Message-Id: <20180225172236.29650-10-malat@debian.org>
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

Since function `save_all` is not meant to be exported, change the signature
to `static`. Fix warning (treated as error with W=1):

  CC      arch/powerpc/kernel/process.o
arch/powerpc/kernel/process.c:559:6: error: no previous prototype for ‘save_all’ [-Werror=missing-prototypes]
 void save_all(struct task_struct *tsk)
      ^~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3ac98c0463d6..ec4f363ebb89 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -556,7 +556,7 @@ void restore_math(struct pt_regs *regs)
 	regs->msr = msr;
 }
 
-void save_all(struct task_struct *tsk)
+static void save_all(struct task_struct *tsk)
 {
 	unsigned long usermsr;
 
-- 
2.11.0
