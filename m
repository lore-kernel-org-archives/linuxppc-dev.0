Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zf1wc1fZRzF0gK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 06:20:15 +1100 (AEDT)
Date: Sat, 10 Feb 2018 09:43:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root as
 well as Downstream Ports
Message-ID: <20180210154342.GE206223@bhelgaas-glaptop.roam.corp.google.com>
References: <20171202002710.17686.21340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171202191827.GB18780@bhelgaas-glaptop.roam.corp.google.com>
 <33CA1586-051C-47F4-83CD-4A406FAE85F7@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <33CA1586-051C-47F4-83CD-4A406FAE85F7@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 10, 2018 at 09:05:40AM +0100, Christian Zigotzky wrote:
> Hi All,
> 
> The AmigaOne X1000 doesn’t boot anymore since the PCI updates. I
> have seen, that the PCI updates are different to the updates below.
> The code below works but the latest not. Is there a problem with the
> latest PCI updates currently?

I'm not aware of a problem, and it *looks* like the patch below is in
Linus' tree (I'm looking at 9a61df9e5f74 ("Merge tag 'kbuild-v4.16-2'
of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")).

I assume you're still booting with "pci=pcie_scan_all", since I don't
think we ever got a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically.

If AmigaOne X1000 doesn't boot with "pci=pcie_scan_all", can you diff
the working only_one_child() with the current upstream?  I compared
the version in my pci/enumeration branch with what's upstream, and
they're identical.  So maybe the original patch I applied was wrong?

If you have a patch that works, can you post it and maybe I can sort
out what's different?

> On 2. Dec 2017, at 20:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Fri, Dec 01, 2017 at 06:27:10PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCIe Downstream Ports normally have only a Device 0 below them.  To
> optimize enumeration, we don't scan for other devices *unless* the
> PCI_SCAN_ALL_PCIE_DEVS flag is set by set by quirks or the
> "pci=pcie_scan_all" kernel parameter.
> 
> Previously PCI_SCAN_ALL_PCIE_DEVS only affected scanning below Switch
> Downstream Ports, not Root Ports.
> 
> But the "Nemo" system, also known as the AmigaOne X1000, has a PA Semi Root
> Port whose link leads to an AMD/ATI SB600 South Bridge.  The Root Port is a
> PCIe device, of course, but the SB600 contains only conventional PCI
> devices with no visible PCIe port.
> 
> Simplify and restructure only_one_child() so that we scan for all possible
> devices below Root Ports as well as Switch Downstream Ports when
> PCI_SCAN_ALL_PCIE_DEVS is set.
> 
> This is enough to make Nemo work with "pci=pcie_scan_all".  We would also
> like to add a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically on Nemo so
> users wouldn't have to use the "pci=pcie_scan_all" parameter, but we don't
> have that yet.
> 
> Link: https://lkml.kernel.org/r/CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198057
> Reported-and-Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied to pci/enumeration for v4.16.
> 
> ---
> drivers/pci/probe.c |   25 +++++++++++++++----------
> 1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 14e0ea1ff38b..303c0cb0550c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2215,22 +2215,27 @@ static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
> 
> static int only_one_child(struct pci_bus *bus)
> {
> -    struct pci_dev *parent = bus->self;
> +    struct pci_dev *bridge = bus->self;
> 
> -    if (!parent || !pci_is_pcie(parent))
> +    /*
> +     * Systems with unusual topologies set PCI_SCAN_ALL_PCIE_DEVS so
> +     * we scan for all possible devices, not just Device 0.
> +     */
> +    if (pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>        return 0;
> -    if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
> -        return 1;
> 
>    /*
> -     * PCIe downstream ports are bridges that normally lead to only a
> -     * device 0, but if PCI_SCAN_ALL_PCIE_DEVS is set, scan all
> -     * possible devices, not just device 0.  See PCIe spec r3.0,
> -     * sec 7.3.1.
> +     * A PCIe Downstream Port normally leads to a Link with only Device
> +     * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
> +     * only for Device 0 in that situation.
> +     *
> +     * Checking has_secondary_link is a hack to identify Downstream
> +     * Ports because sometimes Switches are configured such that the
> +     * PCIe Port Type labels are backwards.
>     */
> -    if (parent->has_secondary_link &&
> -        !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
> +    if (bridge && pci_is_pcie(bridge) && bridge->has_secondary_link)
>        return 1;
> +
>    return 0;
> }
> 
