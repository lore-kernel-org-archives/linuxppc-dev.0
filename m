From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <akpm@osdl.org>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] MachineCheck exception broken for MPC 8xx CPU's
Date: Tue, 25 May 2004 11:26:58 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEMEMICIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Andrew

The Machine Check exception handler is broken on MPC 8xx CPU's
This patch should fix it.
Tom Rini asked me to send it to you.

Regards
  Joakim Tjernlund

Signed-off-by: Joakim Tjernlund

===== arch/ppc/kernel/head_8xx.S 1.20 vs edited =====
--- 1.20/arch/ppc/kernel/head_8xx.S	Tue Apr 20 22:39:28 2004
+++ edited/arch/ppc/kernel/head_8xx.S	Tue May 25 11:01:24 2004
@@ -207,6 +207,14 @@
 	EXCEPTION(0x100, Reset, UnknownException, EXC_XFER_STD)

 /* Machine check */
+	. = 0x200
+MachineCheck:
+	EXCEPTION_PROLOG
+	mfspr r4,DAR
+	stw r4,_DAR(r11)
+	mfspr r5,DSISR
+	stw r5,_DSISR(r11)
+	addi r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x200, MachineCheckException)

 /* Data access exception.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
