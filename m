Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE941A09B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 21:36:01 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mmarek@suse.cz, akpm@linux-foundation.org, jbaron@akamai.com,
 peterz@infradead.org, liuj97@gmail.com, mingo@kernel.org, mgorman@suse.de,
 linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 ralf@linux-mips.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 rostedt@goodmis.org
Subject: [PATCH 2/3] jump_label: Allow jump labels to be used in assembly
Date: Wed,  7 Jan 2015 21:35:57 +1100
Message-Id: <1420626958-31254-2-git-send-email-anton@samba.org>
In-Reply-To: <1420626958-31254-1-git-send-email-anton@samba.org>
References: <1420626958-31254-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To use jump labels in assembly we need the HAVE_JUMP_LABEL define,
so we select a fallback version if the toolchain does not support
them.

Modify linux/jump_label.h so it can be included by assembly files.
We also need to add -DCC_HAVE_ASM_GOTO to KBUILD_AFLAGS.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 Makefile                   |  1 +
 include/linux/jump_label.h | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ef748e1..7b83c3f 100644
--- a/Makefile
+++ b/Makefile
@@ -774,6 +774,7 @@ KBUILD_ARFLAGS := $(call ar-option,D)
 # check for 'asm goto'
 ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC)), y)
 	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
 include $(srctree)/scripts/Makefile.extrawarn
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 98f923b6..f4de473 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -45,6 +45,12 @@
  * same as using STATIC_KEY_INIT_FALSE.
  */
 
+#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
+# define HAVE_JUMP_LABEL
+#endif
+
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bug.h>
@@ -55,7 +61,7 @@ extern bool static_key_initialized;
 				    "%s used before call to jump_label_init", \
 				    __func__)
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
+#ifdef HAVE_JUMP_LABEL
 
 struct static_key {
 	atomic_t enabled;
@@ -66,13 +72,18 @@ struct static_key {
 #endif
 };
 
-# include <asm/jump_label.h>
-# define HAVE_JUMP_LABEL
 #else
 struct static_key {
 	atomic_t enabled;
 };
-#endif	/* CC_HAVE_ASM_GOTO && CONFIG_JUMP_LABEL */
+#endif	/* HAVE_JUMP_LABEL */
+#endif /* __ASSEMBLY__ */
+
+#ifdef HAVE_JUMP_LABEL
+#include <asm/jump_label.h>
+#endif
+
+#ifndef __ASSEMBLY__
 
 enum jump_label_type {
 	JUMP_LABEL_DISABLE = 0,
@@ -203,3 +214,5 @@ static inline bool static_key_enabled(struct static_key *key)
 }
 
 #endif	/* _LINUX_JUMP_LABEL_H */
+
+#endif /* __ASSEMBLY__ */
-- 
2.1.0
