Return-Path: <mgreer@mvista.com>
Date: Mon, 19 Jun 2006 15:03:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
Message-ID: <20060619220348.GA31227@mag.az.mvista.com>
References: <20060619200811.GA15524@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060619200811.GA15524@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[This patch completely replaces the previous patch.]

MPC10x-style interrupt controllers have a serial mode that allows
several interrupts to be clocked in through one INT signal.

This patch adds the software support for that mode.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 arch/powerpc/sysdev/mpic.c |    8 ++++++++
 include/asm-powerpc/mpic.h |    5 +++++
 2 files changed, 13 insertions(+)
--

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7dcdfcb..397b886 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -629,6 +629,14 @@ #endif /* CONFIG_SMP */
 			mb();
 	}
 
+	/* For serial interrupts & set clock ratio */
+	if (flags & MPIC_SERIAL_MODE)
+		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1,
+			(mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1)
+				& ~MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK)
+					| MPIC_GREG_GLOBAL_CONF_1_SIE
+					| MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(7));
+
 	/* Read feature register, calculate num CPUs and, for non-ISU
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 6b9e781..0be8254 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -22,6 +22,9 @@ #define		MPIC_GREG_GCONF_RESET			0x80000
 #define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
 #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
 #define MPIC_GREG_GLOBAL_CONF_1		0x00030
+#define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000/*Serial Int*/
+#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
+#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(r)	(((r) & 0x7) << 28)
 #define MPIC_GREG_VENDOR_0		0x00040
 #define MPIC_GREG_VENDOR_1		0x00050
 #define MPIC_GREG_VENDOR_2		0x00060
@@ -186,6 +189,8 @@ #define MPIC_BROKEN_U3			0x00000004
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* MPIC serial mode */
+#define MPIC_SERIAL_MODE		0x00000020
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
