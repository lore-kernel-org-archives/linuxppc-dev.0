From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sat, 19 Jun 2004 15:07:52 -0700
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC52xx lite5200 support for booting from dBUG
Message-ID: <20040619220752.GA31654@zenos.farnsworth.org>
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com> <20040603134804.B24468@home.com> <40C8BB6C.4040709@246tNt.com> <20040618192046.GA22607@zenos.farnsworth.org> <20040618200414.GA25461@zenos.farnsworth.org> <40D4187D.6090804@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40D4187D.6090804@246tNt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 19, 2004 at 10:42:05AM +0000, Sylvain Munaut wrote:
> I think a file ( arch/ppc/boot/simple/mpc52xx_tty.c ) is missing from
> the patch.

Your right.  Here it is.
-Dale

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/17 16:35:56-07:00 dfarnsworth@mvista.com
#   Oops, need arch/ppc/boot/simple/mpc52xx_tty.c too.
#
# arch/ppc/boot/simple/mpc52xx_tty.c
#   2004/06/17 16:35:49-07:00 dfarnsworth@mvista.com +141 -0
#
# arch/ppc/boot/simple/mpc52xx_tty.c
#   2004/06/17 16:35:49-07:00 dfarnsworth@mvista.com +0 -0
#   BitKeeper file /x/bk/linux-2.5-lite5200/arch/ppc/boot/simple/mpc52xx_tty.c
#
diff -Nru a/arch/ppc/boot/simple/mpc52xx_tty.c b/arch/ppc/boot/simple/mpc52xx_tty.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/simple/mpc52xx_tty.c	2004-06-19 15:06:17 -07:00
@@ -0,0 +1,141 @@
+/*
+ * arch/ppc/boot/simple/mpc52xx_tty.c
+ *
+ * Minimal serial functions needed to send messages out a MPC52xx
+ * Programmable Serial Controller (PSC).
+ *
+ * Author: Dale Farnsworth <dfarnsworth@mvista.com>
+ *
+ * 2003-2004 (c) MontaVista, Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/uaccess.h>
+#include <asm/mpc52xx.h>
+#include <asm/mpc52xx_psc.h>
+#include <asm/serial.h>
+#include <asm/time.h>
+
+#if MPC52xx_PF_CONSOLE_PORT == 0
+#define MPC52xx_CONSOLE		MPC52xx_PSC1
+#define MPC52xx_PSC_CONFIG_SHIFT	0
+#elif MPC52xx_PF_CONSOLE_PORT == 1
+#define MPC52xx_CONSOLE		MPC52xx_PSC2
+#define MPC52xx_PSC_CONFIG_SHIFT	4
+#elif MPC52xx_PF_CONSOLE_PORT == 2
+#define MPC52xx_CONSOLE		MPC52xx_PSC3
+#define MPC52xx_PSC_CONFIG_SHIFT	8
+#else
+#error "MPC52xx_PF_CONSOLE_PORT not defined"
+#endif
+
+static struct mpc52xx_psc *psc = (struct mpc52xx_psc *)MPC52xx_CONSOLE;
+
+/* The decrementer counts at the system bus clock frequency
+ * divided by four.  The most accurate time base is connected to the
+ * rtc.  We read the decrementer change during one rtc tick (one second)
+ * and multiply by 4 to get the system bus clock frequency.
+ */
+int
+mpc52xx_ipbfreq(void)
+{
+	int busfreq, ipbfreq;
+	struct mpc52xx_rtc *rtc = (struct mpc52xx_rtc*)MPC52xx_RTC;
+	struct mpc52xx_cdm *cdm = (struct mpc52xx_cdm*)MPC52xx_CDM;
+	int current_time, previous_time;
+	int tbl_start, tbl_end;
+
+	/* force ipb to 66MHz and PCI to 33MHz */
+	out_8(&cdm->ipb_clk_sel, 1);
+	out_8(&cdm->pci_clk_sel, 1);
+
+	previous_time = in_be32(&rtc->time);
+	while ((current_time = in_be32(&rtc->time)) == previous_time) ;
+	tbl_start = get_tbl();
+	previous_time = current_time;
+	while ((current_time = in_be32(&rtc->time)) == previous_time) ;
+	tbl_end = get_tbl();
+
+	busfreq = (tbl_end - tbl_start) * 4;
+
+	ipbfreq = (in_8(&cdm->ipb_clk_sel) & 1) ? busfreq / 2 : busfreq;
+
+	return ipbfreq;
+}
+
+unsigned long
+serial_init(int ignored, void *ignored2)
+{
+	struct mpc52xx_gpio *gpio = (struct mpc52xx_gpio *)MPC52xx_GPIO;
+	int divisor;
+	int mode1;
+	int mode2;
+	u32 val32;
+
+	static int been_here = 0;
+
+	if (been_here)
+		return 0;
+
+	been_here = 1;
+
+	val32 = in_be32(&gpio->port_config);
+	val32 &= ~(0x7 << MPC52xx_PSC_CONFIG_SHIFT);
+	val32 |= MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD
+				<< MPC52xx_PSC_CONFIG_SHIFT;
+	out_be32(&gpio->port_config, val32);
+
+	out_8(&psc->command, MPC52xx_PSC_RST_TX
+			| MPC52xx_PSC_RX_DISABLE | MPC52xx_PSC_TX_ENABLE);
+	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+
+	out_be32(&psc->sicr, 0x0);
+	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
+	out_be16(&psc->tfalarm, 0xf8);
+
+	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1
+			| MPC52xx_PSC_RX_ENABLE
+			| MPC52xx_PSC_TX_ENABLE);
+
+	divisor = ((mpc52xx_ipbfreq()
+			/ (CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD * 16)) + 1) >> 1;
+
+	mode1 = MPC52xx_PSC_MODE_8_BITS | MPC52xx_PSC_MODE_PARNONE
+			| MPC52xx_PSC_MODE_ERR;
+	mode2 = MPC52xx_PSC_MODE_ONE_STOP;
+
+	out_8(&psc->ctur, divisor>>8);
+	out_8(&psc->ctlr, divisor);
+	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
+	out_8(&psc->mode, mode1);
+	out_8(&psc->mode, mode2);
+
+	return 0;	/* ignored */
+}
+
+void
+serial_putc(void *ignored, const char c)
+{
+	serial_init(0, 0);
+
+	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP)) ;
+	out_8(&psc->mpc52xx_psc_buffer_8, c);
+	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP)) ;
+}
+
+char
+serial_getc(void *ignored)
+{
+	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY)) ;
+
+	return in_8(&psc->mpc52xx_psc_buffer_8);
+}
+
+int
+serial_tstc(void *ignored)
+{
+	return (in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY) != 0;
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
