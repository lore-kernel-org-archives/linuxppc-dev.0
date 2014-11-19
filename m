Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A63BC1A0808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 12:12:50 +1100 (AEDT)
Received: by mail-ie0-f169.google.com with SMTP id y20so8527159ier.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 17:12:47 -0800 (PST)
Date: Tue, 18 Nov 2014 18:12:43 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
Message-ID: <20141119011243.GA23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com, Donald Dutile <ddutile@redhat.com>,
 Myron Stowe <myron.stowe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Don, Myron]

Hi Wei,

On Sun, Nov 02, 2014 at 11:41:19PM +0800, Wei Yang wrote:
> When retrieving VF IOV BAR in virtfn_add(), it will divide the total PF's IOV
> BAR size with the totalVF number. This is true for most cases, while may not
> be correct on some specific platform.
> 
> For example on PowerNV platform, in order to fix PF's IOV BAR into a hardware
> alignment, the PF's IOV BAR size would be expended. This means the original
> method couldn't work.
> 
> This patch introduces a weak pcibios_iov_resource_size() interface, which
> gives platform a chance to implement specific method to calculate the VF BAR
> resource size.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/iov.c   |   27 +++++++++++++++++++++++++--
>  include/linux/pci.h |    5 +++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4d1685d..6866830 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -61,6 +61,30 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
>  		pci_remove_bus(virtbus);
>  }
>  
> +resource_size_t __weak pcibios_iov_resource_size(struct pci_dev *dev, int resno)
> +{
> +	return 0;
> +}
> +
> +resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
> +{
> +	resource_size_t size;
> +	struct pci_sriov *iov;
> +
> +	if (!dev->is_physfn)
> +		return 0;
> +
> +	size = pcibios_iov_resource_size(dev, resno);
> +	if (size != 0)
> +		return size;
> +
> +	iov = dev->sriov;
> +	size = resource_size(dev->resource + resno);
> +	do_div(size, iov->total_VFs);
> +
> +	return size;
> +}
> +
>  static int virtfn_add(struct pci_dev *dev, int id, int reset)
>  {
>  	int i;
> @@ -96,8 +120,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>  			continue;
>  		virtfn->resource[i].name = pci_name(virtfn);
>  		virtfn->resource[i].flags = res->flags;
> -		size = resource_size(res);
> -		do_div(size, iov->total_VFs);
> +		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>  		virtfn->resource[i].start = res->start + size * id;

Can you help me understand this?

We have previously called sriov_init() on the PF.  There, we sized the VF
BARs, which are in the PF's SR-IOV Capability (SR-IOV spec sec 3.3.14).
The size we discover is the amount of space required by a single VF, so
sriov_init() adjusts PF->resource[PCI_IOV_RESOURCES + i] by multiplying
that size by PCI_SRIOV_TOTAL_VF, so this PF resource is now big enough to 
hold the VF BAR[i] areas for all the possible VFs.

Now we're in virtfn_add(), setting up a new VF.  The usual BARs at config
space 0x10, etc., are read-only zeroes for a VF, so we don't size them the
usual way.  Instead, we carve out a slice of the
PF->resource[PCI_IOV_RESOURCES + i] area.

I thought the starting address of the VF BARn memory aperture was
prescribed by the spec in sec 2.1.1.1 and shown in figure 2-1:

  BARx VFy starting address = VF BARx + (y - 1) * (VF BARx aperture size)

That's basically what the existing code does.  We don't save the VF BARx
aperture size, so we recompute it by undoing the multiplication we did in
sriov_init().

But you're computing the starting address using a different VF BARx
aperture size.  How does that work?  I assumed this calculation was built
into the PCI device, but obviously I'm missing something.

To make it concrete, here's a made-up example:

  PF SR-IOV Capability
    TotalVFs = 4
    NumVFs = 4
    System Page Size = 4KB
    VF BAR0 = [mem 0x00000000-0x00000fff] (4KB at address 0)

  PF  pci_dev->resource[7] = [mem 0x00000000-0x00003fff] (16KB)
  VF1 pci_dev->resource[0] = [mem 0x00000000-0x00000fff]
  VF2 pci_dev->resource[0] = [mem 0x00001000-0x00001fff]
  VF3 pci_dev->resource[0] = [mem 0x00002000-0x00002fff]
  VF4 pci_dev->resource[0] = [mem 0x00003000-0x00003fff]

You're changing this so we might use 16KB as the VF BAR0 aperture size
instead of 4KB, which would result in the following:

  VF1 pci_dev->resource[0] = [mem 0x00000000-0x00003fff]
  VF2 pci_dev->resource[0] = [mem 0x00004000-0x00007fff]
  VF3 pci_dev->resource[0] = [mem 0x00008000-0x0000bfff]
  VF4 pci_dev->resource[0] = [mem 0x0000c000-0x0000ffff]

But you didn't change sriov_init(), so the PF resource[7] is only 16KB, not
the 64KB the VFs need.  And I assume the VF address decoder is wired to
claim the 4KB regions at 0x0000, 0x1000, 0x2000, 0x3000, not the ones at
0x0000, 0x4000, 0x8000, 0xc000.

Bjorn

>  		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
>  		rc = request_resource(res, &virtfn->resource[i]);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bbf8058..2f5b454 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1162,6 +1162,8 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev,
>  						 int resno,
>  						 resource_size_t align);
> +resource_size_t pcibios_iov_resource_size(struct pci_dev *dev,
> +		                            int resno);
>  
>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
> @@ -1666,6 +1668,7 @@ int pci_num_vf(struct pci_dev *dev);
>  int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
> +resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
>  #else
>  static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>  {
> @@ -1685,6 +1688,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>  { return 0; }
>  static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>  { return 0; }
> +static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
> +{ return 0; }
>  #endif
>  
>  #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
> -- 
> 1.7.9.5
> 
