Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-x230.google.com (mail-oa0-x230.google.com
 [IPv6:2607:f8b0:4003:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 173EF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 04:49:28 +1000 (EST)
Received: by mail-oa0-f48.google.com with SMTP id f4so3730732oah.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jul 2013 11:49:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Jul 2013 12:49:05 -0600
Message-ID: <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
Subject: Re: [PATCH 1/8] PCI: Add pcibios_stop_dev()
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 4, 2013 at 8:57 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> When stopping and removing one specific PCI device, the platform
> might need take some actions. One example is that EEH already had
> eeh cache and eeh device attached to the PCI device, and we need
> release eeh cache and device during the time. The patch introduces
> hook pcibios_stop_dev() for the purpose.
>
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
>                 struct pci_ops *ops, void *sysdata, struct list_head *resources)
>  {
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 8fc54b7..e329efc 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -21,6 +21,8 @@ static void pci_stop_dev(struct pci_dev *dev)
>  {
>         pci_pme_active(dev, false);
>
> +       pcibios_stop_dev(dev);

We already have pcibios_release_device() (just merged for v3.11).
Would that work for you?  I haven't seen your whole series, so I can't
tell whether you need something different.

>         if (dev->is_added) {
>                 pci_proc_detach_device(dev);
>                 pci_remove_sysfs_dev_files(dev);
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
> --
> 1.7.5.4
>
