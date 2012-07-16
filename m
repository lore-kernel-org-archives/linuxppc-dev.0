Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D1A42C00FE
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 00:58:44 +1000 (EST)
Received: by lbgc1 with SMTP id c1so6713461lbg.15
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 07:58:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120716035044.GC24203@shangw>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
 <878dcc914319fd110ceda936c2ce5b6bb7a449ab.1340949637.git.shangw@linux.vnet.ibm.com>
 <20120713201250.GB18587@google.com> <20120716035044.GC24203@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 16 Jul 2012 08:58:20 -0600
Message-ID: <CAErSpo5sfBidPhgq942k7DZRfYtemqmMF=Lrph_zu2-g6Pbi0g@mail.gmail.com>
Subject: Re: [PATCH 5/7] pci: minimal alignment for bars of P2P bridges
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, linuxram@us.ibm.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 15, 2012 at 9:50 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> On Fri, Jul 13, 2012 at 02:12:50PM -0600, Bjorn Helgaas wrote:
>>On Fri, Jun 29, 2012 at 02:47:48PM +0800, Gavin Shan wrote:
>>> On some powerpc platforms, device BARs need to be assigned to separate
>>> "segments" of the address space in order for the error isolation and HW
>>> virtualization mechanisms (EEH) to work properly. Those "segments" have
>>> a minimum size that can be fairly large (16M). In order to be able to
>>> use the generic resource assignment code rather than re-inventing our
>>> own, we chose to group devices by bus. That way, a simple change of the
>>> minimum alignment requirements of resources assigned to PCI to PCI (P2P)
>>> bridges is enough to ensure that all BARs for devices below those bridges
>>> will fit into contiguous sets of segments and there will be no overlap.
>
> I send the previous reply in a rush and that missed some
> necessary information. So I resend it with some makeup.
>
>>If I understand correctly, you might have something like this:
>>
>>  PCI host bridge to bus 0000:00
>>  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xcfffffff]
>>  0000:00:01.0: PCI bridge to [bus 10-1f]
>>  0000:00:01.0:   bridge window [mem 0xc1000000-0xc1ffffff]
>>  0000:00:02.0: PCI bridge to [bus 20-2f]
>>  0000:00:02.0:   bridge window [mem 0xc2000000-0xc2ffffff]
>>
>>where everything under bridge 00:01.0 is in one EEH segment, and
>>everything under 00:02.0 is in another.  In this case, each EEH
>>segment is 16MB.
>>
>>I think your proposal is basically that when we add up resources required
>>below the P2P bridges, we round up to the default 1MB (the minimum P2P
>>bridge memory aperture size per spec) *or* to a larger value, e.g., 16MB,
>>if the architecture requires it.
>
> Yes, you're correct.
>
>>That makes sense to me, but I have some implementation questions.
>>
>>Your patches make the required alignment a property of the host bridge.
>>But don't you want to do this rounding up only at certain levels of the
>>hierarchy?  For example, what if you had another P2P bridge:
>>
>>  0000:10:01.0: PCI bridge to [bus 18-1f]
>>
>>I assume the devices on bus 0000:18 would still be in the first EEH
>>segment, and you wouldn't necessarily want to round up the 10:01.0
>>apertures to 16MB.
>>
>>Maybe there should be an interface like this:
>>
>>  resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
>>                                                 unsigned long type)
>>  {
>>    if (type & IORESOURCE_MEM)
>>      return 1024*1024;                /* mem windows must be 1MB aligned */
>>    if (bus->self->io_window_1k)
>>      return 1024;
>>    return 4*1024;             /* I/O windows default to 4K alignment */
>>  }
>>
>>that the arch could override?  Then you could return the 16MB alignment
>>for the top-level P2P bridge leading to an EEH segment, and use the
>>default alignment for P2P bridges *inside* the segment.
>>
>
> Yes. I think it's good mechanism to apply the minimal resource alignment
> for P2P bridges. Also, it wouldn't waste more resources if the specific
> PCI bridge (not PCIe bridge) needn't form separate EEH segment. However,
> I have some implementation questions for this.
>
> 1. I just checked out source code from following link, but it seems that
>    pci_dev doesn't have field called "io_window_1k", so I'm not sure I
>    should add that by myself?
>
>         git clone git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git linux-pci-next

No, don't add io_window_1k in your patch.  That was added in a recent
patch and should already be in my "next" branch:

http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=commitdiff;h=2b28ae1912e5ce5bb0527e352ae6ff04e76183d1

If there are merge conflicts with your patch, I can resolve them.

> 2. With the mechanism (__weak function) you suggested, the alignment of
>    the specific P2P bridge should be figured out by PowerPC platform. That's
>    to say, the PPC platform has to introduce function pcibios_window_alignment()
>    and return the appropriate alignment.

Yes.

> 3. In order to return appropriate alignment from PPC platform, We need
>    to introduce same function for PPC platform. Also, we probably need
>    introduce function "ppc_md.pcibios_window_alignment" so that those
>    specific platforms (e.g. powernv) could override that.

Yes.
