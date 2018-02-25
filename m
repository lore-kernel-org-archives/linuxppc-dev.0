Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcb5VqvzF1Mq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:11 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id k9so18846343wre.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:11 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 16/21] powerpc: Add missing prototype for init_IRQ
Date: Sun, 25 Feb 2018 18:22:31 +0100
Message-Id: <20180225172236.29650-17-malat@debian.org>
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

A function init_IRQ was added without a prototype declared in header irq.h.
Fix the following warning (treated as error in W=1):

  CC      arch/powerpc/kernel/irq.o
arch/powerpc/kernel/irq.c:662:13: error: no previous prototype for ‘init_IRQ’ [-Werror=missing-prototypes]
 void __init init_IRQ(void)
             ^~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index e8e3a0a04eb0..ee39ce56b2a2 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -66,6 +66,7 @@ extern void irq_ctx_init(void);
 extern void call_do_softirq(struct thread_info *tp);
 extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
 extern void do_IRQ(struct pt_regs *regs);
+extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
 
 int irq_choose_cpu(const struct cpumask *mask);
-- 
2.11.0
