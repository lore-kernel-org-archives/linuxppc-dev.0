Return-Path: <michal.simek@xilinx.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0080.outbound.protection.outlook.com [104.47.38.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ63y3rtTzDvg2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 23:23:10 +1100 (AEDT)
Subject: Re: [Patch v7 1/7] microblaze: irqchip: Move intc driver to irqchip
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-2-Zubair.Kakakhel@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <4f055736-5977-4d0f-ddf2-113c787e383a@xilinx.com>
Date: Tue, 15 Nov 2016 13:22:46 +0100
MIME-Version: 1.0
In-Reply-To: <20161114121351.10924-2-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.11.2016 13:13, Zubair Lutfullah Kakakhel wrote:
> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
> based xilfpga platform and a few PowerPC based platforms.
> 
> Move the interrupt controller code out of arch/microblaze so that
> it can be used by everyone
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V6 -> V7
> Rebase to v4.9-rc5
> 
> V5 -> V6
> Rebase to v4.9-rc3
> 
> V4 -> V5
> Rebase to v4.9-rc1
> Renamed back to irq-xilinx-intc.c
> 
> V3 -> V4
> No change
> 
> V2 -> V3
> No change here. Cleanup patches follow after this patch.
> Its debatable to cleanup before/after move. Decided to place cleanup
> after move to put history in new place.
> 
> V1 -> V2
> 
> Renamed irq-xilinx to irq-axi-intc
> Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC
> Patch is now without rename flag so as to facilitate review
> ---
>  arch/microblaze/Kconfig                                            | 1 +
>  arch/microblaze/kernel/Makefile                                    | 2 +-
>  drivers/irqchip/Kconfig                                            | 4 ++++
>  drivers/irqchip/Makefile                                           | 1 +
>  arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx-intc.c | 0
>  5 files changed, 7 insertions(+), 1 deletion(-)
>  rename arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx-intc.c (100%)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 86f6572..85885a5 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -27,6 +27,7 @@ config MICROBLAZE
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_OPROFILE
>  	select IRQ_DOMAIN
> +	select XILINX_INTC
>  	select MODULES_USE_ELF_RELA
>  	select OF
>  	select OF_EARLY_FLATTREE
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
> index f08baca..e098381 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -15,7 +15,7 @@ endif
>  extra-y := head.o vmlinux.lds
>  
>  obj-y += dma.o exceptions.o \
> -	hw_exception_handler.o intc.o irq.o \
> +	hw_exception_handler.o irq.o \
>  	platform.o process.o prom.o ptrace.o \
>  	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
>  
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bc0af33..ae96731 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -211,6 +211,10 @@ config XTENSA_MX
>  	bool
>  	select IRQ_DOMAIN
>  
> +config XILINX_INTC
> +	bool
> +	select IRQ_DOMAIN
> +
>  config IRQ_CROSSBAR
>  	bool
>  	help
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e4dbfc8..0e55d94 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
>  obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
>  obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
>  obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
> +obj-$(CONFIG_XILINX_INTC)		+= irq-xilinx-intc.o
>  obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
>  obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
>  obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
> diff --git a/arch/microblaze/kernel/intc.c b/drivers/irqchip/irq-xilinx-intc.c
> similarity index 100%
> rename from arch/microblaze/kernel/intc.c
> rename to drivers/irqchip/irq-xilinx-intc.c
> 

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
