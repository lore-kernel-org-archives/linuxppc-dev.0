From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15364.32906.728532.676746@gargle.gargle.HOWL>
Date: Wed, 28 Nov 2001 17:13:30 +1100 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
In-Reply-To: <3C2B376F.9070508@embeddededge.com>
References: <15363.31192.101536.919771@gargle.gargle.HOWL>
	<3C2B376F.9070508@embeddededge.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> That's a pretty good idea, and I have another one.  Name the
> directory include/asm-ppc/ppc-platforms or something, then
> have a symbolic link
> 	include/asm/platform -> include/asm-ppc/ppc-platforms/<board-file>
>
> That way we can just #include <platform.h> instead of having lots
> of ifdefs in upper level files to determine which one is needed.  If
> we are moving files around, let's have some effect on actually making
> it easier to use them, too.

I have figured out a way to do this without too much pain.  The idea
is that we will have platform.h and platform-serial.h be symlinks to
files in include/asm-ppc/platforms/.  The way that I am suggesting
that we do this is to have special comments in those files (the ones
in include/asm-ppc/platforms) that say what should be symlinked, like
this, from include/asm-ppc/platforms/all_ppc_serial.h:

/* Link to platform_serial.h if CONFIG_ALL_PPC=y */

The comment has to be of the form:

/* Link to <filename> if CONFIG_<option>=y */

and filename can't contain slashes.

The patch below does all this.  It does mean that we will need a
platform header for every platform, and a platform_serial header for
every platform where we want to use the standard serial driver.  As an
example, I have made an all_ppc_serial.h that contains most of what
was in serial.h before.  In fact, with a bit of care we could make
serial.h be the symlink.

Note that we can use one header for multiple platforms, just by
putting multiple magic comments in.  We can also potentially use this
mechanism for config options other than the platform selection
options.

Thoughts?

Paul.

diff -urN linuxppc_2_4_devel/arch/ppc/Makefile pmac/arch/ppc/Makefile
--- linuxppc_2_4_devel/arch/ppc/Makefile	Wed Nov 14 02:50:13 2001
+++ pmac/arch/ppc/Makefile	Wed Nov 28 16:22:01 2001
@@ -14,6 +14,8 @@
 # Rewritten by Cort Dougan and Paul Mackerras
 #

+MRPROPER_FILES += include/asm-ppc/platform.h include/asm-ppc/platform-serial.h
+
 # Be sure to change PAGE_OFFSET in include/asm-ppc/page.h to match
 KERNELLOAD	=0xc0000000

@@ -123,5 +125,11 @@

 archmrproper:

-archdep: scripts/mkdep
+archdep: scripts/mkdep platformlinks
 	$(MAKEBOOT) fastdep
+
+platformlinks:
+	rm -f include/asm-ppc/platform.h
+	rm -f include/asm-ppc/platform-serial.h
+	grep '=y$$' .config | grep -f - include/asm-ppc/platforms/*.h | \
+	awk -f arch/ppc/mklinks.awk
diff -urN linuxppc_2_4_devel/arch/ppc/mklinks.awk pmac/arch/ppc/mklinks.awk
--- linuxppc_2_4_devel/arch/ppc/mklinks.awk	Thu Jan 01 10:00:00 1970
+++ pmac/arch/ppc/mklinks.awk	Wed Nov 28 16:33:48 2001
@@ -0,0 +1,8 @@
+/^[-_A-Za-z0-9.\/]+:\/\* Link to [-_A-Za-z0-9.]+ if CONFIG.* \*\/$/ {
+	target=$1;
+	gsub(/:.*$/, "", target);
+	gsub(/^include\/asm-ppc\//, "", target);
+	link="include/asm-ppc/" $4;
+	print link " -> " target;
+	system("ln -sf " target " " link);
+}
diff -urN linuxppc_2_4_devel/include/asm-ppc/platforms/all_ppc_serial.h pmac/include/asm-ppc/platforms/all_ppc_serial.h
--- linuxppc_2_4_devel/include/asm-ppc/platforms/all_ppc_serial.h	Thu Jan 01 10:00:00 1970
+++ pmac/include/asm-ppc/platforms/all_ppc_serial.h	Wed Nov 28 16:42:57 2001
@@ -0,0 +1,128 @@
+/*
+ * Platform-specific header for serial devices on
+ * the (badly-named) ALL_PPC platform.
+ */
+
+/* Link to platform_serial.h if CONFIG_ALL_PPC=y */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+
+/*
+ * This assumes you have a 1.8432 MHz clock for your UART.
+ *
+ * It'd be nice if someone built a serial card with a 24.576 MHz
+ * clock, since the 16550A is capable of handling a top speed of 1.5
+ * megabits/second; but this requires the faster clock.
+ */
+#define BASE_BAUD ( 1843200 / 16 )
+
+#if defined(CONFIG_MAC_SERIAL)
+#define SERIAL_DEV_OFFSET	((_machine == _MACH_prep || _machine == _MACH_chrp) ? 0 : 2)
+#endif
+
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define RS_TABLE_SIZE  64
+#else
+#define RS_TABLE_SIZE  4
+#endif
+
+/* Standard COM flags (except for COM4, because of the 8514 problem) */
+#ifdef CONFIG_SERIAL_DETECT_IRQ
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
+#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
+#else
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
+#endif
+
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define FOURPORT_FLAGS ASYNC_FOURPORT
+#define ACCENT_FLAGS 0
+#define BOCA_FLAGS 0
+#define HUB6_FLAGS 0
+#endif
+
+/*
+ * The following define the access methods for the HUB6 card. All
+ * access is through two ports for all 24 possible chips. The card is
+ * selected through the high 2 bits, the port on that card with the
+ * "middle" 3 bits, and the register on that port with the bottom
+ * 3 bits.
+ *
+ * While the access port and interrupt is configurable, the default
+ * port locations are 0x302 for the port control register, and 0x303
+ * for the data read/write register. Normally, the interrupt is at irq3
+ * but can be anything from 3 to 7 inclusive. Note that using 3 will
+ * require disabling com2.
+ */
+
+#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
+
+#define STD_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
+	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
+	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
+	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
+	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+
+
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define EXTRA_SERIAL_PORT_DEFNS			\
+	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
+	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
+	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
+	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
+	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
+	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
+	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
+	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
+	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
+	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
+	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
+	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
+	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
+	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
+	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
+	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
+	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
+	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
+	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
+	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
+	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
+	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
+	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
+	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
+	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
+	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
+	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
+	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
+#else
+#define EXTRA_SERIAL_PORT_DEFNS
+#endif
+
+/* You can have up to four HUB6's in the system, but I've only
+ * included two cards here for a total of twelve ports.
+ */
+#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
+#define HUB6_SERIAL_PORT_DFNS		\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
+	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
+#else
+#define HUB6_SERIAL_PORT_DFNS
+#endif
+
+#define SERIAL_PORT_DFNS		\
+	STD_SERIAL_PORT_DEFNS		\
+	EXTRA_SERIAL_PORT_DEFNS		\
+	HUB6_SERIAL_PORT_DFNS
diff -urN linuxppc_2_4_devel/include/asm-ppc/serial.h pmac/include/asm-ppc/serial.h
--- linuxppc_2_4_devel/include/asm-ppc/serial.h	Wed Nov 28 10:22:04 2001
+++ pmac/include/asm-ppc/serial.h	Wed Nov 28 16:54:03 2001
@@ -9,149 +9,7 @@
 #ifndef __ASM_SERIAL_H__
 #define __ASM_SERIAL_H__

-#include <linux/config.h>
+#include <asm/platform_serial.h>

-#if defined(CONFIG_EV64260)
-#include <asm/platforms/ev64260_serial.h>
-#elif defined(CONFIG_GEMINI)
-#include <asm/platforms/gemini_serial.h>
-#elif defined(CONFIG_POWERPMC250)
-#include <asm/platforms/powerpmc250_serial.h>
-#elif defined(CONFIG_LOPEC)
-#include <asm/platforms/lopec_serial.h>
-#elif defined(CONFIG_MCPN765)
-#include <asm/platforms/mcpn765_serial.h>
-#elif defined(CONFIG_MVME5100)
-#include <asm/platforms/mvme5100_serial.h>
-#elif defined(CONFIG_PRPMC750)
-#include <asm/platforms/prpmc750_serial.h>
-#elif defined(CONFIG_PRPMC800)
-#include <asm/platforms/prpmc800_serial.h>
-#elif defined(CONFIG_SANDPOINT)
-#include <asm/platforms/sandpoint_serial.h>
-#elif defined(CONFIG_SPRUCE)
-#include <asm/platforms/spruce_serial.h>
-#elif defined(CONFIG_ZX4500)
-#include <asm/platforms/zx4500_serial.h>
-#elif defined(CONFIG_4xx)
-#include <asm/platforms/ppc4xx_serial.h>
-#else
-
-/*
- * This assumes you have a 1.8432 MHz clock for your UART.
- *
- * It'd be nice if someone built a serial card with a 24.576 MHz
- * clock, since the 16550A is capable of handling a top speed of 1.5
- * megabits/second; but this requires the faster clock.
- */
-#define BASE_BAUD ( 1843200 / 16 )
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define RS_TABLE_SIZE  64
-#else
-#define RS_TABLE_SIZE  4
-#endif
-
-/* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
-#else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
-#endif
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
-	/* UART CLK   PORT IRQ     FLAGS        */			\
-	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
-	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
-	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
-	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS
-
-#endif /* !CONFIG_GEMINI and others */
 #endif /* __ASM_SERIAL_H__ */
 #endif /* __KERNEL__ */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
