Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414h9n5BghzF3Xn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 17:20:29 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id j135-v6so14180498itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 00:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <1528785733-19442-1-git-send-email-kernelfans@gmail.com>
 <20180612065727.GA5195@infradead.org>
In-Reply-To: <20180612065727.GA5195@infradead.org>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 12 Jun 2018 15:20:15 +0800
Message-ID: <CAFgQCTvYDbw3fv7k-Y999F2fCfCs7TiGd4xd6isp0wZBr8dT3Q@mail.gmail.com>
Subject: Re: [PATCH] pci/shpchp: no claim on pcie port device
To: hch@infradead.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2018 at 2:57 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 12, 2018 at 02:42:13PM +0800, Pingfan Liu wrote:
> > The Linux Device Driver Model allows a physical device to be handled
> > by only a single driver. But at present, both shpchp and portdrv_pci
> > claim PCI_CLASS_BRIDGE_PCI, and touch devices_kset. This causes a
> > few problems, one is the wrong shutdown seq of devices, owing to the
> > broken devices_kset.
>
> How can they both touch devices_kset?  Once one driver has claimed the
> device it should not be available to others.
>
Unfortunately, it could be.  There are two code path for do_one_initcall
kernel_init->..->do_one_initcall->pcie_portdrv_init
And
load_module->do_init_module->do_one_initcall->shpcd_init
> > +     /* do not claim pcie port device */
> > +     if (pci_is_pcie(dev) &&
> > +         ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) ||
> > +          (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) ||
> > +          (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)))
> > +             return -ENODEV;
>
> No need for the inner braces.

OK.

Thanks,
Pingfan
