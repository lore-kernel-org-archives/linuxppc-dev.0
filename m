Return-Path: <david-b@pacbell.net>
Received: from ylpvm29.prodigy.net (ylpvm29-ext.prodigy.net [207.115.57.60])
	by ozlabs.org (Postfix) with ESMTP id D409467A65
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 06:05:37 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Date: Thu, 17 Mar 2005 10:58:54 -0800
References: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
In-Reply-To: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200503171058.54285.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [linux-usb-devel] [PATCH] Make sleep/wakeup work with USB on
	powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 March 2005 9:36 pm, Paul Mackerras wrote:
> I am currently using this patch on my powerbook to fix the problems
> that USB was causing with sleep and wakeup.  Basically one of the USB
> controllers was getting a spurious wakeup immediately when put it
> into the suspend state.  This would cause the resume routine to be run
> after we had turned off the device, causing a machine check.

Do you know yet why the spurious wakeup happened?  As I recall from
earlier discussions, that was indeed the root cause of the problem,
although there were a few other oddnesses that needed handling too.
But without the spurious wakeup, they'd have been quite rare.


> Also we had some races where we would turn off the clock to the apple
> OHCI cell(s) and then try to access them.  With this patch, sleep and
> wakeup are quite reliable.  The patch is against 2.6.11.

Thanks, I'll have a more detailed look soon.  Most of it looks fine,
except for the stuff related to this:

> +#ifdef CONFIG_USB_SUSPEND
>  	/* wake on ConnectStatusChange, matching external hubs */
>  	ohci_writel (ohci, RH_HS_DRWE, &ohci->regs->roothub.status);
> +#endif

Thing is, that change would also prevent us from getting rid of
the root hub timer for OHCI.   IRQ on connect status change is
not specific to USB_SUSPEND.

- Dave
