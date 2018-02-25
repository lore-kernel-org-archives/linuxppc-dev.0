Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcZ535mzF1Ny
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:10 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id m5so18859936wrg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:10 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 14/21] powerpc: Add missing prototype for arch_irq_work_raise
Date: Sun, 25 Feb 2018 18:22:29 +0100
Message-Id: <20180225172236.29650-15-malat@debian.org>
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

In commit 4f8b50bbbe63 ("irq_work, ppc: Fix up arch hooks") a new function
arch_irq_work_raise was added without a prototype in header irq_work.h.

Fix the following warning (treated as error in W=1):

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c:523:6: error: no previous prototype for ‘arch_irq_work_raise’ [-Werror=missing-prototypes]
 void arch_irq_work_raise(void)
      ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/irq_work.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/irq_work.h b/arch/powerpc/include/asm/irq_work.h
index c6d3078bd8c3..b8b0be8f1a07 100644
--- a/arch/powerpc/include/asm/irq_work.h
+++ b/arch/powerpc/include/asm/irq_work.h
@@ -6,5 +6,6 @@ static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
 }
+extern void arch_irq_work_raise(void);
 
 #endif /* _ASM_POWERPC_IRQ_WORK_H */
-- 
2.11.0
