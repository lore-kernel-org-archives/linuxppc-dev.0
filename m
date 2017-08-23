Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcpr26yJGzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 23:56:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/oops: Print the kernel's endian in the oops
Date: Wed, 23 Aug 2017 23:56:21 +1000
Message-Id: <1503496584-21970-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
References: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although the MSR tells you what endian you're in it's possible that
isn't the same endian the kernel was built for, and if that happens
you're usually having a very bad day. So print a marker to make
it 100% clear which endian the kernel was built for.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 82d0ce236f9d..5a54a6f54f70 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -202,6 +202,12 @@ NOKPROBE_SYMBOL(oops_end);
 static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
+
+	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
+		printk("LE ");
+	else
+		printk("BE ");
+
 #ifdef CONFIG_PREEMPT
 	pr_cont("PREEMPT ");
 #endif
-- 
2.7.4
