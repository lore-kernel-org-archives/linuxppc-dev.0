Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 11:16:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: crash caused by null eeh_dev
Message-ID: <20120418111600.1b0a38c6@kryten>
In-Reply-To: <1334642139-25447-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1334642139-25447-1-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gavin,

> The problem was reported by Anton Blanchard. While EEH error
> happened to the PCI device without the corresponding device
> driver, kernel crash was seen. Eventually, I successfully
> reproduced the problem on Firebird-L machine with utility
> "errinjct". Initially, the device driver for Emulex ethernet
> MAC has been disabled from .config and force data parity on
> the Emulex ethernet MAC with help of "errinjct". Eventually,
> I saw the kernel crash after issueing couple of "lspci -v"
> command.
> 
> The root cause behind is that the PCI device, including the
> reference to the corresponding eeh device, will be removed
> from the system while EEH does recovery. Afterwards, the
> PCI device will be probed again and added into the system
> accordingly. So it's not safe to retrieve the eeh device from
> the corresponding PCI device after the PCI device has been removed
> and not added again.
> 
> The patch fixes the issue and retrieve the eeh device from OF node
> instead of PCI device after the PCI device has been removed.

Thanks, this does fix the oops I see.

Tested-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh.c
> b/arch/powerpc/platforms/pseries/eeh.c index 309d38e..a75e37d 100644
> --- a/arch/powerpc/platforms/pseries/eeh.c
> +++ b/arch/powerpc/platforms/pseries/eeh.c
> @@ -1076,7 +1076,7 @@ static void eeh_add_device_late(struct pci_dev
> *dev) pr_debug("EEH: Adding device %s\n", pci_name(dev));
>  
>  	dn = pci_device_to_OF_node(dev);
> -	edev = pci_dev_to_eeh_dev(dev);
> +	edev = of_node_to_eeh_dev(dn);
>  	if (edev->pdev == dev) {
>  		pr_debug("EEH: Already referenced !\n");
>  		return;
