Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v6VJ3vGkzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 18:31:51 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id j205-v6so24417908oib.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de>
 <20180817102645.3839621-9-arnd@arndb.de>
In-Reply-To: <20180817102645.3839621-9-arnd@arndb.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Aug 2018 10:31:38 +0200
Message-ID: <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com>
Subject: Re: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2018 at 12:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> pcibios_scan_root() is now just a wrapper around pci_scan_root_bus(),
> and merging the two into one makes it shorter and more readable.
>
> We can also take advantage of pci_alloc_host_bridge() doing the
> allocation of the sysdata for us, which helps if we ever want to
> allow hot-unplugging the host bridge itself.
>
> We might be able to simplify it further using pci_host_probe(),
> but I wasn't sure about the resource registration there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/pci/common.c | 53 ++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 36 deletions(-)
>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index e740d9aa4024..920d0885434c 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -453,54 +453,35 @@ void __init dmi_check_pciprobe(void)
>         dmi_check_system(pciprobe_dmi_table);
>  }
>
> -static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
> -               struct pci_ops *ops, void *sysdata, struct list_head *resources)
> +void pcibios_scan_root(int busnum)
>  {
> +       struct pci_sysdata *sd;
>         struct pci_host_bridge *bridge;
>         int error;
>
> -       bridge = pci_alloc_host_bridge(0);
> -       if (!bridge)
> -               return NULL;
> +       bridge = pci_alloc_host_bridge(sizeof(sd));
> +       if (!bridge) {
> +               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> +               return;
> +       }
> +       sd = pci_host_bridge_priv(bridge);

This looks fishy, as bridge->private is not set at this point AFAICS,
unless one of the previous patches changes that.

>
> -       list_splice_init(resources, &bridge->windows);
> -       bridge->dev.parent = parent;
> -       bridge->sysdata = sysdata;
> -       bridge->busnr = bus;
> -       bridge->ops = ops;
> +       sd->node = x86_pci_root_bus_node(busnum);
> +       x86_pci_root_bus_resources(busnum, &bridge->windows);
> +       bridge->sysdata = sd;
> +       bridge->busnr = busnum;
> +       bridge->ops = &pci_root_ops;
>
> +       printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
>         error = pci_scan_root_bus_bridge(bridge);
>         if (error < 0)
>                 goto err_out;
>
> -       return bridge->bus;
> +       pci_bus_add_devices(bridge->bus);
> +       return;
>
>  err_out:
> -       kfree(bridge);
> -       return NULL;
> -}
> -
> -void pcibios_scan_root(int busnum)
> -{
> -       struct pci_bus *bus;
> -       struct pci_sysdata *sd;
> -       LIST_HEAD(resources);
> -
> -       sd = kzalloc(sizeof(*sd), GFP_KERNEL);
> -       if (!sd) {
> -               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> -               return;
> -       }
> -       sd->node = x86_pci_root_bus_node(busnum);
> -       x86_pci_root_bus_resources(busnum, &resources);
> -       printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
> -       bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
> -       if (!bus) {
> -               pci_free_resource_list(&resources);
> -               kfree(sd);
> -               return;
> -       }
> -       pci_bus_add_devices(bus);
> +       pci_free_host_bridge(bridge);
>  }
>
>  void __init pcibios_set_cache_line_size(void)
> --
> 2.18.0
>
