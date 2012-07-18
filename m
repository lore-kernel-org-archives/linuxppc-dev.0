Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3A892C0092
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 03:00:16 +1000 (EST)
Received: by lbgc1 with SMTP id c1so2148436lbg.15
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 10:00:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120718042512.GA2375@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw> <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop> <20120717100314.GB25613@ram-ThinkPad-T61>
 <1342521498.3669.7.camel@pasglop>
 <CAErSpo4AS=QCRE3w-QBzuuSSEK8VeQ+PXxyp3mTyDAEvASxQcQ@mail.gmail.com>
 <20120718042512.GA2375@ram-ThinkPad-T61>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 18 Jul 2012 10:59:52 -0600
Message-ID: <CAErSpo79HSj+8o9u6P689UEP9qPTUWrnuNPO3NDjErQa6EbhUg@mail.gmail.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
To: Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 10:25 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Tue, Jul 17, 2012 at 11:14:51AM -0600, Bjorn Helgaas wrote:
>> On Tue, Jul 17, 2012 at 4:38 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Tue, 2012-07-17 at 18:03 +0800, Ram Pai wrote:
>> >>         Lets say we passed that 'type' flag to size the minimum
>> >>         alignment constraints for that b_res.  And window_alignment(bus,
>> >>         type) of your platform  used that 'type' information to
>> >>         determine whether to use the alignment constraints of 32-bit
>> >>         window or 64-bit window.
>> >>
>> >>         However, later when the b_res is actually allocated a resource,
>> >>         the pci_assign_resource() has no idea whether to allocate 32-bit
>> >>         window resource or 64-bit window resource, because the 'type'
>> >>         information is not captured anywhere in b_res.
>> >>
>> >>         You would basically have a disconnect between what is sized and
>> >>         what is allocated. Unless offcourse you pass that 'type' to
>> >>         the b_res->flags, which is currently not the case.
>> >
>> > Right, we ideally would need the core to query the alignment once per
>> > "apertures" it tries as a candidate to allocate a given resource... but
>> > that's for later.
>> >
>> > For now we can probably live with giving out the max of the minimum
>> > alignment we support for M64 and our M32 segment size.
>>
>> We already know the aperture we're proposing to allocate from (the
>> result of find_free_bus_resource()), don't we?  What if we passed it
>> to pcibios_window_alignment() along with the struct pci_bus *, e.g.:
>>
>>   resource_size_t pcibios_window_alignment(struct pci_bus *bus, struct
>> resource *window)
>
> Hmm..'struct resource *window' may not yet know which aperature it is
> allocated from. Will it? We are still in the sizing process, the allocation will
> be done much later.

Of course, you're absolutely right; I had this backwards.  In
pbus_size_io/mem(), we do "b_res = find_free_bus_resource()", so b_res
is a bus resource that matches the desired type (IO/MEM).  This
resource represents an aperture of the upstream bridge leading to the
bus.  I was thinking that b_res->start would contain address
information that the arch could use to decide alignment.

But at this point, in pbus_size_io/mem(), we set "b_res->start =
min_align", so obviously b_res contains no information about the
window base that will eventually be assigned.  I think b_res is
basically the *container* into which we'll eventually put the P2P
aperture start/end, but here, we're using that container to hold the
information about the size and alignment we need for that aperture.

The fact that we deal with alignment in pbus_size_mem() and again in
__pci_assign_resource() (via pcibios_align_resource) is confusing to
me -- I don't have a clear idea of what sorts of alignment are done in
each place.  Could this powerpc alignment be done in
pcibios_align_resource()?  We do have the actual proposed address
there, as well as the pci_dev.

Bjorn
