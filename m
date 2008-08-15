Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 99435DE3A7
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 00:16:12 +1000 (EST)
Date: Fri, 15 Aug 2008 18:16:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Message-ID: <20080815141610.GA15495@oksana.dev.rtsoft.ru>
References: <1218007000-27320-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1218007000-27320-1-git-send-email-leoli@freescale.com>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb@vger.kernel.org, Xie Xiaobo <X.Xie@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 03:16:40PM +0800, Li Yang wrote:
> Some of Freescale SoC chips have a QE or CPM co-processor which
> supports full speed USB.  The driver adds device mode support
> of both QE and CPM USB controller to Linux USB gadget.  The
> driver is tested with MPC8360 and MPC8272, and should work with
> other models having QE/CPM given minor tweaks.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Hi,

Just want to report that the driver works here on MPC8360E-MDS,
with few issues though.

> +/*-------------------------------------------------------------------------
> +	Gadget driver register and unregister.
> + --------------------------------------------------------------------------*/
> +int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +{
> +	int retval;
> +	unsigned long flags = 0;
> +
> +	/* standard operations */
> +	if (!udc_controller)
> +		return -ENODEV;
> +
> +	if (!driver || (driver->speed != USB_SPEED_FULL
> +			&& driver->speed != USB_SPEED_HIGH)
> +			|| !driver->bind || !driver->unbind ||
> +			!driver->disconnect || !driver->setup)

Usually unbind is assigned via __exit_p() macro, thus the driver
will not able to work with g_ether when it is built in.


Plus I got this with various debugging enabled:

g_ether gadget: high speed config #1: CDC Ethernet (ECM)
BUG: spinlock recursion on CPU#0, swapper/0
 lock: cf846c50, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
Call Trace:
[c0361cb0] [c0008a90] show_stack+0x4c/0x16c (unreliable)
[c0361cf0] [c0175b84] spin_bug+0x7c/0xc4
[c0361d10] [c0175ea8] _raw_spin_lock+0xb4/0xb8
[c0361d20] [c027e5dc] _spin_lock_irqsave+0x30/0x48
[c0361d40] [c01c8450] qe_ep_init+0x80/0x3a4
[c0361d60] [c01c8828] qe_ep_enable+0xb4/0xe4
[c0361d80] [c01cb210] ecm_set_alt+0x88/0x12c
[c0361d90] [c01cbb10] set_config+0xc8/0x1bc
[c0361db0] [c01cbf90] composite_setup+0x20c/0x3a8
[c0361de0] [c01c7f88] setup_received_handle+0x1e4/0x26c
[c0361e00] [c01c807c] ep0_setup_handle+0x6c/0x74
[c0361e10] [c01c81f0] qe_ep0_rx+0x16c/0x17c
[c0361e30] [c01c9140] rx_irq+0x88/0xc0
[c0361e40] [c01c98c8] qe_udc_irq+0x10c/0x134
[c0361e60] [c006083c] handle_IRQ_event+0x5c/0xb0
[c0361e80] [c0062964] handle_level_irq+0xa8/0x144
[c0361ea0] [c0029a9c] qe_ic_cascade_low_ipic+0x58/0x90
[c0361eb0] [c0006820] do_IRQ+0xa4/0xc8
[c0361ec0] [c0013e88] ret_from_except+0x0/0x14
--- Exception: 501 at cpu_idle+0xa0/0x104
    LR = cpu_idle+0xa0/0x104
[c0361f80] [c0009d88] cpu_idle+0x50/0x104 (unreliable)
[c0361fa0] [c027f07c] 0xc027f07c
[c0361fc0] [c030d91c] start_kernel+0x1ac/0x230
[c0361ff0] [00003438] 0x3438
BUG: spinlock lockup on CPU#0, swapper/0, cf846c50
Call Trace:
[c0361ca0] [c0008a90] show_stack+0x4c/0x16c (unreliable)
[c0361ce0] [c0175df0] __spin_lock_debug+0xf4/0xf8
[c0361d10] [c0175e80] _raw_spin_lock+0x8c/0xb8
[c0361d20] [c027e5dc] _spin_lock_irqsave+0x30/0x48
[c0361d40] [c01c8450] qe_ep_init+0x80/0x3a4
[c0361d60] [c01c8828] qe_ep_enable+0xb4/0xe4
[c0361d80] [c01cb210] ecm_set_alt+0x88/0x12c
[c0361d90] [c01cbb10] set_config+0xc8/0x1bc
[c0361db0] [c01cbf90] composite_setup+0x20c/0x3a8
[c0361de0] [c01c7f88] setup_received_handle+0x1e4/0x26c
[c0361e00] [c01c807c] ep0_setup_handle+0x6c/0x74
[c0361e10] [c01c81f0] qe_ep0_rx+0x16c/0x17c
[c0361e30] [c01c9140] rx_irq+0x88/0xc0
[c0361e40] [c01c98c8] qe_udc_irq+0x10c/0x134
[c0361e60] [c006083c] handle_IRQ_event+0x5c/0xb0
[c0361e80] [c0062964] handle_level_irq+0xa8/0x144
[c0361ea0] [c0029a9c] qe_ic_cascade_low_ipic+0x58/0x90
[c0361eb0] [c0006820] do_IRQ+0xa4/0xc8
[c0361ec0] [c0013e88] ret_from_except+0x0/0x14
--- Exception: 501 at cpu_idle+0xa0/0x104
    LR = cpu_idle+0xa0/0x104
[c0361f80] [c0009d88] cpu_idle+0x50/0x104 (unreliable)
[c0361fa0] [c027f07c] 0xc027f07c
[c0361fc0] [c030d91c] start_kernel+0x1ac/0x230
[c0361ff0] [00003438] 0x3438


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
