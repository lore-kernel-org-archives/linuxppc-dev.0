Message-ID: <3E445BFC.8010500@mvista.com>
Date: Fri, 07 Feb 2003 18:23:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel Spruce KGDB patch
Content-Type: multipart/mixed;
 boundary="------------000307090405060605040209"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000307090405060605040209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If no one objects to this patch, would a power that be please push it.

Mark
--

--------------000307090405060605040209
Content-Type: text/plain;
 name="spruce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spruce.patch"

===== arch/ppc/config.in 1.165 vs edited =====
--- 1.165/arch/ppc/config.in	Sat Feb  1 13:04:41 2003
+++ edited/arch/ppc/config.in	Fri Feb  7 15:25:27 2003
@@ -225,6 +225,11 @@
   define_bool CONFIG_EPIC_SERIAL_MODE y
 fi

+if [ "$CONFIG_SPRUCE" = "y" ]; then
+  define_bool CONFIG_GEN550_KGDB y
+  define_bool CONFIG_GEN550_PROGRESS y
+fi
+
 if [ "$CONFIG_LOPEC" = "y" ]; then
   define_bool CONFIG_EPIC_SERIAL_MODE y
   define_bool CONFIG_GEN550_KGDB y
@@ -756,7 +761,8 @@
 if [ "$CONFIG_MCPN765" = "y" -o "$CONFIG_SANDPOINT" = "y" \
 	-o "$CONFIG_ZX4500" = "y" -o "$CONFIG_PRPMC800" = "y" \
 	-o "$CONFIG_4xx" = "y" -o "$CONFIG_GT64260" = "y" \
-	-o "$CONFIG_LOPEC" = "y" -o "$CONFIG_PPLUS" = "y" ]; then
+	-o "$CONFIG_LOPEC" = "y" -o "$CONFIG_PPLUS" = "y" \
+	-o "$CONFIG_SPRUCE" = "y" ]; then
   bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
 endmenu
===== arch/ppc/configs/spruce_defconfig 1.6 vs edited =====
--- 1.6/arch/ppc/configs/spruce_defconfig	Tue Jan  7 03:52:51 2003
+++ edited/arch/ppc/configs/spruce_defconfig	Fri Feb  7 16:29:57 2003
@@ -10,6 +10,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+# CONFIG_ADVANCED_OPTIONS is not set

 #
 # Loadable module support
@@ -24,17 +25,35 @@
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_6xx=y
-# CONFIG_4xx is not set
+# CONFIG_40x is not set
+# CONFIG_440 is not set
 # CONFIG_POWER3 is not set
-# CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_PPC_ISERIES is not set
 # CONFIG_8260 is not set
 CONFIG_PPC_STD_MMU=y
 # CONFIG_ALL_PPC is not set
 # CONFIG_APUS is not set
+# CONFIG_WILLOW is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_EV64260 is not set
 CONFIG_SPRUCE=y
+# CONFIG_MENF1 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
+# CONFIG_ZX4500 is not set
+CONFIG_GEN550_KGDB=y
+CONFIG_GEN550_PROGRESS=y
 # CONFIG_SMP is not set
 # CONFIG_ALTIVEC is not set
 # CONFIG_TAU is not set
@@ -179,11 +198,30 @@
 # CONFIG_SCSI is not set

 #
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_BOOT is not set
+# CONFIG_FUSION_ISENSE is not set
+# CONFIG_FUSION_CTL is not set
+# CONFIG_FUSION_LAN is not set
+
+#
 # IEEE 1394 (FireWire) support (EXPERIMENTAL)
 #
 # CONFIG_IEEE1394 is not set

 #
+# I2O device support
+#
+# CONFIG_I2O is not set
+# CONFIG_I2O_PCI is not set
+# CONFIG_I2O_BLOCK is not set
+# CONFIG_I2O_LAN is not set
+# CONFIG_I2O_SCSI is not set
+# CONFIG_I2O_PROC is not set
+
+#
 # Network device support
 #
 CONFIG_NETDEVICES=y
@@ -218,6 +256,7 @@
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+# CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
@@ -369,6 +408,11 @@
 # Input core support is needed for joysticks
 #
 # CONFIG_QIC02_TAPE is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_IPMI_PANIC_EVENT is not set
+# CONFIG_IPMI_DEVICE_INTERFACE is not set
+# CONFIG_IPMI_KCS is not set
+# CONFIG_IPMI_WATCHDOG is not set

 #
 # Watchdog Cards
@@ -507,3 +551,4 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
===== arch/ppc/kernel/gen550_dbg.c 1.3 vs edited =====
--- 1.3/arch/ppc/kernel/gen550_dbg.c	Tue Jan 28 09:18:20 2003
+++ edited/arch/ppc/kernel/gen550_dbg.c	Thu Feb  6 16:21:08 2003
@@ -56,7 +56,6 @@
 unsigned long serial_init(int chan, void *ignored)
 {
 	unsigned long com_port;
-	unsigned char lcr, dlm;

 	/* We need to find out which type io we're expecting.  If it's
 	 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
@@ -80,23 +79,14 @@
 	/* How far apart the registers are. */
 	shift = rs_table[chan].iomem_reg_shift;

-	/* save the LCR */
-	lcr = serial_inb(com_port + (UART_LCR << shift));
 	/* Access baud rate */
 	serial_outb(com_port + (UART_LCR << shift), 0x80);
-	dlm = serial_inb(com_port + (UART_DLM << shift));
-	/*
-	 * Test if serial port is unconfigured.
-	 * We assume that no-one uses less than 110 baud or
-	 * less than 7 bits per character these days.
-	 *  -- paulus.
-	 */

 	/* Input clock. */
 	serial_outb(com_port + (UART_DLL << shift),
-			(BASE_BAUD / SERIAL_BAUD) & 0xFF);
+			(rs_table[chan].baud_base / SERIAL_BAUD) & 0xFF);
 	serial_outb(com_port + (UART_DLM << shift),
-			(BASE_BAUD / SERIAL_BAUD) >> 8);
+			(rs_table[chan].baud_base / SERIAL_BAUD) >> 8);
 	/* 8 data, 1 stop, no parity */
 	serial_outb(com_port + (UART_LCR << shift), 0x03);
 	/* RTS/DTR */
===== arch/ppc/platforms/spruce_setup.c 1.2 vs edited =====
--- 1.2/arch/ppc/platforms/spruce_setup.c	Sat Feb  1 12:15:00 2003
+++ edited/arch/ppc/platforms/spruce_setup.c	Fri Feb  7 16:30:55 2003
@@ -12,21 +12,6 @@
  * under  the terms of  the GNU General Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
- *
- * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
- * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
  */

 #include <linux/config.h>
@@ -73,6 +58,9 @@
 extern unsigned char pckbd_sysrq_xlate[128];
 extern char cmd_line[];

+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct serial_struct *);
+
 /*
  * CPC700 PIC interrupt programming table
  *
@@ -128,6 +116,51 @@
 	return 0;
 }

+#ifdef CONFIG_SERIAL
+static void __init
+spruce_early_serial_map(void)
+{
+	u32 baud_base;
+	struct serial_struct serial_req;
+
+	if (SPRUCE_UARTCLK_IS_33M(readb(SPRUCE_FPGA_REG_A)))
+		baud_base = SPRUCE_BAUD_33M;
+	else
+		baud_base = SPRUCE_BAUD_30M;
+
+	/* Setup serial port access */
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.baud_base = baud_base;
+	serial_req.line = 0;
+	serial_req.port = 0;
+	serial_req.irq = 3;
+	serial_req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	serial_req.io_type = SERIAL_IO_MEM;
+	serial_req.iomem_base = (u_char *)UART0_IO_BASE;
+	serial_req.iomem_reg_shift = 0;
+
+#if	defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	gen550_init(0, &serial_req);
+#endif
+
+	if (early_serial_setup(&serial_req) != 0)
+		printk("Early serial init of port 0 failed\n");
+
+	/* Assume early_serial_setup() doesn't modify serial_req */
+	serial_req.line = 1;
+	serial_req.port = 1;
+	serial_req.irq = 4;
+	serial_req.iomem_base = (u_char *)UART1_IO_BASE;
+
+#if	defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	gen550_init(1, &serial_req);
+#endif
+
+	if (early_serial_setup(&serial_req) != 0)
+		printk("Early serial init of port 1 failed\n");
+}
+#endif
+
 TODC_ALLOC();

 static void __init
@@ -157,40 +190,7 @@
 	conswitchp = &dummy_con;
 #endif

-#ifdef CONFIG_SERIAL
-	{
-		u32 baud_base;
-		struct serial_struct serial_req;
-
-		if (SPRUCE_UARTCLK_IS_33M(readb(SPRUCE_FPGA_REG_A)))
-			baud_base = SPRUCE_BAUD_33M;
-		else
-			baud_base = SPRUCE_BAUD_30M;
-
-		/* Setup serial port access */
-		memset(&serial_req, 0, sizeof(serial_req));
-		serial_req.baud_base = baud_base;
-		serial_req.line = 0;
-		serial_req.port = 0;
-		serial_req.irq = 3;
-		serial_req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-		serial_req.io_type = SERIAL_IO_MEM;
-		serial_req.iomem_base = UART0_IO_BASE;
-		serial_req.iomem_reg_shift = 0;
-
-		if (early_serial_setup(&serial_req) != 0)
-			printk("Early serial init of port 0 failed\n");
-
-		/* Assume early_serial_setup() doesn't modify serial_req */
-		serial_req.line = 1;
-		serial_req.port = 1;
-		serial_req.irq = 4;
-		serial_req.iomem_base = UART1_IO_BASE;
-
-		if (early_serial_setup(&serial_req) != 0)
-			printk("Early serial init of port 1 failed\n");
-	}
-#endif
+	spruce_early_serial_map();

 	/* Identify the system */
 	printk("System Identification: IBM Spruce\n");
@@ -281,6 +281,31 @@
 	return (unsigned char)(kbd_data >> 24);
 }

+#if	defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+/*
+ * Set BAT 3 to map 0xf8000000 to end of physical memory space 1-to-1.
+ */
+static __inline__ void
+spruce_set_bat(void)
+{
+	unsigned long	bat3u, bat3l;
+	static u_char	first_time = 1;
+
+	if (first_time) {
+		__asm__ __volatile__(
+			" lis %0,0xf800\n	\
+			ori %1,%0,0x002a\n	\
+			ori %0,%0,0x0ffe\n	\
+			mtspr 0x21e,%0\n	\
+			mtspr 0x21f,%1\n	\
+			isync\n			\
+			sync "
+			: "=r" (bat3u), "=r" (bat3l));
+		first_time = 0;
+	}
+}
+#endif
+
 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
@@ -309,6 +334,16 @@

 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
+
+#if	defined(CONFIG_SERIAL) && (defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB))
+	spruce_set_bat();
+	spruce_early_serial_map();
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.progress = gen550_progress;
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+	ppc_md.early_serial_map = spruce_early_serial_map;
+#endif

 #ifdef CONFIG_VT
 	/* Spruce has a PS2 style keyboard */

--------------000307090405060605040209--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
