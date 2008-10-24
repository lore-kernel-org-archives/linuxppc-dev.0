Return-Path: <hollisb@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 397F2DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 03:59:14 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9OGx8VQ000489
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 12:59:08 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9OGx8f5144760
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 10:59:08 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9OGwduO032682
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 10:58:39 -0600
Subject: [RFC] a little disassembly infrastructure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-HUQCL72pl/I3P8EwwzEZ"
Date: Fri, 24 Oct 2008 11:59:06 -0500
Message-Id: <1224867546.9634.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HUQCL72pl/I3P8EwwzEZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, I wrote this patch for KVM [1], but now that I look closer it seems
like there might be some overlapping functionality.

First there's emulate_instruction(), but since that only handles a few
instructions it's just an ordered list of if ((instruction & MASK_A) ==
INST_A) tests, so it doesn't actually parse out opcodes or anything.

I've also found xmon's ppc-opc.c. That parses the opcode and operands,
so could use some shared macros. Of course, the actual lookup isn't
time-sensitive, so that doesn't make sense to share. On the other hand,
if we do come up with something fast *and* robust for KVM, maybe xmon
could use that.

Of course, these macros alone is pretty small, so maybe it's not a big
deal to make a kvm-specific copy of them, leaving the other uses alone.

Comments?

[1] KVM on PowerPC traps when privileged instructions are executed in
the guest context. We must then (quickly!) disassemble them and emulate
their behavior. Right now we do this with a giant switch statement or
two, but are considering more sophisticated techniques in the future.

-- 
Hollis Blanchard
IBM Linux Technology Center

--=-HUQCL72pl/I3P8EwwzEZ
Content-Disposition: attachment; filename=ppc-disassemble.diff
Content-Type: text/x-patch; name=ppc-disassemble.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

ppc: Create disassemble.h to extract instruction fields

This is used in a couple places in KVM, but isn't KVM-specific.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff --git a/arch/powerpc/include/asm/disassemble.h b/arch/powerpc/include/asm/disassemble.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/include/asm/disassemble.h
@@ -0,0 +1,80 @@
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
+ * Copyright IBM Corp. 2008
+ *
+ * Authors: Hollis Blanchard <hollisb@us.ibm.com>
+ */
+
+#ifndef __ASM_PPC_DISASSEMBLE_H__
+#define __ASM_PPC_DISASSEMBLE_H__
+
+#include <linux/types.h>
+
+static inline unsigned int get_op(u32 inst)
+{
+	return inst >> 26;
+}
+
+static inline unsigned int get_xop(u32 inst)
+{
+	return (inst >> 1) & 0x3ff;
+}
+
+static inline unsigned int get_sprn(u32 inst)
+{
+	return ((inst >> 16) & 0x1f) | ((inst >> 6) & 0x3e0);
+}
+
+static inline unsigned int get_dcrn(u32 inst)
+{
+	return ((inst >> 16) & 0x1f) | ((inst >> 6) & 0x3e0);
+}
+
+static inline unsigned int get_rt(u32 inst)
+{
+	return (inst >> 21) & 0x1f;
+}
+
+static inline unsigned int get_rs(u32 inst)
+{
+	return (inst >> 21) & 0x1f;
+}
+
+static inline unsigned int get_ra(u32 inst)
+{
+	return (inst >> 16) & 0x1f;
+}
+
+static inline unsigned int get_rb(u32 inst)
+{
+	return (inst >> 11) & 0x1f;
+}
+
+static inline unsigned int get_rc(u32 inst)
+{
+	return inst & 0x1;
+}
+
+static inline unsigned int get_ws(u32 inst)
+{
+	return (inst >> 11) & 0x1f;
+}
+
+static inline unsigned int get_d(u32 inst)
+{
+	return inst & 0xffff;
+}
+
+#endif /* __ASM_PPC_DISASSEMBLE_H__ */
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -28,62 +28,7 @@
 #include <asm/time.h>
 #include <asm/byteorder.h>
 #include <asm/kvm_ppc.h>
-
-/* Instruction decoding */
-static inline unsigned int get_op(u32 inst)
-{
-	return inst >> 26;
-}
-
-static inline unsigned int get_xop(u32 inst)
-{
-	return (inst >> 1) & 0x3ff;
-}
-
-static inline unsigned int get_sprn(u32 inst)
-{
-	return ((inst >> 16) & 0x1f) | ((inst >> 6) & 0x3e0);
-}
-
-static inline unsigned int get_dcrn(u32 inst)
-{
-	return ((inst >> 16) & 0x1f) | ((inst >> 6) & 0x3e0);
-}
-
-static inline unsigned int get_rt(u32 inst)
-{
-	return (inst >> 21) & 0x1f;
-}
-
-static inline unsigned int get_rs(u32 inst)
-{
-	return (inst >> 21) & 0x1f;
-}
-
-static inline unsigned int get_ra(u32 inst)
-{
-	return (inst >> 16) & 0x1f;
-}
-
-static inline unsigned int get_rb(u32 inst)
-{
-	return (inst >> 11) & 0x1f;
-}
-
-static inline unsigned int get_rc(u32 inst)
-{
-	return inst & 0x1;
-}
-
-static inline unsigned int get_ws(u32 inst)
-{
-	return (inst >> 11) & 0x1f;
-}
-
-static inline unsigned int get_d(u32 inst)
-{
-	return inst & 0xffff;
-}
+#include <asm/disassemble.h>
 
 static void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 {

--=-HUQCL72pl/I3P8EwwzEZ--
