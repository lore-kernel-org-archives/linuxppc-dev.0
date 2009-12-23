Return-Path: <geert.uytterhoeven@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id B596CB7BF4
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 07:16:40 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 22so474499eye.33
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 12:16:38 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.OSX.2.00.0911171657290.371@silk.local>
References: <alpine.OSX.2.00.0911171657290.371@silk.local>
Date: Wed, 23 Dec 2009 21:16:38 +0100
Message-ID: <10f740e80912231216t3ea2f418pdf0e5ed3f9c0c6c9@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmac-zilog: add platform driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 10:04, Finn Thain <fthain@telegraphics.com.au> wrot=
e:
> Add platform driver to the pmac-zilog driver for mac 68k, putting the
> powermac-specific bits inside #ifdef CONFIG_PPC_PMAC.

Ben, OK for you?

> This patch should be applied after "[PATCH 3/13] pmac-zilog: cleanup". It
> renders obsolete the version in "[PATCH 4/13] pmac-zilog, mac68k: replace
> mac68k SCC code with platform".
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
> =C2=A0arch/m68k/configs/mac_defconfig =C2=A0 | =C2=A0 =C2=A05 +
> =C2=A0arch/m68k/configs/multi_defconfig | =C2=A0 =C2=A05 +
> =C2=A0drivers/serial/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 12 +-
> =C2=A0drivers/serial/pmac_zilog.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0159 ++++++=
+++++++++++++++++++++++++++-----
> =C2=A0drivers/serial/pmac_zilog.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 14 +++
> =C2=A05 files changed, 169 insertions(+), 26 deletions(-)
>
> Index: linux-2.6.31/drivers/serial/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/drivers/serial/Kconfig =C2=A0 =C2=A02009-11-17 17:0=
5:27.000000000 +1100
> +++ linux-2.6.31/drivers/serial/Kconfig 2009-11-17 17:07:38.000000000 +11=
00
> @@ -1079,12 +1079,12 @@ config SERIAL_68360
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default y
>
> =C2=A0config SERIAL_PMACZILOG
> - =C2=A0 =C2=A0 =C2=A0 tristate "PowerMac z85c30 ESCC support"
> - =C2=A0 =C2=A0 =C2=A0 depends on PPC_OF && PPC_PMAC
> + =C2=A0 =C2=A0 =C2=A0 tristate "Mac or PowerMac z85c30 ESCC support"
> + =C2=A0 =C2=A0 =C2=A0 depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select SERIAL_CORE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver supports the Zilog z85C30 s=
erial ports found on
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 PowerMac machines.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Power)Mac machines.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y or M if you want to be able to th=
ese serial ports.
>
> =C2=A0config SERIAL_PMACZILOG_TTYS
> @@ -1109,16 +1109,16 @@ config SERIAL_PMACZILOG_TTYS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unable to use the 8250 module for PCMCI=
A or other 16C550-style
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UARTs.
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say N unless you need the z85c30 ports on y=
our powermac
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say N unless you need the z85c30 ports on y=
our (Power)Mac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to appear as /dev/ttySn.
>
> =C2=A0config SERIAL_PMACZILOG_CONSOLE
> - =C2=A0 =C2=A0 =C2=A0 bool "Console on PowerMac z85c30 serial port"
> + =C2=A0 =C2=A0 =C2=A0 bool "Console on Mac or PowerMac z85c30 serial por=
t"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SERIAL_PMACZILOG=3Dy
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select SERIAL_CORE_CONSOLE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you would like to be able to use the=
 z85c30 serial port
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 on your PowerMac as the console, you can do=
 so by answering
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 on your (Power)Mac as the console, you can =
do so by answering
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Y to this option.
>
> =C2=A0config SERIAL_LH7A40X
> Index: linux-2.6.31/arch/m68k/configs/mac_defconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/arch/m68k/configs/mac_defconfig =C2=A0 2009-11-17 1=
7:07:29.000000000 +1100
> +++ linux-2.6.31/arch/m68k/configs/mac_defconfig =C2=A0 =C2=A0 =C2=A0 =C2=
=A02009-11-17 17:07:38.000000000 +1100
> @@ -701,6 +701,11 @@ CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> =C2=A0#
> =C2=A0# Non-8250 serial port support
> =C2=A0#
> +CONFIG_SERIAL_CORE=3Dy
> +CONFIG_SERIAL_CORE_CONSOLE=3Dy
> +CONFIG_SERIAL_PMACZILOG=3Dy
> +CONFIG_SERIAL_PMACZILOG_TTYS=3Dy
> +CONFIG_SERIAL_PMACZILOG_CONSOLE=3Dy
> =C2=A0CONFIG_UNIX98_PTYS=3Dy
> =C2=A0# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> =C2=A0CONFIG_LEGACY_PTYS=3Dy
> Index: linux-2.6.31/arch/m68k/configs/multi_defconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/arch/m68k/configs/multi_defconfig 2009-11-17 17:07:=
29.000000000 +1100
> +++ linux-2.6.31/arch/m68k/configs/multi_defconfig =C2=A0 =C2=A0 =C2=A020=
09-11-17 17:07:38.000000000 +1100
> @@ -822,6 +822,11 @@ CONFIG_A2232=3Dy
> =C2=A0#
> =C2=A0# Non-8250 serial port support
> =C2=A0#
> +CONFIG_SERIAL_CORE=3Dy
> +CONFIG_SERIAL_CORE_CONSOLE=3Dy
> +CONFIG_SERIAL_PMACZILOG=3Dy
> +CONFIG_SERIAL_PMACZILOG_TTYS=3Dy
> +CONFIG_SERIAL_PMACZILOG_CONSOLE=3Dy
> =C2=A0CONFIG_UNIX98_PTYS=3Dy
> =C2=A0# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> =C2=A0CONFIG_LEGACY_PTYS=3Dy
> Index: linux-2.6.31/drivers/serial/pmac_zilog.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/drivers/serial/pmac_zilog.c =C2=A0 =C2=A0 =C2=A0 20=
09-11-17 17:07:28.000000000 +1100
> +++ linux-2.6.31/drivers/serial/pmac_zilog.c =C2=A0 =C2=A02009-11-17 17:0=
7:38.000000000 +1100
> @@ -63,11 +63,18 @@
> =C2=A0#include <asm/sections.h>
> =C2=A0#include <asm/io.h>
> =C2=A0#include <asm/irq.h>
> +
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0#include <asm/prom.h>
> =C2=A0#include <asm/machdep.h>
> =C2=A0#include <asm/pmac_feature.h>
> =C2=A0#include <asm/dbdma.h>
> =C2=A0#include <asm/macio.h>
> +#else
> +#include <linux/platform_device.h>
> +#include <asm/macints.h>
> +#define machine_is_compatible(x) (0)
> +#endif
>
> =C2=A0#if defined (CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_MAG=
IC_SYSRQ)
> =C2=A0#define SUPPORT_SYSRQ
> @@ -83,11 +90,9 @@
>
> =C2=A0static char version[] __initdata =3D "pmac_zilog: 0.6 (Benjamin Her=
renschmidt <benh@kernel.crashing.org>)";
> =C2=A0MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
> -MODULE_DESCRIPTION("Driver for the PowerMac serial ports.");
> +MODULE_DESCRIPTION("Driver for the Mac and PowerMac serial ports.");
> =C2=A0MODULE_LICENSE("GPL");
>
> -#define PWRDBG(fmt, arg...) =C2=A0 =C2=A0printk(KERN_DEBUG fmt , ## arg)
> -
> =C2=A0#ifdef CONFIG_SERIAL_PMACZILOG_TTYS
> =C2=A0#define PMACZILOG_MAJOR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0TTY_MAJOR
> =C2=A0#define PMACZILOG_MINOR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A064
> @@ -341,7 +346,7 @@ static struct tty_struct *pmz_receive_ch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uap->curregs[R1] &=3D ~(EXT_INT_ENAB | TxINT_E=
NAB | RxINT_MASK);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0write_zsreg(uap, R1, uap->curregs[R1]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0zssync(uap);
> - =C2=A0 =C2=A0 =C2=A0 dev_err(&uap->dev->ofdev.dev, "pmz: rx irq flood !=
\n");
> + =C2=A0 =C2=A0 =C2=A0 pmz_error("pmz: rx irq flood !\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> =C2=A0}
>
> @@ -746,6 +751,8 @@ static void pmz_break_ctl(struct uart_po
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&port->lock, flags);
> =C2=A0}
>
> +#ifdef CONFIG_PPC_PMAC
> +
> =C2=A0/*
> =C2=A0* Turn power on or off to the SCC and associated stuff
> =C2=A0* (port drivers, modem, IR port, etc.)
> @@ -781,6 +788,15 @@ static int pmz_set_scc_power(struct uart
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return delay;
> =C2=A0}
>
> +#else
> +
> +static int pmz_set_scc_power(struct uart_pmac_port *uap, int state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +#endif /* !CONFIG_PPC_PMAC */
> +
> =C2=A0/*
> =C2=A0* FixZeroBug....Works around a bug in the SCC receving channel.
> =C2=A0* Inspired from Darwin code, 15 Sept. 2000 =C2=A0-DanM
> @@ -943,9 +959,9 @@ static int pmz_startup(struct uart_port
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pmz_get_port_A(uap)->flags |=3D PMACZILOG_FLAG=
_IS_IRQ_ON;
> - =C2=A0 =C2=A0 =C2=A0 if (request_irq(uap->port.irq, pmz_interrupt, IRQF=
_SHARED, "PowerMac Zilog", uap)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&uap->dev->ofd=
ev.dev,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "Unable to register zs interrupt handler.\n");
> + =C2=A0 =C2=A0 =C2=A0 if (request_irq(uap->port.irq, pmz_interrupt, IRQF=
_SHARED,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "SCC", uap)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmz_error("Unable to r=
egister zs interrupt handler.\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmz_set_scc_power(=
uap, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&pmz_=
irq_mutex);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;
> @@ -1185,7 +1201,7 @@ static void pmz_irda_setup(struct uart_p
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((read_zsreg(uap, R0) & Tx_BUF_EMP) =3D=
=3D 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || (read_zsreg(uap, R1) =
& ALL_SNT) =3D=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (--t <=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(&uap->dev->ofdev.dev, "transmitter didn't drain\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pmz_error("transmitter didn't drain\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);
> @@ -1201,7 +1217,7 @@ static void pmz_irda_setup(struct uart_p
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_zsdata(uap);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (--t <=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(&uap->dev->ofdev.dev, "receiver didn't drain\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pmz_error("receiver didn't drain\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -1222,8 +1238,7 @@ static void pmz_irda_setup(struct uart_p
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t =3D 5000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((read_zsreg(uap, R0) & Rx_CH_AV) =3D=3D=
 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (--t <=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(&uap->dev->ofdev.dev,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "irda_setup timed out on get_version byt=
e\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pmz_error("irda_setup timed out on get_version byte\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);
> @@ -1231,8 +1246,7 @@ static void pmz_irda_setup(struct uart_p
> =C2=A0 =C2=A0 =C2=A0 =C2=A0version =3D read_zsdata(uap);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (version < 4) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&uap->dev->of=
dev.dev, "IrDA: dongle version %d not supported\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0version);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmz_info("IrDA: dongle=
 version %d not supported\n", version);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -1241,19 +1255,17 @@ static void pmz_irda_setup(struct uart_p
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t =3D 5000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((read_zsreg(uap, R0) & Rx_CH_AV) =3D=3D=
 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (--t <=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(&uap->dev->ofdev.dev,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "irda_setup timed out on speed mode byte=
\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pmz_error("irda_setup timed out on speed mode byte\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t =3D read_zsdata(uap);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (t !=3D cmdbyte)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&uap->dev->ofd=
ev.dev,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "irda_setup speed mode byte =3D %x (%x)\n", t, cmdbyte);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmz_error("irda_setup =
speed mode byte =3D %x (%x)\n", t, cmdbyte);
>
> - =C2=A0 =C2=A0 =C2=A0 dev_info(&uap->dev->ofdev.dev, "IrDA setup for %ld=
 bps, dongle version: %d\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*baud, version);
> + =C2=A0 =C2=A0 =C2=A0 pmz_info("IrDA setup for %ld bps, dongle version: =
%d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*baud, version);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)read_zsdata(uap);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)read_zsdata(uap);
> @@ -1402,7 +1414,7 @@ static void pmz_poll_put_char(struct uar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0write_zsdata(uap, c);
> =C2=A0}
>
> -#endif
> +#endif /* CONFIG_CONSOLE_POLL */
>
> =C2=A0static struct uart_ops pmz_pops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.tx_empty =C2=A0 =C2=A0 =C2=A0 =3D =C2=A0 =C2=
=A0 =C2=A0 pmz_tx_empty,
> @@ -1427,6 +1439,8 @@ static struct uart_ops pmz_pops =3D {
> =C2=A0#endif
> =C2=A0};
>
> +#ifdef CONFIG_PPC_PMAC
> +
> =C2=A0/*
> =C2=A0* Setup one port structure after probing, HW is down at this point,
> =C2=A0* Unlike sunzilog, we don't need to pre-init the spinlock as we don=
't
> @@ -1823,6 +1837,88 @@ next:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +#else
> +
> +extern struct platform_device scc_a_pdev, scc_b_pdev;
> +
> +static int __init pmz_init_port(struct uart_pmac_port *uap)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct resource *r_ports;
> + =C2=A0 =C2=A0 =C2=A0 int irq;
> +
> + =C2=A0 =C2=A0 =C2=A0 r_ports =3D platform_get_resource(uap->node, IORES=
OURCE_MEM, 0);
> + =C2=A0 =C2=A0 =C2=A0 irq =3D platform_get_irq(uap->node, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (!r_ports || !irq)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> +
> + =C2=A0 =C2=A0 =C2=A0 uap->port.mapbase =C2=A0=3D r_ports->start;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.membase =C2=A0=3D (unsigned char __iomem=
 *) r_ports->start;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.iotype =C2=A0 =3D UPIO_MEM;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.irq =C2=A0 =C2=A0 =C2=A0=3D irq;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.uartclk =C2=A0=3D ZS_CLOCK;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.fifosize =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.ops =C2=A0 =C2=A0 =C2=A0=3D &pmz_pops;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.type =C2=A0 =C2=A0 =3D PORT_PMAC_ZILOG;
> + =C2=A0 =C2=A0 =C2=A0 uap->port.flags =C2=A0 =C2=A0=3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 uap->control_reg =C2=A0 =3D uap->port.membase;
> + =C2=A0 =C2=A0 =C2=A0 uap->data_reg =C2=A0 =C2=A0 =C2=A0=3D uap->control=
_reg + 4;
> + =C2=A0 =C2=A0 =C2=A0 uap->port_type =C2=A0 =C2=A0 =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 pmz_convert_to_zs(uap, CS8, 0, 9600);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int __init pmz_probe(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports_count =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[0].mate =C2=A0 =C2=A0 =C2=A0=3D &pmz_por=
ts[1];
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[0].port.line =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[0].flags =C2=A0 =C2=A0 =3D PMACZILOG_FLA=
G_IS_CHANNEL_A;
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[0].node =C2=A0 =C2=A0 =C2=A0=3D &scc_a_p=
dev;
> + =C2=A0 =C2=A0 =C2=A0 err =3D pmz_init_port(&pmz_ports[0]);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports_count++;
> +
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[1].mate =C2=A0 =C2=A0 =C2=A0=3D &pmz_por=
ts[0];
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[1].port.line =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[1].flags =C2=A0 =C2=A0 =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports[1].node =C2=A0 =C2=A0 =C2=A0=3D &scc_b_p=
dev;
> + =C2=A0 =C2=A0 =C2=A0 err =3D pmz_init_port(&pmz_ports[1]);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 pmz_ports_count++;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void pmz_dispose_port(struct uart_pmac_port *uap)
> +{
> + =C2=A0 =C2=A0 =C2=A0 memset(uap, 0, sizeof(struct uart_pmac_port));
> +}
> +
> +static int pmz_attach(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < pmz_ports_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmz_ports[i].node =
=3D=3D pdev)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> +}
> +
> +static int pmz_detach(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +#endif /* !CONFIG_PPC_PMAC */
> +
> =C2=A0#ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
>
> =C2=A0static void pmz_console_write(struct console *con, const char *s, u=
nsigned int count);
> @@ -1883,6 +1979,8 @@ err_out:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;
> =C2=A0}
>
> +#ifdef CONFIG_PPC_PMAC
> +
> =C2=A0static struct of_device_id pmz_match[] =3D
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> @@ -1904,6 +2002,19 @@ static struct macio_driver pmz_driver =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D pmz_re=
sume,
> =C2=A0};
>
> +#else
> +
> +static struct platform_driver pmz_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D pmz_a=
ttach,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __devexit_=
p(pmz_detach),
> + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D "scc",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D THIS_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +#endif /* !CONFIG_PPC_PMAC */
> +
> =C2=A0static int __init init_pmz(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc, i;
> @@ -1942,15 +2053,23 @@ static int __init init_pmz(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Then we register the macio driver itself
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return macio_register_driver(&pmz_driver);
> +#else
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&pmz_driver);
> +#endif
> =C2=A0}
>
> =C2=A0static void __exit exit_pmz(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get rid of macio-driver (detach from macio)=
 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0macio_unregister_driver(&pmz_driver);
> +#else
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&pmz_driver);
> +#endif
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < pmz_ports_count; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_pmac_p=
ort *uport =3D &pmz_ports[i];
> Index: linux-2.6.31/drivers/serial/pmac_zilog.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/drivers/serial/pmac_zilog.h =C2=A0 =C2=A0 =C2=A0 20=
09-11-17 17:07:28.000000000 +1100
> +++ linux-2.6.31/drivers/serial/pmac_zilog.h =C2=A0 =C2=A02009-11-17 17:0=
7:38.000000000 +1100
> @@ -1,7 +1,15 @@
> =C2=A0#ifndef __PMAC_ZILOG_H__
> =C2=A0#define __PMAC_ZILOG_H__
>
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0#define pmz_debug(fmt, arg...) dev_dbg(&uap->dev->ofdev.dev, fmt, #=
# arg)
> +#define pmz_error(fmt, arg...) dev_err(&uap->dev->ofdev.dev, fmt, ## arg=
)
> +#define pmz_info(fmt, arg...) =C2=A0dev_info(&uap->dev->ofdev.dev, fmt, =
## arg)
> +#else
> +#define pmz_debug(fmt, arg...) do { } while (0)
> +#define pmz_error(fmt, arg...) printk(KERN_ERR fmt, ## arg)
> +#define pmz_info(fmt, arg...) =C2=A0printk(KERN_INFO fmt, ## arg)
> +#endif
>
> =C2=A0/*
> =C2=A0* At most 2 ESCCs with 2 ports each
> @@ -17,6 +25,7 @@ struct uart_pmac_port {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_port =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0port;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_pmac_port =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *mate;
>
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* macio_dev for the escc holding this port (m=
aybe be null on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * early inited port)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> @@ -25,6 +34,9 @@ struct uart_pmac_port {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * of "escc" node (ie. ch-a or ch-b)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*node;
> +#else
> + =C2=A0 =C2=A0 =C2=A0 struct platform_device =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*node;
> +#endif
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Port type as obtained from device tree (IRD=
A, modem, ...) */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_type;
> @@ -55,10 +67,12 @@ struct uart_pmac_port {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0volatile u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __iomem *control_reg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0volatile u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __iomem *data_reg;
>
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tx_dma_irq;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_dma_irq;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0volatile struct dbdma_regs =C2=A0 =C2=A0 =C2=
=A0__iomem *tx_dma_regs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0volatile struct dbdma_regs =C2=A0 =C2=A0 =C2=
=A0__iomem *rx_dma_regs;
> +#endif
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ktermios =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 termios_cache;
> =C2=A0};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>



--=20
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
