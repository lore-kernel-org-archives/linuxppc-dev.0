Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F16D2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 13:08:15 +1000 (EST)
Message-ID: <1372993680.4122.104.camel@pasglop>
Subject: Re: [PATCH 1/8] PCI: Add pcibios_stop_dev()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 05 Jul 2013 13:08:00 +1000
In-Reply-To: <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-05 at 10:57 +0800, Gavin Shan wrote:
> When stopping and removing one specific PCI device, the platform
> might need take some actions. One example is that EEH already had
> eeh cache and eeh device attached to the PCI device, and we need
> release eeh cache and device during the time. The patch introduces
> hook pcibios_stop_dev() for the purpose.

Bjorn, any objection ? Ack ? Nack ? :-)

I'd like to put that in my tree, it's part of a series that fixes a
number of bugs with our hotplug and EEH code which I'd like to send
to Linus soonish.

Cheers,
Ben.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/probe.c  |    4 ++++
>  drivers/pci/remove.c |    2 ++
>  include/linux/pci.h  |    1 +
>  3 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 70f10fa..7167dc4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1669,6 +1669,10 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
>  {
>  }
>  
> +void __weak pcibios_stop_dev(struct pci_dev *dev)
> +{
> +}
> +
>  struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  		struct pci_ops *ops, void *sysdata, struct list_head *resources)
>  {
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 8fc54b7..e329efc 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -21,6 +21,8 @@ static void pci_stop_dev(struct pci_dev *dev)
>  {
>  	pci_pme_active(dev, false);
>  
> +	pcibios_stop_dev(dev);
> +
>  	if (dev->is_added) {
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3a24e4f..40df783 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -696,6 +696,7 @@ int no_pci_devices(void);
>  void pcibios_resource_survey_bus(struct pci_bus *bus);
>  void pcibios_add_bus(struct pci_bus *bus);
>  void pcibios_remove_bus(struct pci_bus *bus);
> +void pcibios_stop_dev(struct pci_dev *dev);
>  void pcibios_fixup_bus(struct pci_bus *);
>  int __must_check pcibios_enable_device(struct pci_dev *, int mask);
>  /* Architecture specific versions may override this (weak) */
