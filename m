Return-Path: <david-b@pacbell.net>
Received: from smtp103.sbc.mail.mud.yahoo.com (smtp103.sbc.mail.mud.yahoo.com
	[68.142.198.202]) by ozlabs.org (Postfix) with SMTP id 026B567C76
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 12:48:01 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 1/2] Fixed compiled issue tu to new
	of_platform.h header
Date: Wed, 6 Dec 2006 17:19:59 -0800
References: <11642982453599-git-send-email-nd@bplan-gmbh.de>
	<11642982461138-git-send-email-nd@bplan-gmbh.de>
In-Reply-To: <11642982461138-git-send-email-nd@bplan-gmbh.de>
MIME-Version: 1.0
Message-Id: <200612061720.01082.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, greg@kroah.com, stern@rowland.harvard.edu,
	sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 November 2006 8:12 am, nd@bplan-gmbh.de wrote:
>  drivers/usb/host/ohci-ppc-of.c |  285 ++++++++++++++++++++++++++++++++++++++++

You've split one "add new bus glue" patch into two ... please
do it the normal way, as one patch!

(Oh, I see you did that the next day.  The next two comments
still apply.)


> + * Store this function in the HCD's struct pci_driver as probe().

You should remove irrelevant/ancient comments like this.  Looks
like you cloned the PCI bus glue and didn't update key parts...


> + */
> +static int usb_hcd_ppc_of_probe(const struct hc_driver *driver,
> +			  struct of_device *dev, int is_bigendian)

I'm not sure why you didn't just have ohci_hcd_ppc_of_drv_probe()
do all this stuff; there's no point in splitting that code into
two chunks.

Likewise, ohci_hcd_ppc_of_drv_remove() shouldn't be split in two.
