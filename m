Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BA175DDFC9
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 02:34:56 +1000 (EST)
Date: Mon, 1 Sep 2008 20:34:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Message-ID: <20080901163453.GA6178@oksana.dev.rtsoft.ru>
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1219916613-28827-1-git-send-email-leoli@freescale.com>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Robert Jarzmik <rjarzmik@free.fr>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 28, 2008 at 05:43:33PM +0800, Li Yang wrote:
> Some of Freescale SoC chips have a QE or CPM co-processor which
> supports full speed USB.  The driver adds device mode support
> of both QE and CPM USB controller to Linux USB gadget.  The
> driver is tested with MPC8360 and MPC8272, and should work with
> other models having QE/CPM given minor tweaks.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---

Just found a recursive locking bug:

[...]
> +static int reset_queues(struct qe_udc *udc)
> +{

Note: this function is called from the IRQ, the IRQ handler
grabs udc->lock spinlock..

> +	u8 pipe;
> +
> +	for (pipe = 0; pipe < USB_MAX_ENDPOINTS; pipe++)
> +		udc_reset_ep_queue(udc, pipe);
> +
> +	/* report disconnect; the driver is already quiesced */
> +	udc->driver->disconnect(&udc->gadget);

In the disconnect(), g_ether driver will immediately call
qe_ep_disable() function which will try to grab &udc->lock
spinlock once again..

Not sure how to fix this properly... :-/

p.s. the same bug exists in omap_udc.c, pxa27x_udc.c and probably
other drivers as well... The only reason why it does not exploit
in most cases is that the spin_lock_irqsave for !SMP case turns
into simple local_irq_save().

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
