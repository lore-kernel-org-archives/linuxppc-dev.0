Date: Thu, 13 Nov 2003 10:47:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031113174745.GA11560@ip68-0-152-218.tc.ph.cox.net>
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de> <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net> <3FB2D757.1010304@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB2D757.1010304@g-house.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 13, 2003 at 01:59:03AM +0100, Christian Kujau wrote:
> Tom Rini wrote:
> >>
> >>CONFIG_DEBUG_KERNEL=y
> >>CONFIG_DEBUG_SLAB=y
> >>CONFIG_MAGIC_SYSRQ=y
> >>CONFIG_KGDB=y
> >>CONFIG_KGDB_TTYS1=y
> >>CONFIG_XMON=y
> >>CONFIG_DEBUG_INFO=y
> >>CONFIG_BOOTX_TEXT=y
> >
> >Note that with XMON and KGDB both enabled, you'll get xmon instead,
> >which again I _think_ works on PReP (but it was long ago when I tested)
> >and here I think you'll be better off with KGDB.
>
> so little time, so much to compile, so slow processors :-)
> and my compile fails with CONFIG_KGDB=y. i have unpacked a fresh
> 2.6.0-test9, did "make oldconfig", then only enabled KGDB, but compile
> bails out with:
>
> evil@sheep:/usr/src/linux-2.6$ make bzImage
> make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-ppc/offsets.h
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/ppc/kernel/built-in.o(.init.text+0x81c): In function `setup_arch':
> arch/ppc/kernel/setup.c:635: undefined reference to `kgdb_map_scc'
> make: *** [.tmp_vmlinux1] Error 1
> evil@sheep:/usr/src/linux-2.6$
>
>
> so, it seems to depend on "SCC_CONSOLE", but this is only available when
>  "MPC8260 CPM Options" is set. but this "MPC8260" is a different
> platform. ok, when i choose a different platform, say PRPMC800, i still
> can select 6xx/7xx/74xx/8260 as cpu-type (i have 604). no, i don't seem
> to understand this, and in-kernel documentation of the different
> platforms is not so clear :-(
>
> the .config is on http://www.nerdbynature.de/bits/sheep/network/config_new

Ok, it's been a while since anyone tried KGDB it seems.  The following
is an untested (yet) patch that makes it compile and maybe work:

===== arch/ppc/Kconfig 1.46 vs edited =====
--- 1.46/arch/ppc/Kconfig	Mon Oct  6 03:07:31 2003
+++ edited/arch/ppc/Kconfig	Thu Nov 13 10:23:41 2003
@@ -585,7 +585,7 @@

 config PPC_GEN550
 	bool
-	depends on SANDPOINT
+	depends on SANDPOINT || PPC_PREP
 	default y

 config PPC_PMAC
===== arch/ppc/platforms/pmac_setup.c 1.34 vs edited =====
--- 1.34/arch/ppc/platforms/pmac_setup.c	Fri Sep 26 16:31:59 2003
+++ edited/arch/ppc/platforms/pmac_setup.c	Thu Nov 13 10:41:44 2003
@@ -297,8 +297,10 @@
 			ppc_override_l2cr_value, (ppc_override_l2cr_value & 0x80000000)
 				? "enabled" : "disabled");

+#if 0
 #ifdef CONFIG_KGDB
 	zs_kgdb_hook(0);
+#endif
 #endif

 #ifdef CONFIG_ADB_CUDA
===== arch/ppc/platforms/prep_setup.c 1.41 vs edited =====
--- 1.41/arch/ppc/platforms/prep_setup.c	Fri Sep 12 09:26:54 2003
+++ edited/arch/ppc/platforms/prep_setup.c	Thu Nov 13 10:36:38 2003
@@ -39,6 +39,8 @@
 #include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>

 #include <asm/sections.h>
 #include <asm/mmu.h>
@@ -58,6 +60,7 @@
 #include <asm/i8259.h>
 #include <asm/open_pic.h>
 #include <asm/pci-bridge.h>
+#include <asm/serial.h>

 unsigned char ucSystemType;
 unsigned char ucBoardRev;
@@ -78,6 +81,7 @@

 extern void prep_find_bridges(void);
 extern char saved_command_line[];
+extern void gen550_init(int i, struct uart_port *serial_req);

 int _prep_type;

@@ -684,6 +688,40 @@
 #endif /* CONFIG_PREP_RESIDUAL */
 }

+#if defined(CONFIG_SERIAL_8250) && \
+	(defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG))
+static void __init
+prep_early_serial_map(void)
+{
+	struct uart_port serial_req;
+
+	/* Setup serial port access */
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.uartclk = UART_CLK;
+	serial_req.irq = 4;
+	serial_req.flags = STD_COM_FLAGS;
+	serial_req.iotype = SERIAL_IO_PORT;
+	serial_req.iobase = 0x3F8;
+
+	gen550_init(0, &serial_req);
+
+	if (early_serial_setup(&serial_req) != 0)
+		printk(KERN_ERR "Early serial init of port 0 failed\n");
+
+	/* Assume early_serial_setup() doesn't modify serial_req */
+	serial_req.line = 1;
+	serial_req.irq = 3; /* XXXX */
+	serial_req.iobase = 0x2F8;
+
+	gen550_init(1, &serial_req);
+
+	if (early_serial_setup(&serial_req) != 0)
+		printk(KERN_ERR "Early serial init of port 1 failed\n");
+}
+#endif
+
+
+
 static void __init
 prep_setup_arch(void)
 {
@@ -1176,6 +1214,14 @@
 	}

 	ppc_md.setup_io_mappings = prep_map_io;
+
+#if defined(CONFIG_SERIAL_8250) && \
+	(defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG))
+	prep_early_serial_map();
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.progress = gen550_progress;
+#endif
+#endif

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 	ppc_ide_md.default_irq = prep_ide_default_irq;
===== arch/ppc/syslib/gen550_dbg.c 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/gen550_dbg.c	Tue Jul  1 08:34:08 2003
+++ edited/arch/ppc/syslib/gen550_dbg.c	Thu Nov 13 10:38:48 2003
@@ -17,6 +17,8 @@
  */

 #include <linux/config.h>
+#include <linux/types.h>
+#include <linux/serial.h>
 #include <linux/tty.h>		/* For linux/serial_core.h */
 #include <linux/serial_core.h>
 #include <linux/serialP.h>
===== include/asm-ppc/pc_serial.h 1.2 vs edited =====
--- 1.2/include/asm-ppc/pc_serial.h	Sun Sep 15 21:52:05 2002
+++ edited/include/asm-ppc/pc_serial.h	Thu Nov 13 10:32:27 2003
@@ -19,6 +19,7 @@
  * megabits/second; but this requires the faster clock.
  */
 #define BASE_BAUD ( 1843200 / 16 )
+#define UART_CLK	1843200

 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define RS_TABLE_SIZE  64


> anyway, i'm about to setup a cross-compile environment on my AMD-K7
> (i386), will see what it gives. oh, i noticed, that on i386 we don't
> have CONFIG_KGDB at all, right?

Correct.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
