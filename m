Return-Path: <mgreer@mvista.com>
Date: Mon, 19 Jun 2006 13:08:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] mpic: add support for serial mode interrupts
Message-ID: <20060619200811.GA15524@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC10x-style interrupt controllers have a serial mode that allows
several interrupts to be clocked in through one INT signal.

This patch adds the software support for that mode.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 arch/powerpc/sysdev/mpic.c |    6 ++++++
 include/asm-powerpc/mpic.h |    2 ++
 2 files changed, 8 insertions(+)
--

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7dcdfcb..1829aed 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -629,6 +629,12 @@ #endif /* CONFIG_SMP */
 			mb();
 	}
 
+	/* For serial interrupts & set clock ratio */
+	if (flags & MPIC_SERIAL_MODE)
+		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1,
+			mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1)
+				| (1<<27) | (0x7<<28));
+
 	/* Read feature register, calculate num CPUs and, for non-ISU
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 6b9e781..f35ccdc 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -186,6 +186,8 @@ #define MPIC_BROKEN_U3			0x00000004
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* MPIC serial mode */
+#define MPIC_SERIAL_MODE		0x00000020
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
