Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com
 [IPv6:2607:f8b0:4003:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 374DE2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 04:51:33 +1000 (EST)
Received: by mail-ob0-f176.google.com with SMTP id v19so3199420obq.21
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jul 2013 11:51:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372993054-25730-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372993054-25730-5-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Jul 2013 12:51:10 -0600
Message-ID: <CAErSpo70EDUOhWT+w5VTyEecJB66x5kL9wH9Ju+zzGi-yCVnsA@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI/hotplug: Needn't remove EEH cache again
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
> Since pci_stop_and_remove_bus_device() has removed the EEH cache,
> we needn't do that again.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please merge this along with the rest of your series via whatever tree
you choose.

> ---
>  drivers/pci/hotplug/rpadlpar_core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index b29e20b..bb7af78 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -388,7 +388,6 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
>         /* Remove the EADS bridge device itself */
>         BUG_ON(!bus->self);
>         pr_debug("PCI: Now removing bridge device %s\n", pci_name(bus->self));
> -       eeh_remove_bus_device(bus->self, true);
>         pci_stop_and_remove_bus_device(bus->self);
>
>         return 0;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
