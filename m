Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9810DDDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 16:29:04 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8G6RwWI675246
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 06:27:58 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8G6RwVP1786038
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:27:58 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8G6Rt1a025226
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:27:55 +0200
From: ehrhardt@linux.vnet.ibm.com
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 2/3] kvmppc: add hypercall infrastructure - guest part v3
Date: Tue, 16 Sep 2008 08:27:29 +0200
Message-Id: <1221546450-15761-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This adds the guest portion of the hypercall infrastructure.

Version 3 now follows the beat ABI, but proposes a new implementation style as
static inline asm functions instead of pure assembler code. That should allow
the compiler to be more flexible and therefore a better optimization.

If people agree on that new implementation style we might merge this code.
The current implementation of beat style hypercalls can be found in
arch/powerpc/platforms/cell/beat_hvCall.S

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 epapr_hcalls.h |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

[diff]

diff --git a/include/asm-powerpc/epapr_hcalls.h b/include/asm-powerpc/epapr_hcalls.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/epapr_hcalls.h
@@ -0,0 +1,59 @@
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
+ * Authors:
+ * 	Christian Ehrhardt <ehrhardt@de.ibm.com>
+ */
+
+#ifndef __POWERPC_EPAPR_HCALLS_H__
+#define __POWERPC_EPAPR_HCALLS_H__
+
+#ifdef __KERNEL__
+
+/* Hypercalls use the beat ABI */
+#define KVM_HYPERCALL_BIN 0x44000022
+
+static inline long epapr_hypercall_1in_1out(unsigned int nr, unsigned long p1)
+{
+	register unsigned long hcall asm ("r11") = nr;
+	register unsigned long arg1_ret asm ("r3") = p1;
+
+	asm volatile(".long %1"
+			: "+r"(arg1_ret)
+			: "i"(KVM_HYPERCALL_BIN), "r"(hcall)
+			: "r4", "r5", "r6", "r7", "r8",
+			  "r9", "r10", "r12", "cc");
+	return arg1_ret;
+}
+
+static inline long epapr_hypercall_2in_1out(unsigned int nr,
+					unsigned long p1, unsigned long p2)
+{
+	register unsigned long hcall asm ("r11") = nr;
+	register unsigned long arg1_ret asm ("r3") = p1;
+	register unsigned long arg2 asm ("r4") = p2;
+
+	asm volatile(".long %1"
+			: "+r"(arg1_ret)
+			: "i"(KVM_HYPERCALL_BIN), "r"(hcall), "r"(arg2)
+			: "r5", "r6", "r7", "r8",
+			  "r9", "r10", "r12", "cc");
+	return arg1_ret;
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* __POWERPC_EPAPR_HCALLS_H__ */
