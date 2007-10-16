Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A233FDDE98
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 00:11:11 +1000 (EST)
Date: Tue, 16 Oct 2007 09:10:28 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'fixes-2.6.24'
Message-ID: <Pine.LNX.4.64.0710160909340.9339@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Note, this tree is based on a recent linus tree)

Please pull from 'fixes-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git fixes-2.6.24

to receive the following updates:

 arch/powerpc/math-emu/math.c  |   13 +++++++++----
 arch/powerpc/sysdev/fsl_pci.c |    2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

Kumar Gala (1):
      [POWERPC] Fix handling of stfiwx math emulation

Tony Li (1):
      [POWERPC] Add missing semicolon for fsl_pci.c

commit 01db9953a70e8ad33fbcf91d629f8a8ee59b3484
Author: Tony Li <tony.li@freescale.com>
Date:   Tue Oct 16 15:15:23 2007 +0800

    [POWERPC] Add missing semicolon for fsl_pci.c

    Signed-off-by: Tony Li <tony.li@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit ba02946a903015840ef672ccc9dc8620a7e83de6
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Oct 11 17:07:34 2007 -0500

    [POWERPC] Fix handling of stfiwx math emulation

    Its legal for the stfiwx instruction to have RA = 0 as part of its
    effective address calculation.  This is illegal for all other XE
    form instructions.

    Add code to compute the proper effective address for stfiwx if
    RA = 0 rather than treating it as illegal.

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 69058b2..381306b 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -407,11 +407,16 @@ do_mathemu(struct pt_regs *regs)

 	case XE:
 		idx = (insn >> 16) & 0x1f;
-		if (!idx)
-			goto illegal;
-
 		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
+		if (!idx) {
+			if (((insn >> 1) & 0x3ff) == STFIWX)
+				op1 = (void *)(regs->gpr[(insn >> 11) & 0x1f]);
+			else
+				goto illegal;
+		} else {
+			op1 = (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
+		}
+
 		break;

 	case XEU:
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index af090c9..33df4c3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -255,7 +255,7 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533E, quirk_fsl_pcie_transpare
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_transparent)
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_transparent);
