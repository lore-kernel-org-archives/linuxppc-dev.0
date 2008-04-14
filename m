Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B38FFDE276
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 06:29:53 +1000 (EST)
Message-Id: <260ED418-9335-47E3-B003-EB966881DBA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311172441.GG7727@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 7/8] [POWERPC] qe_lib: add support for QE USB
Date: Mon, 14 Apr 2008 15:29:47 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172441.GG7727@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
> I believe QE USB clocks routing is qe_lib authority, so usb.c
> created. Also, now cmxgcr needs its own lock.

why? (I'm asking to be more descriptive in the commit message)

> This patch also fixes QE_USB_RESTART_TX command definition.

Patch look ok, but can you be a bit more descriptive about why we are  
adding this.

- k

>
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/qe_lib/Kconfig  |    6 ++++
> arch/powerpc/sysdev/qe_lib/Makefile |    1 +
> arch/powerpc/sysdev/qe_lib/ucc.c    |    7 ++--
> arch/powerpc/sysdev/qe_lib/usb.c    |   57 ++++++++++++++++++++++++++ 
> +++++++++
> include/asm-powerpc/qe.h            |   18 ++++++++++-
> 5 files changed, 85 insertions(+), 4 deletions(-)
> create mode 100644 arch/powerpc/sysdev/qe_lib/usb.c
>
> diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/ 
> sysdev/qe_lib/Kconfig
> index c1f2849..f09dae4 100644
> --- a/arch/powerpc/sysdev/qe_lib/Kconfig
> +++ b/arch/powerpc/sysdev/qe_lib/Kconfig
> @@ -25,3 +25,9 @@ config QE_GTM
> 	default y if FSL_GTM
> 	help
> 	  QE General-purpose Timers Module support
> +
> +config QE_USB
> +	bool
> +	default y if USB_FHCI_HCD
> +	help
> +	  QE USB Host Controller support
> diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/ 
> sysdev/qe_lib/Makefile
> index 3297a52..c666a59 100644
> --- a/arch/powerpc/sysdev/qe_lib/Makefile
> +++ b/arch/powerpc/sysdev/qe_lib/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_UCC)	+= ucc.o
> obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
> obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
> obj-$(CONFIG_QE_GTM)	+= gtm.o
> +obj-$(CONFIG_QE_USB)	+= usb.o
> diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/ 
> qe_lib/ucc.c
> index 0e348d9..d3c7f5a 100644
> --- a/arch/powerpc/sysdev/qe_lib/ucc.c
> +++ b/arch/powerpc/sysdev/qe_lib/ucc.c
> @@ -26,7 +26,8 @@
> #include <asm/qe.h>
> #include <asm/ucc.h>
>
> -static DEFINE_SPINLOCK(ucc_lock);
> +DEFINE_SPINLOCK(cmxgcr_lock);
> +EXPORT_SYMBOL(cmxgcr_lock);
>
> int ucc_set_qe_mux_mii_mng(unsigned int ucc_num)
> {
> @@ -35,10 +36,10 @@ int ucc_set_qe_mux_mii_mng(unsigned int ucc_num)
> 	if (ucc_num > UCC_MAX_NUM - 1)
> 		return -EINVAL;
>
> -	spin_lock_irqsave(&ucc_lock, flags);
> +	spin_lock_irqsave(&cmxgcr_lock, flags);
> 	clrsetbits_be32(&qe_immr->qmx.cmxgcr, QE_CMXGCR_MII_ENET_MNG,
> 		ucc_num << QE_CMXGCR_MII_ENET_MNG_SHIFT);
> -	spin_unlock_irqrestore(&ucc_lock, flags);
> +	spin_unlock_irqrestore(&cmxgcr_lock, flags);
>
> 	return 0;
> }
> diff --git a/arch/powerpc/sysdev/qe_lib/usb.c b/arch/powerpc/sysdev/ 
> qe_lib/usb.c
> new file mode 100644
> index 0000000..60ce676
> --- /dev/null
> +++ b/arch/powerpc/sysdev/qe_lib/usb.c
> @@ -0,0 +1,57 @@
> +/*
> + * QE USB routines
> + *
> + * Copyright (c) Freescale Semicondutor, Inc. 2006.
> + *               Shlomi Gridish <gridish@freescale.com>
> + *               Jerry Huang <Chang-Ming.Huang@freescale.com>
> + * Copyright (c) MontaVista Software, Inc. 2008.
> + *               Anton Vorontsov <avorontsov@ru.mvista.com>
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <asm/immap_qe.h>
> +#include <asm/qe.h>
> +
> +int qe_usb_clock_set(enum qe_clock clk, int rate)
> +{
> +	struct qe_mux __iomem *mux = &qe_immr->qmx;
> +	unsigned long flags;
> +	const bool is_brg = clk < QE_CLK1;
> +	u32 val;
> +
> +	switch (clk) {
> +	case QE_CLK3:  val = QE_CMXGCR_USBCS_CLK3;  break;
> +	case QE_CLK5:  val = QE_CMXGCR_USBCS_CLK5;  break;
> +	case QE_CLK7:  val = QE_CMXGCR_USBCS_CLK7;  break;
> +	case QE_CLK9:  val = QE_CMXGCR_USBCS_CLK9;  break;
> +	case QE_CLK13: val = QE_CMXGCR_USBCS_CLK13; break;
> +	case QE_CLK17: val = QE_CMXGCR_USBCS_CLK17; break;
> +	case QE_CLK19: val = QE_CMXGCR_USBCS_CLK19; break;
> +	case QE_CLK21: val = QE_CMXGCR_USBCS_CLK21; break;
> +	case QE_BRG9:  val = QE_CMXGCR_USBCS_BRG9;  break;
> +	case QE_BRG10: val = QE_CMXGCR_USBCS_BRG10; break;
> +	default:
> +		pr_err("%s: requested unknown clock %d\n", __func__, clk);
> +		return -EINVAL;
> +	}
> +
> +	if (is_brg)
> +		qe_setbrg(clk, rate, 1);
> +
> +	spin_lock_irqsave(&cmxgcr_lock, flags);
> +
> +	clrsetbits_be32(&mux->cmxgcr, QE_CMXGCR_USBCS, val);
> +
> +	spin_unlock_irqrestore(&cmxgcr_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qe_usb_clock_set);
> diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
> index c3be6e2..3276b06 100644
> --- a/include/asm-powerpc/qe.h
> +++ b/include/asm-powerpc/qe.h
> @@ -16,6 +16,7 @@
> #define _ASM_POWERPC_QE_H
> #ifdef __KERNEL__
>
> +#include <linux/spinlock.h>
> #include <asm/immap_qe.h>
>
> #define QE_NUM_OF_SNUM	28
> @@ -74,6 +75,8 @@ enum qe_clock {
> 	QE_CLK_DUMMY
> };
>
> +extern spinlock_t cmxgcr_lock;
> +
> /* Export QE common operations */
> extern void qe_reset(void);
> extern int par_io_init(struct device_node *np);
> @@ -156,6 +159,9 @@ int qe_upload_firmware(const struct qe_firmware  
> *firmware);
> /* Obtain information on the uploaded firmware */
> struct qe_firmware_info *qe_get_firmware_info(void);
>
> +/* QE USB */
> +int qe_usb_clock_set(enum qe_clock clk, int rate);
> +
> /* Buffer descriptors */
> struct qe_bd {
> 	__be16 status;
> @@ -254,6 +260,16 @@ enum comm_dir {
> #define QE_CMXGCR_MII_ENET_MNG		0x00007000
> #define QE_CMXGCR_MII_ENET_MNG_SHIFT	12
> #define QE_CMXGCR_USBCS			0x0000000f
> +#define QE_CMXGCR_USBCS_CLK3		0x1
> +#define QE_CMXGCR_USBCS_CLK5		0x2
> +#define QE_CMXGCR_USBCS_CLK7		0x3
> +#define QE_CMXGCR_USBCS_CLK9		0x4
> +#define QE_CMXGCR_USBCS_CLK13		0x5
> +#define QE_CMXGCR_USBCS_CLK17		0x6
> +#define QE_CMXGCR_USBCS_CLK19		0x7
> +#define QE_CMXGCR_USBCS_CLK21		0x8
> +#define QE_CMXGCR_USBCS_BRG9		0x9
> +#define QE_CMXGCR_USBCS_BRG10		0xa
>
> /* QE CECR Commands.
> */
> @@ -283,7 +299,7 @@ enum comm_dir {
> #define QE_HPAC_START_TX		0x0000060b
> #define QE_HPAC_START_RX		0x0000070b
> #define QE_USB_STOP_TX			0x0000000a
> -#define QE_USB_RESTART_TX		0x0000000b
> +#define QE_USB_RESTART_TX		0x0000000c
> #define QE_QMC_STOP_TX			0x0000000c
> #define QE_QMC_STOP_RX			0x0000000d
> #define QE_SS7_SU_FIL_RESET		0x0000000e
> -- 
> 1.5.2.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
