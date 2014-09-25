Return-Path: <liviu@dudau.co.uk>
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
 by lists.ozlabs.org (Postfix) with ESMTP id B63561A0070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 03:17:05 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp.dudau.co.uk (Postfix) with SMTP id C1F10FFDAF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 18:17:03 +0100 (BST)
Date: Thu, 25 Sep 2014 18:16:12 +0100
From: Liviu Dudau <liviu@dudau.co.uk>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140925171612.GC31157@bart.dudau.co.uk>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140925164937.GB30382@ulmo>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2014 at 06:49:38PM +0200, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 03:48:55PM +0100, Liviu Dudau wrote:
> > On Thu, Sep 25, 2014 at 09:42:36AM +0200, Thierry Reding wrote:
> > > On Thu, Sep 25, 2014 at 11:14:10AM +0800, Yijing Wang wrote:
> > > > This series is based Bjorn's pci/msi branch
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
> > > > 
> > > > Currently, there are a lot of weak arch functions in MSI code.
> > > > Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
> > > > This series use MSI chip framework to refactor MSI code across all platforms
> > > > to eliminate weak arch functions. Then all MSI irqs will be managed in a 
> > > > unified framework. Because this series changed a lot of ARCH MSI code,
> > > > so tests in the platforms which MSI code modified are warmly welcomed!
> > > 
> > > Apart from the comments to the individual patches I very much like where
> > > this is going. Thanks for taking care of this.
> > > 
> > > Thierry
> > 
> > I am actually in disagreement with you, Thierry. I don't like the general direction
> > of the patches, or at least I don't like the fact that we don't have a portable
> > way of setting up the msi_chip without having to rely on weak architectural hooks.
> 
> Oh, good. That's actually one of the things I said I wasn't happy with
> either. =)
> 
> > I'm surprised no one considers the case of a platform having more than one host
> > bridge and possibly more than one MSI unit. With the current proposed patchset I
> > can't see how that would work.
> 
> The PCI core can already deal with that. An MSI chip can be set per bus
> and the weak pcibios_add_bus() can be used to set that. Often it might
> not even be necessary to do it via pcibios_add_bus() if you create the
> root bus directly, since you can attach the MSI chip at that time.

But I'm thinking that we need to move away from pcibios_add_bus() interface to do
something that should be generic. You don't need to be called for every bus when all
you want is just the root bus in order to add the MSI chip. Also, from looking at
the current patchset, a lot of architectures would set the MSI chip to a global
variable, which means you don't have an option to choose the MSI chip based on the
bus.

> 
> > What I would like to see is a way of creating the pci_host_bridge structure outside
> > the pci_create_root_bus(). That would then allow us to pass this sort of platform
> > details like associated msi_chip into the host bridge and the child busses will
> > have an easy way of finding the information needed by finding the root bus and then
> > the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
> > everyone and the drivers can remove their kludges that try to work around the
> > current limitations.
> 
> I think both issues are orthogonal. Last time I checked a lot of work
> was still necessary to unify host bridges enough so that it could be
> shared across architectures. But perhaps some of that work has
> happened in the meantime.

Breaking out the host bridge creation from root bus creation is not difficult, just not
agree upon. That would be the first step in making the generic host brige structure
useful for sharing, specially if used as a sort of "parent" structure that you can
wrap with your actual host bridge structure.

> 
> But like I said, when you create the root bus, you can easily attach the
> MSI chip to it.

Not if you want to use the generic pci_scan_root_bus() function. One needs to copy the code
and add their own needed modifications. Which makes it hard to fix bugs and prevents code
reuse.

Best regards,
Liviu

> 
> Thierry



-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
