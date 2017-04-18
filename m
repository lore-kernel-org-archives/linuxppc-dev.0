Return-Path: <bhelgaas@google.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6mnw0S7HzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 23:54:12 +1000 (AEST)
Received: by mail-wm0-x231.google.com with SMTP id u2so55668237wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 06:54:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Apr 2017 08:53:47 -0500
Message-ID: <CAErSpo6gtDos6GH5Z7aOoW4a3uS4X-HOOHtPFtyg=F+B6+osrw@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
To: Yongji Xie <elohimes@gmail.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 17, 2017 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Yongji Xie <elohimes@gmail.com>
>
> This overrides pcibios_default_alignment() to set default alignment
> to PAGE_SIZE for all PCI devices on PowerNV platform. Thus sub-page
> BARs would not share a page and could be mapped into guest when VFIO
> passthrough them.
>
> Signed-off-by: Yongji Xie <elohimes@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    2 ++
>  arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |    7 +++++++
>  3 files changed, 17 insertions(+)

> +resource_size_t pcibios_default_alignment(struct pci_dev *pdev)
> +{
> +       if (ppc_md.pcibios_default_alignment)
> +               return ppc_md.pcibios_default_alignment(pdev);
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_PCI_IOV
>  resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
>  {
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 6901a06da2f9..b724487cbd0f 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3287,6 +3287,11 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>         }
>  }
>
> +static resource_size_t pnv_pci_default_alignment(struct pci_dev *pdev)
> +{
> +       return PAGE_SIZE;
> +}

Is it necessary that pcibios_default_alignment() take a pci_dev
pointer?  I'd like this better if it were:

  resource_size_t pcibios_default_alignment(void) { ... }

because the last patch relies on the assumption that all resources of
*all* devices will be realigned to the same alignment.

Bjorn
