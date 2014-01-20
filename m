Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3AAAB2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 20:38:55 +1100 (EST)
Date: Mon, 20 Jan 2014 10:31:19 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH] powerpc: 85xx: EDAC PCI: request irq as IRQF_SHARED
Message-ID: <20140120093119.GA5144@jtlinux>
References: <1390208175-3656-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1390208175-3656-1-git-send-email-tiejun.chen@windriver.com>
Cc: scottwood@freescale.com, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-edac@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 20, 2014 at 04:56:15PM +0800, Tiejun Chen wrote:
> AER driver needs to share this PCI err irq with EDAC, otherwise
> we can't register AER driver successfully as follows:
>
> genirq: Flags mismatch irq 482. 00000080 (aerdrv) vs. 00000020 ([EDAC] PCI err)
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-148346-g2513817 #69
> Call Trace:
> [ee063cb0] [c00070c4] show_stack+0x44/0x160 (unreliable)
> [ee063cf0] [c055fac4] dump_stack+0x78/0xa0
> [ee063d00] [c006e16c] __setup_irq+0x51c/0x540
> [ee063d40] [c006e264] request_threaded_irq+0xd4/0x150
> [ee063d70] [c0280d10] aer_probe+0xe0/0x2a0
> [ee063da0] [c027e590] pcie_port_probe_service+0x40/0x90
> [ee063dc0] [c02c253c] driver_probe_device+0x8c/0x250
> [ee063de0] [c02c27bc] __driver_attach+0xbc/0xc0
> [ee063e00] [c02c0760] bus_for_each_dev+0x70/0xb0
> [ee063e30] [c02c1f94] driver_attach+0x24/0x40
> [ee063e40] [c02c1aec] bus_add_driver+0xfc/0x210
> [ee063e60] [c02c2d98] driver_register+0x88/0x140
> [ee063e70] [c027e4b4] pcie_port_service_register+0x64/0x80
> [ee063e80] [c06fb14c] aer_service_init+0x28/0x38
> [ee063e90] [c0002468] do_one_initcall+0x158/0x1b0
> [ee063f00] [c06e291c] kernel_init_freeable+0x128/0x1d4
> [ee063f30] [c0002ac4] kernel_init+0x14/0x130
> [ee063f40] [c000f84c] ret_from_kernel_thread+0x5c/0x64
> aer: probe of 0000:00:00.0:pcie02 failed with error -16
> genirq: Flags mismatch irq 480. 00000080 (aerdrv) vs. 00000020 ([EDAC] PCI err)
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-148346-g2513817 #69
> Call Trace:
> [ee063cb0] [c00070c4] show_stack+0x44/0x160 (unreliable)
> [ee063cf0] [c055fac4] dump_stack+0x78/0xa0
> [ee063d00] [c006e16c] __setup_irq+0x51c/0x540
> [ee063d40] [c006e264] request_threaded_irq+0xd4/0x150
> [ee063d70] [c0280d10] aer_probe+0xe0/0x2a0
> [ee063da0] [c027e590] pcie_port_probe_service+0x40/0x90
> [ee063dc0] [c02c253c] driver_probe_device+0x8c/0x250
> [ee063de0] [c02c27bc] __driver_attach+0xbc/0xc0
> [ee063e00] [c02c0760] bus_for_each_dev+0x70/0xb0
> [ee063e30] [c02c1f94] driver_attach+0x24/0x40
> [ee063e40] [c02c1aec] bus_add_driver+0xfc/0x210
> [ee063e60] [c02c2d98] driver_register+0x88/0x140
> [ee063e70] [c027e4b4] pcie_port_service_register+0x64/0x80
> [ee063e80] [c06fb14c] aer_service_init+0x28/0x38
> [ee063e90] [c0002468] do_one_initcall+0x158/0x1b0
> [ee063f00] [c06e291c] kernel_init_freeable+0x128/0x1d4
> [ee063f30] [c0002ac4] kernel_init+0x14/0x130
> [ee063f40] [c000f84c] ret_from_kernel_thread+0x5c/0x64
> aer: probe of 0001:02:00.0:pcie02 failed with error -16
>
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  drivers/edac/mpc85xx_edac.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index fd46b0b..0dda7c4 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -297,7 +297,8 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
>  		pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
>  		res = devm_request_irq(&op->dev, pdata->irq,
> -				       mpc85xx_pci_isr, IRQF_DISABLED,
> +				       mpc85xx_pci_isr, IRQF_SHARED |
> +				       IRQF_DISABLED,
>  				       "[EDAC] PCI err", pci);
>  		if (res < 0) {
>  			printk(KERN_ERR
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-edac" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hi Tiejun,

This is already floating around in linux-next and will hopefully be merged in
3.14.

Hope this helps.
