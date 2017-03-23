Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq0lt3pGgzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 08:57:46 +1100 (AEDT)
Date: Thu, 23 Mar 2017 16:57:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 2/3] PCI: Add a macro to set default alignment for all
 PCI devices
Message-ID: <20170323215741.GA9255@bhelgaas-glaptop.roam.corp.google.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2017 at 03:53:42PM -0500, Bjorn Helgaas wrote:
> Hi Yongji,
> 
> On Wed, Feb 15, 2017 at 02:45:05PM +0800, Yongji Xie wrote:
> > When vfio passthroughs a PCI device of which MMIO BARs are
> > smaller than PAGE_SIZE, guest will not handle the mmio
> > accesses to the BARs which leads to mmio emulations in host.
> > 
> > This is because vfio will not allow to passthrough one BAR's
> > mmio page which may be shared with other BARs. Otherwise,
> > there will be a backdoor that guest can use to access BARs
> > of other guest.
> 
> Please include a pointer to the VFIO code that enforces this.  It's
> not obvious to me how it would do this.  This doesn't change the
> *size* of the resource, only the alignment.  So if VFIO sees a BAR
> like [mem 0x80000000-0x800000ff], it knows the BAR is aligned enough
> that it *could* be the only thing on a page, but I don't know how it
> could know that there will never be another BAR at 0x80000100.  Even
> if there's no other BAR on that page *now*, it would have to know that
> no hot-added device will ever be placed on that page.

Never mind, I found it.  I updated the changelog like this; please
correct anything I got wrong:

    When VFIO passes through a PCI device to a guest, it does not
    allow the guest to mmap BARs that are smaller than PAGE_SIZE
    unless it can reserve the rest of the page (see
    vfio_pci_probe_mmaps()).  This is because a page might contain
    several small BARs for unrelated devices and a guest should not be
    able to access all of them.

    VFIO emulates guest accesses to non-mappable BARs, which is
    functional but slow.  On systems with large page sizes, e.g.,
    PowerNV with 64K pages, BARs are more likely to share a page and
    performance is more likely to be a problem.

    Add a macro to set default alignment for all PCI devices.  An arch
    can set this to PAGE_SIZE to force the PCI core to place memory
    BARs on their own pages.
