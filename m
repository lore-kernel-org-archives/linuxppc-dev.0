Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7F6F1A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 11:56:41 +1100 (AEDT)
Received: by mail-oi0-f45.google.com with SMTP id i138so142544oig.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 16:56:39 -0800 (PST)
Date: Thu, 19 Feb 2015 18:56:21 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH V11 06/17] powerpc/pci: Add PCI resource alignment
 documentation
Message-ID: <20150220005621.GA21131@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204234433.GC11271@google.com>
 <1423530151.4924.73.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423530151.4924.73.camel@au1.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2015 at 12:02:31PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2015-02-04 at 17:44 -0600, Bjorn Helgaas wrote:
> > > 
> > > diff --git a/Documentation/powerpc/pci_iov_resource_on_powernv.txt b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
> > > new file mode 100644
> > > index 0000000..10d4ac2
> > > --- /dev/null
> > > +++ b/Documentation/powerpc/pci_iov_resource_on_powernv.txt
> > 
> > I added the following two patches on top of this because I'm still confused
> > about the difference between the M64 window and the M64 BARs.  Several
> > parts of the writeup seem to imply that there are several M64 windows, but
> > that seems to be incorrect.
> > 
> > And I tried to write something about M64 BARs, too.  But it could well be
> > incorrect.
> > 
> > Please correct as necessary.  Ultimately I'll just fold everything into the
> > original patch so there's only one.
> 
> The way the HW works is that 2 windows of the CPU address space are
> routed to each PHB. One is used for 32-bit stuff and one is used for
> 64-bit stuff (it doesn't have to be and it's not fixed in HW which is
> which, it's just two windows of the fabric being forwarded but that's
> how we use them). The FW configures them, one is 4G and the other one is
> today 64G but that might get increased at some point.
> 
> (Actually there's a 3rd window but it's exclusively used for the PHB
> own registers so we can ignore it here).
> 
> Once an MMIO cycle hit one of the above window on the powerbus it gets
> forwarded to the PHB.
> 
> Now the PHB itself contains a number of "BARs" which aren't the same
> thing as device BARs so it's confusing and I tend to call them "windows"
> for that reason. They are made of pairs of registers indicating an
> address and a size (sort-of, the M64 ones are actually in some CAM in
> the chip but that's a register access method detail that is not relevant
> here).
> 
>  - One M32. It's limited to 4G in size, and has the specific attribute
> that the top bits of the address from the powerbus are dropped (and
> replaced with the content of a register) thus allowing this "window" to
> target the 32-bit MMIO space from anywhere in the CPU 50-bit bus space.
> This is setup at boot time, and we can probably ignore it here. It has
> it's own segmenting for PEs which is a bit different from 64-bit stuff
> as it goes through a remapping table allowing to configure which PE each
> segment maps to.
> 
>  - 16 M64's. Each of these can be configured individually to pass a
> portion of the above "window" space to the PCIe bus. There is no
> remapping in that case (the powerbus addresses are passed 1:1). Each of
> those M64's can be configured to have either a single PE (in which case
> the PE number can be configured) or to be segmented (256 PE's but the PE
> number cannot be configured and is equal to the segment number).
> 
> Additionally, the M64's can overlap, in which case we have a well
> defined precedence order, which allows us to create a "backing" M64
> that cover the entire 64G window going to the PCIe for "normal" 64-bit
> BARs and overlap on top of that M64's appropriately sized and positioned
> to cover IOV BARs (or in some case, single-PE M64's to cover very large
> device BARs in order to avoid using too many PE's in the "backing" M64).

So there are the two windows of CPU address space that are routed to the
PHB.  And the PHB contains one M32 window and sixteen M64 windows.  What
happens if the PHB receives an access to something that was in one of the
two CPU address space windows, but is not contained in M32 or one of the
M64 windows?

If that is an error or is non-sensical, then the only windows relevant to
PCI would be the M32 and M64 windows, and we could just ignore the
top-level two windows.

I squashed all my doc updates into the original and pushed it here:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=5449d1a812d561bafe0d458132ef356765505507

If I made it say something wrong, a patch would be the best way to fix it.

Bjorn
