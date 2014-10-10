Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 089871A097B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Oct 2014 05:05:24 +1100 (EST)
Message-ID: <1412964307.13320.603.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3] qe-uart: modify qe-uart to adapt both powerpc and arm
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Fri, 10 Oct 2014 13:05:07 -0500
In-Reply-To: <1412923663-4374-1-git-send-email-B45475@freescale.com>
References: <1412923663-4374-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, timur@tabi.org, linux-serial@vger.kernel.org,
 R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-10 at 14:47 +0800, Zhao Qiang wrote:
> qe has been supported by arm board ls1021, qe-uart need
> to be supported by ls1021.
> modify the code to make qe-uart can work on both powerpc
> and ls1021.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/arm/include/asm/delay.h  |  16 ++++
>  arch/arm/include/asm/io.h     |  28 +++++++
>  arch/arm/include/asm/irq.h    |   2 +
>  arch/arm/kernel/irq.c         |   7 ++
>  drivers/soc/qe/Kconfig        |   1 -
>  drivers/soc/qe/qe.c           |  63 ++++++++-------
>  drivers/soc/qe/qe_common.c    |   2 +-
>  drivers/soc/qe/qe_ic.c        |   7 +-
>  drivers/soc/qe/qe_io.c        |  53 ++++++-------
>  drivers/soc/qe/ucc_slow.c     |  40 +++++-----
>  drivers/tty/serial/ucc_uart.c | 176 +++++++++++++++++++++---------------------
>  include/linux/fsl/qe.h        |  21 +++++
>  12 files changed, 245 insertions(+), 171 deletions(-)

This patch obviously depends on the patches to relocate QE support, but
there's no mention of that dependency above.

There are many changes in here that ought to be separate patches with
separate justification.

Also, some of the QE changes seem to be reasonable cleanup, but not
related to making the code work on ARM.

> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index dff714d..a932f99 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -57,6 +57,22 @@ extern void __bad_udelay(void);
>  			__const_udelay((n) * UDELAY_MULT)) :		\
>  	  __udelay(n))
>  
> +#define spin_event_timeout(condition, timeout, delay)                          \
> +({                                                                             \
> +	typeof(condition) __ret;                                               \
> +	int i = 0;							       \
> +	while (!(__ret = (condition)) && (i++ < timeout)) {		       \
> +		if (delay)                                                     \
> +			udelay(delay);                                         \
> +		else                                                           \
> +			cpu_relax();					       \
> +		udelay(1);						       \
> +	}								       \

This will delay too long if "delay" is used.

How about:

	delay = delay ? delay : 1;			\
	while (!(__ret = (condition))) {		\
		if (i < timeout)			\
			break;				\
		i += delay;				\
		udelay(delay);				\
	}						\

Also, once the dependency on timebase is removed, how about making this
generic rather than just PPC+ARM?

> +	if (!__ret)                                                            \
> +		__ret = (condition);                                           \
> +	__ret;		                                                       \

Timur, do you remember why that final "if (!__ret) __ret = (condition);"
is needed?

> +})
> +
>  /* Loop-based definitions for assembly code. */
>  extern void __loop_delay(unsigned long loops);
>  extern void __loop_udelay(unsigned long usecs);
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d070741..4bec694 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -206,6 +206,34 @@ extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
>  #endif
>  #endif
>  
> +/* access ports */
> +#define setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
> +#define clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
> +
> +#define setbits16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
> +#define clrbits16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
> +
> +#define setbits8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
> +#define clrbits8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))

This should also be a separate patch, though I don't think implicit big
endian is going to fly in arch/arm (it was a mistake in arch/powerpc).
Rename to setbits_be32 etc as is used in U-Boot.

> +/* Clear and set bits in one shot.  These macros can be used to clear and
> + * set multiple bits in a register using a single read-modify-write.  These
> + * macros can also be used to set a multiple-bit bit pattern using a mask,
> + * by specifying the mask in the 'clear' parameter and the new bit pattern
> + * in the 'set' parameter.
> + */
> +
> +#define clrsetbits_be32(addr, clear, set) \
> +	iowrite32be((ioread32be(addr) & ~(clear)) | (set), (addr))
> +#define clrsetbits_le32(addr, clear, set) \
> +	iowrite32le((ioread32le(addr) & ~(clear)) | (set), (addr))
> +#define clrsetbits_be16(addr, clear, set) \
> +	iowrite16be((ioread16be(addr) & ~(clear)) | (set), (addr))
> +#define clrsetbits_le16(addr, clear, set) \
> +	iowrite16le((ioread16le(addr) & ~(clear)) | (set), (addr))
> +#define clrsetbits_8(addr, clear, set) \
> +	iowrite8((ioread8(addr) & ~(clear)) | (set), (addr))
> +
>  /*
>   *  IO port access primitives
>   *  -------------------------
> diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
> index 53c15de..4358904 100644
> --- a/arch/arm/include/asm/irq.h
> +++ b/arch/arm/include/asm/irq.h
> @@ -30,6 +30,8 @@ extern void asm_do_IRQ(unsigned int, struct pt_regs *);
>  void handle_IRQ(unsigned int, struct pt_regs *);
>  void init_IRQ(void);
>  
> +extern irq_hw_number_t virq_to_hw(unsigned int virq);
> +
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
>  extern void (*handle_arch_irq)(struct pt_regs *);
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 9723d17..afa204a 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -121,6 +121,13 @@ void __init init_IRQ(void)
>  		machine_desc->init_irq();
>  }
>  
> +irq_hw_number_t virq_to_hw(unsigned int virq)
> +{
> +	struct irq_data *irq_data = irq_get_irq_data(virq);
> +	return WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
> +}
> +EXPORT_SYMBOL_GPL(virq_to_hw);

Can this be moved to generic code?  Or just open-coded in the caller?

>  #ifdef CONFIG_MULTI_IRQ_HANDLER
>  void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
> diff --git a/drivers/soc/qe/Kconfig b/drivers/soc/qe/Kconfig
> index 49118e1..43b984b 100644
> --- a/drivers/soc/qe/Kconfig
> +++ b/drivers/soc/qe/Kconfig
> @@ -4,7 +4,6 @@
>  
>  config QUICC_ENGINE
>  	bool "Freescale QUICC Engine (QE) Support"
> -	depends on FSL_SOC && (PPC32 || PPC64)

Are you sure there are no build dependencies?  What about OF?

> diff --git a/include/linux/fsl/qe.h b/include/linux/fsl/qe.h
> index 5a6a647..ef4422c 100644
> --- a/include/linux/fsl/qe.h
> +++ b/include/linux/fsl/qe.h
> @@ -306,6 +306,27 @@ struct qe_bd {
>  #define BD_STATUS_MASK	0xffff0000
>  #define BD_LENGTH_MASK	0x0000ffff
>  
> +/* Buffer descriptor control/status used by serial
> + */
> +
> +#define BD_SC_EMPTY	(0x8000)	/* Receive is empty */
> +#define BD_SC_READY	(0x8000)	/* Transmit is ready */
> +#define BD_SC_WRAP	(0x2000)	/* Last buffer descriptor */
> +#define BD_SC_INTRPT	(0x1000)	/* Interrupt on change */
> +#define BD_SC_LAST	(0x0800)	/* Last buffer in frame */
> +#define BD_SC_TC	(0x0400)	/* Transmit CRC */
> +#define BD_SC_CM	(0x0200)	/* Continuous mode */
> +#define BD_SC_ID	(0x0100)	/* Rec'd too many idles */
> +#define BD_SC_P		(0x0100)	/* xmt preamble */
> +#define BD_SC_BR	(0x0020)	/* Break received */
> +#define BD_SC_FR	(0x0010)	/* Framing error */
> +#define BD_SC_PR	(0x0008)	/* Parity error */
> +#define BD_SC_NAK	(0x0004)	/* NAK - did not respond */
> +#define BD_SC_OV	(0x0002)	/* Overrun */
> +#define BD_SC_UN	(0x0002)	/* Underrun */
> +#define BD_SC_CD	(0x0001)	/* */
> +#define BD_SC_CL	(0x0001)	/* Collision */

Please move this rather than copying it.

-Scott
