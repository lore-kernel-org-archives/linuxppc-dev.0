Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-x233.google.com (mail-oa0-x233.google.com
 [IPv6:2607:f8b0:4003:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67F4C2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:02:37 +1000 (EST)
Received: by mail-oa0-f51.google.com with SMTP id i4so1750836oah.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 11:02:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374632701-20972-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1374632701-20972-5-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Jul 2013 12:02:11 -0600
Message-ID: <CAErSpo7rXF9vf=BMT1LoLeHPRiyJxT2XWbroRjdt+DH8+4QOnA@mail.gmail.com>
Subject: Re: [PATCH 04/11] PCI/hotplug: Needn't remove EEH cache again
To: Gavin Shan <shangw@linux.vnet.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc linux-pci]

On Tue, Jul 23, 2013 at 8:24 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> Since pcibios_release_device() called by pci_stop_and_remove_bus_device()
> has removed the EEH cache, we needn't do that again.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>

I'll be happy to merge this if you want, or since you have my Ack
already, you can merge it with the rest of the series.  I didn't get
the rest of the series, so I don't know if it depends on this.

Just let me know what you want me to do.

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
