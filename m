Return-Path: <ananth@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00AAC2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:40:50 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 20 Mar 2013 04:40:47 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 19C231FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 04:35:46 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KAefpA105278
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 04:40:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KAeeEP012675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 04:40:41 -0600
Date: Wed, 20 Mar 2013 16:10:33 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: ppcdev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130320104033.GA19844@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: oleg@redhat.com, stable@vger.kernel.org,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

GDB uses a variant of the trap instruction that is different from the
one used by uprobes. Currently, running gdb on a program being traced
by uprobes causes an endless loop since uprobes doesn't understand
that the trap is inserted by some other entity and hence a SIGTRAP needs
to be delivered.

Teach uprobes to ignore breakpoints that doesn't belong to it.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/uprobes.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
===================================================================
--- linux-3.9-rc3.orig/arch/powerpc/kernel/uprobes.c
+++ linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
@@ -80,6 +80,16 @@ unsigned long uprobe_get_swbp_addr(struc
 	return instruction_pointer(regs);
 }
 
+/**
+ * is_swbp_insn - check if the instruction is a breakpoint instruction.
+ * @insn: instruction to be checked.
+ * Returns true if @insn is a breakpoint instruction.
+ */
+bool is_swbp_insn(uprobe_opcode_t *insn)
+{
+	return (is_trap(*insn));
+}
+
 /*
  * If xol insn itself traps and generates a signal (SIGILL/SIGSEGV/etc),
  * then detect the case where a singlestepped instruction jumps back to its
