Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 548DF2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:16:57 +1000 (EST)
Message-ID: <1372140948.3944.193.camel@pasglop>
Subject: Re: [PATCH 10/10] net/tg3: Avoid delay during MMIO access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 16:15:48 +1000
In-Reply-To: <1372139717-14885-11-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-11-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 13:55 +0800, Gavin Shan wrote:
> When the driver is encountering EEH errors, which might be caused
> by frozen PCI host controller, the driver needn't keep reading on
> MMIO until timeout. For the case, 0xFF's should be returned from
> hardware. Otherwise, it possibly trigger soft-lockup. The patch
> adds more check on that by pci_channel_offline(), thus to avoid
> the possible soft-lockup.

Can you resend this patch "standalone" (not part of a series)
to the maintainer/author of this driver and CC the netdev list on
vger.kernel.org ?

For the CC list, check the author of the original EEH support.

Also maybe improve the explanation above explaining something like:

"When the EEH error is the result of a fenced host bridge, MMIO
accesses can be very slow (milliseconds) to timeout and return all 1's,
thus causing the driver various timeout loops to take way too long and
trigger soft-lockup warnings (in addition to taking minutes to recover).

It might be worthwhile to check if for any of these cases, ffffffff is
a valid possible value, and if not, bail early since that means the HW
is either gone or isolated.

In the meantime, checking that the PCI channel is offline will
workaround the problem".

Or something like that...

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c |   36 +++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index c777b90..a13463e 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -744,6 +744,9 @@ static int tg3_ape_lock(struct tg3 *tp, int locknum)
>  		status = tg3_ape_read32(tp, gnt + off);
>  		if (status == bit)
>  			break;
> +		if (pci_channel_offline(tp->pdev))
> +			break;
> +
>  		udelay(10);
>  	}
>  
> @@ -1635,6 +1638,9 @@ static void tg3_wait_for_event_ack(struct tg3 *tp)
>  	for (i = 0; i < delay_cnt; i++) {
>  		if (!(tr32(GRC_RX_CPU_EVENT) & GRC_RX_CPU_DRIVER_EVENT))
>  			break;
> +		if (pci_channel_offline(tp->pdev))
> +			break;
> +
>  		udelay(8);
>  	}
>  }
> @@ -1813,6 +1819,9 @@ static int tg3_poll_fw(struct tg3 *tp)
>  		for (i = 0; i < 200; i++) {
>  			if (tr32(VCPU_STATUS) & VCPU_STATUS_INIT_DONE)
>  				return 0;
> +			if (pci_channel_offline(tp->pdev))
> +				return -ENODEV;
> +
>  			udelay(100);
>  		}
>  		return -ENODEV;
> @@ -1823,6 +1832,15 @@ static int tg3_poll_fw(struct tg3 *tp)
>  		tg3_read_mem(tp, NIC_SRAM_FIRMWARE_MBOX, &val);
>  		if (val == ~NIC_SRAM_FIRMWARE_MBOX_MAGIC1)
>  			break;
> +		if (pci_channel_offline(tp->pdev)) {
> +			if (!tg3_flag(tp, NO_FWARE_REPORTED)) {
> +				tg3_flag_set(tp, NO_FWARE_REPORTED);
> +				netdev_info(tp->dev, "No firmware running\n");
> +			}
> +
> +			break;
> +		}
> +
>  		udelay(10);
>  	}
>  
> @@ -3520,6 +3538,8 @@ static int tg3_pause_cpu(struct tg3 *tp, u32 cpu_base)
>  		tw32(cpu_base + CPU_MODE,  CPU_MODE_HALT);
>  		if (tr32(cpu_base + CPU_MODE) & CPU_MODE_HALT)
>  			break;
> +		if (pci_channel_offline(tp->pdev))
> +			return -EBUSY;
>  	}
>  
>  	return (i == iters) ? -EBUSY : 0;
> @@ -8589,6 +8609,14 @@ static int tg3_stop_block(struct tg3 *tp, unsigned long ofs, u32 enable_bit, boo
>  	tw32_f(ofs, val);
>  
>  	for (i = 0; i < MAX_WAIT_CNT; i++) {
> +		if (pci_channel_offline(tp->pdev)) {
> +			dev_err(&tp->pdev->dev,
> +				"tg3_stop_block device offline, "
> +				"ofs=%lx enable_bit=%x\n",
> +				ofs, enable_bit);
> +			return -ENODEV;
> +		}
> +
>  		udelay(100);
>  		val = tr32(ofs);
>  		if ((val & enable_bit) == 0)
> @@ -8612,6 +8640,13 @@ static int tg3_abort_hw(struct tg3 *tp, bool silent)
>  
>  	tg3_disable_ints(tp);
>  
> +	if (pci_channel_offline(tp->pdev)) {
> +		tp->rx_mode &= ~(RX_MODE_ENABLE | TX_MODE_ENABLE);
> +		tp->mac_mode &= ~MAC_MODE_TDE_ENABLE;
> +		err = -ENODEV;
> +		goto err_no_dev;
> +	}
> +
>  	tp->rx_mode &= ~RX_MODE_ENABLE;
>  	tw32_f(MAC_RX_MODE, tp->rx_mode);
>  	udelay(10);
> @@ -8660,6 +8695,7 @@ static int tg3_abort_hw(struct tg3 *tp, bool silent)
>  	err |= tg3_stop_block(tp, BUFMGR_MODE, BUFMGR_MODE_ENABLE, silent);
>  	err |= tg3_stop_block(tp, MEMARB_MODE, MEMARB_MODE_ENABLE, silent);
>  
> +err_no_dev:
>  	for (i = 0; i < tp->irq_cnt; i++) {
>  		struct tg3_napi *tnapi = &tp->napi[i];
>  		if (tnapi->hw_status)
