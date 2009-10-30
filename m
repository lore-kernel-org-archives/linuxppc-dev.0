Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id BC9C4B7BAE
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:34 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 06/27] Add Book3s_64 intercept helpers
Date: Fri, 30 Oct 2009 16:47:06 +0100
Message-Id: <1256917647-6200-7-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to intercept interrupt vectors. To do that, let's add a file
we can always include which only activates the intercepts when we have
then configured.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s_64_asm.h |   58 ++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_book3s_64_asm.h

diff --git a/arch/powerpc/include/asm/kvm_book3s_64_asm.h b/arch/powerpc/include/asm/kvm_book3s_64_asm.h
new file mode 100644
index 0000000..2e06ee8
--- /dev/null
+++ b/arch/powerpc/include/asm/kvm_book3s_64_asm.h
@@ -0,0 +1,58 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright SUSE Linux Products GmbH 2009
+ *
+ * Authors: Alexander Graf <agraf@suse.de>
+ */
+
+#ifndef __ASM_KVM_BOOK3S_ASM_H__
+#define __ASM_KVM_BOOK3S_ASM_H__
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+
+#include <asm/kvm_asm.h>
+
+.macro DO_KVM intno
+	.if (\intno == BOOK3S_INTERRUPT_SYSTEM_RESET) || \
+	    (\intno == BOOK3S_INTERRUPT_MACHINE_CHECK) || \
+	    (\intno == BOOK3S_INTERRUPT_DATA_STORAGE) || \
+	    (\intno == BOOK3S_INTERRUPT_INST_STORAGE) || \
+	    (\intno == BOOK3S_INTERRUPT_DATA_SEGMENT) || \
+	    (\intno == BOOK3S_INTERRUPT_INST_SEGMENT) || \
+	    (\intno == BOOK3S_INTERRUPT_EXTERNAL) || \
+	    (\intno == BOOK3S_INTERRUPT_ALIGNMENT) || \
+	    (\intno == BOOK3S_INTERRUPT_PROGRAM) || \
+	    (\intno == BOOK3S_INTERRUPT_FP_UNAVAIL) || \
+	    (\intno == BOOK3S_INTERRUPT_DECREMENTER) || \
+	    (\intno == BOOK3S_INTERRUPT_SYSCALL) || \
+	    (\intno == BOOK3S_INTERRUPT_TRACE) || \
+	    (\intno == BOOK3S_INTERRUPT_PERFMON) || \
+	    (\intno == BOOK3S_INTERRUPT_ALTIVEC) || \
+	    (\intno == BOOK3S_INTERRUPT_VSX)
+
+	b	kvmppc_trampoline_\intno
+kvmppc_resume_\intno:
+
+	.endif
+.endm
+
+#else
+
+.macro DO_KVM intno
+.endm
+
+#endif /* CONFIG_KVM_BOOK3S_64_HANDLER */
+
+#endif /* __ASM_KVM_BOOK3S_ASM_H__ */
-- 
1.6.0.2
