Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcV6DczzF1Ny
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:06 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id t74so13320218wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:06 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 10/21] powerpc: Add missing prototype for slb_miss_bad_addr
Date: Sun, 25 Feb 2018 18:22:25 +0100
Message-Id: <20180225172236.29650-11-malat@debian.org>
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

In commit f0f558b131db ("powerpc/mm: Preserve CFAR value on SLB miss caused
by access to bogus address"), the function slb_miss_bad_addr was added
without a prototype. This commit adds it.

Fix a warning (treated as error in W=1):

  CC      arch/powerpc/kernel/traps.o
arch/powerpc/kernel/traps.c:1498:6: error: no previous prototype for ‘slb_miss_bad_addr’ [-Werror=missing-prototypes]
 void slb_miss_bad_addr(struct pt_regs *regs)
      ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7330150bfe34..0af1925e30db 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -62,6 +62,7 @@ void RunModeException(struct pt_regs *regs);
 void single_step_exception(struct pt_regs *regs);
 void program_check_exception(struct pt_regs *regs);
 void alignment_exception(struct pt_regs *regs);
+void slb_miss_bad_addr(struct pt_regs *regs);
 void StackOverflow(struct pt_regs *regs);
 void nonrecoverable_exception(struct pt_regs *regs);
 void kernel_fp_unavailable_exception(struct pt_regs *regs);
-- 
2.11.0
