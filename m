Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBE01DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:12:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA3KBtv5006465
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 13:11:55 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA3KC5Eh115614
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 13:12:06 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA3KC4uB000926
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 13:12:04 -0700
Subject: Re: [RFC] a little disassembly infrastructure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1225473656.14521.10.camel@localhost.localdomain>
References: <1224867546.9634.42.camel@localhost.localdomain>
	<18690.35483.845880.696901@cargo.ozlabs.ibm.com>
	<1225473656.14521.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 14:12:02 -0600
Message-Id: <1225743122.24019.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-31 at 12:21 -0500, Hollis Blanchard wrote:
> On Sat, 2008-10-25 at 13:55 +1100, Paul Mackerras wrote:
> > Hollis Blanchard writes:
> > 
> > > I've also found xmon's ppc-opc.c. That parses the opcode and operands,
> > > so could use some shared macros.
> > 
> > That's a direct copy from GNU binutils.  I'm reluctant to modify it
> > because then maintenance becomes more than just copying in the latest
> > version.
> 
> OK, makes sense.
> 
> Can I get an Acked-by on this patch, or should I move the code to a
> KVM-specific header? Either way I'll submit it via the KVM tree as
> usual.

Paul, is this OK? I'm  waiting for your ack before sending a number of
dependent KVM patches to Avi.



ppc: Create disassemble.h to extract instruction fields

This is used in a couple places in KVM, but isn't KVM-specific.

However, xmon uses a direct copy of ppc_opc.c from binutils, so xmon won't use
this. emulate_instruction() doesn't need it either, because it can use a series
of mask tests.

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


-- 
Hollis Blanchard
IBM Linux Technology Center
