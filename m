Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9794B67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 07:12:07 +1100 (EST)
In-Reply-To: <4231F9F9.5080506@246tNt.com>
References: <4231F9F9.5080506@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <be4da82f8d12e20b54050e15fd27df36@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 11 Mar 2005 14:12:02 -0600
To: "Sylvain Munaut" <tnt@246tNt.com>
Cc: Tom Rini <trini@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] MPC52xx updates : sparse clean-ups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 11, 2005, at 2:05 PM, Sylvain Munaut wrote:

> Hi Tom & all
>
> Here's some updates related to the Freescale MPC52xx. First some
>  clean-ups for sparse warnings and then PCI support. I'd like to get
>  theses approved & merged before I submit conversion to platform bus
>  model.
>
> As usual, the patches can also be pulled of a bk repository :
>  bk://tnt.bkbits.net/linux-2.5-mpc52xx-pending
>
> (note it's _NOT_ the same url as before even if it's close ;)
>
>
>
>
> =A0=A0=A0 Sylvain
>
> ---
>
> diff -Nru a/arch/ppc/syslib/mpc52xx_pic.c=20
> b/arch/ppc/syslib/mpc52xx_pic.c
> --- a/arch/ppc/syslib/mpc52xx_pic.c=A0=A0=A0=A0 2005-03-11 20:41:36 =
+01:00
>  +++ b/arch/ppc/syslib/mpc52xx_pic.c=A0=A0=A0=A0 2005-03-11 20:41:36 =
+01:00
>  @@ -33,8 +33,8 @@
>  =A0#include <asm/mpc52xx.h>
>
>
>
> -static struct mpc52xx_intr *intr;
>  -static struct mpc52xx_sdma *sdma;
>  +static struct mpc52xx_intr __iomem *intr;
>  +static struct mpc52xx_sdma __iomem *sdma;
>
> =A0static void
>  =A0mpc52xx_ic_disable(unsigned int irq)
>  @@ -173,7 +173,7 @@
>  =A0=A0=A0=A0=A0=A0=A0 mpc52xx_ic_disable,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 /* disable(irq) */
> =A0=A0=A0=A0=A0=A0=A0 mpc52xx_ic_disable_and_ack,=A0=A0=A0=A0 /* =
disable_and_ack(irq) */
>  =A0=A0=A0=A0=A0=A0=A0 mpc52xx_ic_end,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 /* end(irq) */
>  -=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* set_affinity(irq, cpumask)
> SMP. */
>  +=A0=A0=A0=A0=A0=A0 NULL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* set_affinity(irq, cpumask)
> SMP. */
>  =A0};

It looks like others have moved to a C99 initialization style for=20
hw_interrupt_type, see syslib/ipic.c for an example.

> =A0void __init
>  @@ -183,10 +183,8 @@
>  =A0=A0=A0=A0=A0=A0=A0 u32 intr_ctrl;
>
> =A0=A0=A0=A0=A0=A0=A0 /* Remap the necessary zones */
>  -=A0=A0=A0=A0=A0=A0 intr =3D (struct mpc52xx_intr *)
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioremap(MPC52xx_INTR, =
sizeof(struct mpc52xx_intr));
> -=A0=A0=A0=A0=A0=A0 sdma =3D (struct mpc52xx_sdma *)
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioremap(MPC52xx_SDMA, =
sizeof(struct mpc52xx_sdma));
> +=A0=A0=A0=A0=A0=A0 intr =3D ioremap(MPC52xx_INTR, sizeof(struct =
mpc52xx_intr));
> +=A0=A0=A0=A0=A0=A0 sdma =3D ioremap(MPC52xx_SDMA, sizeof(struct =
mpc52xx_sdma));
>
> =A0=A0=A0=A0=A0=A0=A0 if ((intr=3D=3DNULL) || (sdma=3D=3DNULL))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 panic("Can't ioremap =
PIC/SDMA register for init_irq=20
> !");
>  diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c
>  b/arch/ppc/syslib/mpc52xx_setup.c
> --- a/arch/ppc/syslib/mpc52xx_setup.c=A0=A0 2005-03-11 20:41:36 +01:00
>  +++ b/arch/ppc/syslib/mpc52xx_setup.c=A0=A0 2005-03-11 20:41:36 =
+01:00
>  @@ -39,7 +39,8 @@
>  =A0void
>  =A0mpc52xx_restart(char *cmd)
>  =A0{
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_gpt* gpt0 =3D (struct =
mpc52xx_gpt*)=20
> MPC52xx_GPTx(0);
> +=A0=A0=A0=A0=A0=A0 struct mpc52xx_gpt __iomem *gpt0 =3D
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (struct mpc52xx_gpt =
__iomem *) MPC52xx_GPTx(0);
>
> =A0=A0=A0=A0=A0=A0=A0 local_irq_disable();
>
> @@ -102,7 +103,7 @@
>  =A0#endif
>
> =A0static void
>  -mpc52xx_psc_putc(struct mpc52xx_psc * psc, unsigned char c)
>  +mpc52xx_psc_putc(struct mpc52xx_psc __iomem *psc, unsigned char c)
>  =A0{
>  =A0=A0=A0=A0=A0=A0=A0 while (!(in_be16(&psc->mpc52xx_psc_status) &
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
MPC52xx_PSC_SR_TXRDY));
> @@ -112,8 +113,9 @@
>  =A0void
>  =A0mpc52xx_progress(char *s, unsigned short hex)
>  =A0{
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc *psc =3D (struct mpc52xx_psc=20=

> *)MPC52xx_CONSOLE;
> =A0=A0=A0=A0=A0=A0=A0 char c;
>  +=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc __iomem *psc =3D
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (struct mpc52xx_psc =
__iomem *)MPC52xx_CONSOLE;
>
> =A0=A0=A0=A0=A0=A0=A0 while ((c =3D *s++) !=3D 0) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (c =3D=3D '\n')
>  @@ -138,11 +140,11 @@
>  =A0=A0=A0=A0=A0=A0=A0=A0 * else get size from sdram config registers
>  =A0=A0=A0=A0=A0=A0=A0=A0 */
>  =A0=A0=A0=A0=A0=A0=A0 if (ramsize =3D=3D 0) {
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mpc52xx_mmap_ctl =
*mmap_ctl;
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mpc52xx_mmap_ctl =
__iomem *mmap_ctl;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 sdram_config_0, =
sdram_config_1;
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Temp BAT2 mapping =
active when this is called ! */
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmap_ctl =3D (struct =
mpc52xx_mmap_ctl*)=20
> MPC52xx_MMAP_CTL;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmap_ctl =3D (struct =
mpc52xx_mmap_ctl __iomem *)
> MPC52xx_MMAP_CTL;
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sdram_config_0 =3D =
in_be32(&mmap_ctl->sdram0);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sdram_config_1 =3D =
in_be32(&mmap_ctl->sdram1);
>  @@ -169,13 +171,11 @@
>  =A0=A0=A0=A0=A0=A0=A0 /* if bootloader didn't pass bus frequencies, =
calculate them=20
> */
>  =A0=A0=A0=A0=A0=A0=A0 if (xlbfreq =3D=3D 0) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Get RTC & Clock =
manager modules */
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mpc52xx_rtc *rtc;
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mpc52xx_cdm *cdm;
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mpc52xx_rtc =
__iomem *rtc;
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mpc52xx_cdm =
__iomem *cdm;
>
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtc =3D (struct =
mpc52xx_rtc*)
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
ioremap(MPC52xx_RTC, sizeof(struct=20
> mpc52xx_rtc));
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cdm =3D (struct =
mpc52xx_cdm*)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
ioremap(MPC52xx_CDM, sizeof(struct=20
> mpc52xx_cdm));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtc =3D =
ioremap(MPC52xx_RTC, sizeof(struct mpc52xx_rtc));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cdm =3D =
ioremap(MPC52xx_CDM, sizeof(struct mpc52xx_cdm));
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((rtc=3D=3DNULL) || =
(cdm=3D=3DNULL))
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
panic("Can't ioremap RTC/CDM while computing=20
> bus
>  freq");
>  @@ -212,8 +212,8 @@
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __res.bi_pcifreq =3D =
pcifreq;
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Release mapping */
>  -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iounmap((void*)rtc);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iounmap((void*)cdm);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iounmap(rtc);
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iounmap(cdm);
> =A0=A0=A0=A0=A0=A0=A0 }
>
> =A0=A0=A0=A0=A0=A0=A0 divisor =3D 4;
>  diff -Nru a/drivers/serial/mpc52xx_uart.c=20
> b/drivers/serial/mpc52xx_uart.c
> --- a/drivers/serial/mpc52xx_uart.c=A0=A0=A0=A0 2005-03-11 20:41:36 =
+01:00
>  +++ b/drivers/serial/mpc52xx_uart.c=A0=A0=A0=A0 2005-03-11 20:41:36 =
+01:00
>  @@ -86,7 +86,7 @@
>  =A0=A0=A0=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0 the console_init
>  =A0=A0=A0=A0=A0=A0=A0=A0 */
>
> -#define PSC(port) ((struct mpc52xx_psc *)((port)->membase))
>  +#define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
>
>
>
> =A0/* Forward declaration of the interruption handling routine */
>  @@ -190,7 +190,7 @@
>  =A0static int
>  =A0mpc52xx_uart_startup(struct uart_port *port)
> =A0{
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc *psc =3D PSC(port);
>  +=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc __iomem *psc =3D PSC(port);
>
> =A0=A0=A0=A0=A0=A0=A0 /* Reset/activate the port, clear and enable =
interrupts */
>  =A0=A0=A0=A0=A0=A0=A0 out_8(&psc->command,MPC52xx_PSC_RST_RX);
> @@ -217,7 +217,7 @@
>  =A0static void
>  =A0mpc52xx_uart_shutdown(struct uart_port *port)
> =A0{
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc *psc =3D PSC(port);
>  +=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc __iomem *psc =3D PSC(port);
>
> =A0=A0=A0=A0=A0=A0=A0 /* Shut down the port, interrupt and all */
>  =A0=A0=A0=A0=A0=A0=A0 out_8(&psc->command,MPC52xx_PSC_RST_RX);
> @@ -231,7 +231,7 @@
>  =A0mpc52xx_uart_set_termios(struct uart_port *port, struct termios =
*new,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 struct termios *old)
>  =A0{
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc *psc =3D PSC(port);
>  +=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc __iomem *psc =3D PSC(port);
>  =A0=A0=A0=A0=A0=A0=A0 unsigned long flags;
>  =A0=A0=A0=A0=A0=A0=A0 unsigned char mr1, mr2;
>  =A0=A0=A0=A0=A0=A0=A0 unsigned short ctr;
>  @@ -562,7 +562,7 @@
>  =A0mpc52xx_console_get_options(struct uart_port *port,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 int *baud, int *parity, int *bits, int=20
> *flow)
>  =A0{
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc *psc =3D PSC(port);
>  +=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc __iomem *psc =3D PSC(port);
>  =A0=A0=A0=A0=A0=A0=A0 unsigned char mr1;
>
> =A0=A0=A0=A0=A0=A0=A0 /* Read the mode registers */
>  @@ -592,7 +592,7 @@
>  =A0mpc52xx_console_write(struct console *co, const char *s, unsigned =
int
> count)
>  =A0{
>  =A0=A0=A0=A0=A0=A0=A0 struct uart_port *port =3D =
&mpc52xx_uart_ports[co->index];
>  -=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc *psc =3D PSC(port);
>  +=A0=A0=A0=A0=A0=A0 struct mpc52xx_psc __iomem *psc =3D PSC(port);
>  =A0=A0=A0=A0=A0=A0=A0 unsigned int i, j;
>
> =A0=A0=A0=A0=A0=A0=A0 /* Disable interrupts */
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
