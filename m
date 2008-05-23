Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d0ac8dd211078f7a616bdf3b1e4e9144a576271f.1211516524.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Remove unnecessary cast in arch_deref_entry_point()
Date: Fri, 23 May 2008 14:22:21 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

func_descr_t->entry is already an unsigned long. Mea culpa.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/kprobes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index c176c51..23545a2 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -498,7 +498,7 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 #ifdef CONFIG_PPC64
 unsigned long arch_deref_entry_point(void *entry)
 {
-	return (unsigned long)(((func_descr_t *)entry)->entry);
+	return ((func_descr_t *)entry)->entry;
 }
 #endif
 
-- 
1.5.5
