Return-Path: <anton@samba.org>
Date: Wed, 31 Jul 2013 15:05:21 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org
Subject: [PATCH] powerpc: handle unaligned ldbrx/stdbrx
Message-ID: <20130731150521.74eb6639@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Normally when we haven't implemented an alignment handler for
a load or store instruction the process will be terminated.

The alignment handler uses the DSISR (or a pseudo one) to locate
the right handler. Unfortunately ldbrx and stdbrx overlap lfs and
stfs so we incorrectly think ldbrx is an lfs and stdbrx is an
stfs.

This bug is particularly nasty - instead of terminating the
process we apply an incorrect fixup and continue on.

With more and more overlapping instructions we should stop
creating a pseudo DSISR and index using the instruction directly,
but for now add a special case to catch ldbrx/stdbrx.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: b/arch/powerpc/kernel/align.c
===================================================================
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -764,6 +764,16 @@ int fix_alignment(struct pt_regs *regs)
 	nb = aligninfo[instr].len;
 	flags = aligninfo[instr].flags;
 
+	/* ldbrx/stdbrx overlap lfs/stfs in the DSISR unfortunately */
+	if (IS_XFORM(instruction) && ((instruction >> 1) & 0x3ff) == 532) {
+		nb = 8;
+		flags = LD+SW;
+	} else if (IS_XFORM(instruction) &&
+		   ((instruction >> 1) & 0x3ff) == 660) {
+		nb = 8;
+		flags = ST+SW;
+	}
+
 	/* Byteswap little endian loads and stores */
 	swiz = 0;
 	if (regs->msr & MSR_LE) {
