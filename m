Return-Path: <romieu@fr.zoreil.com>
Received: from fr.zoreil.com (electric-eye.fr.zoreil.com [213.41.134.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5977967B43
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Apr 2006 18:25:01 +1000 (EST)
Date: Sat, 8 Apr 2006 10:12:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
Message-ID: <20060408081231.GA29323@electric-eye.fr.zoreil.com>
References: <20060406222359.GA30037@austin.ibm.com>
	<20060406224643.GA6278@kroah.com>
	<20060407231134.GN25225@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060407231134.GN25225@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	jesse.brandeburg@intel.com, linuxppc-dev@ozlabs.org,
	john.ronciak@intel.com, jeffrey.t.kirsher@intel.com,
	netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas <linas@austin.ibm.com> :
> Index: linux-2.6.17-rc1/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.17-rc1.orig/drivers/net/e100.c	2006-04-07 16:21:46.000000000 -0500
> +++ linux-2.6.17-rc1/drivers/net/e100.c	2006-04-07 18:10:52.411266545 -0500
[...]
> +static pci_ers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)

80 cols limit.

[...]
> +static pci_ers_result_t e100_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct nic *nic = netdev_priv(netdev);
> +
> +	if (pci_enable_device(pdev)) {
> +		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");

- The driver supports {get/set}_msglevel. Please consider using netif_msg_xxx
  (see include/linux/netdevice.h).

- s/e100/DRV_NAME/ (or netdev->name, or pci_name(...) depending on the
  context).

[...]
> +static struct pci_error_handlers e100_err_handler = {
> +	.error_detected = e100_io_error_detected,
> +	.slot_reset = e100_io_slot_reset,
> +	.resume = e100_io_resume,
> +};

Nit: I'd rather follow the style in the declaration of e100_driver.

-- 
Ueimor
