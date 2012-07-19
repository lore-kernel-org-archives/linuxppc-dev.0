Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 039F12C0125
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 17:24:29 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 19 Jul 2012 03:24:25 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2780EC9001B
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 03:24:23 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6J7OMmV429618
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 03:24:22 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6J7OL2G025719
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 01:24:21 -0600
Date: Thu, 19 Jul 2012 15:24:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120719072417.GA10326@shangw.(null)>
References: <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw>
 <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop>
 <20120717100314.GB25613@ram-ThinkPad-T61>
 <1342521498.3669.7.camel@pasglop>
 <CAErSpo4AS=QCRE3w-QBzuuSSEK8VeQ+PXxyp3mTyDAEvASxQcQ@mail.gmail.com>
 <20120718042512.GA2375@ram-ThinkPad-T61>
 <CAErSpo79HSj+8o9u6P689UEP9qPTUWrnuNPO3NDjErQa6EbhUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo79HSj+8o9u6P689UEP9qPTUWrnuNPO3NDjErQa6EbhUg@mail.gmail.com>
Cc: yinghai@kernel.org, linuxppc-dev@ozlabs.org, Ram Pai <linuxram@us.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2012 at 10:59:52AM -0600, Bjorn Helgaas wrote:
>On Tue, Jul 17, 2012 at 10:25 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>> On Tue, Jul 17, 2012 at 11:14:51AM -0600, Bjorn Helgaas wrote:
>>> On Tue, Jul 17, 2012 at 4:38 AM, Benjamin Herrenschmidt
>>> <benh@kernel.crashing.org> wrote:
>>> > On Tue, 2012-07-17 at 18:03 +0800, Ram Pai wrote:
>>> >>         Lets say we passed that 'type' flag to size the minimum
>>> >>         alignment constraints for that b_res.  And window_alignment(bus,
>>> >>         type) of your platform  used that 'type' information to
>>> >>         determine whether to use the alignment constraints of 32-bit
>>> >>         window or 64-bit window.
>>> >>
>>> >>         However, later when the b_res is actually allocated a resource,
>>> >>         the pci_assign_resource() has no idea whether to allocate 32-bit
>>> >>         window resource or 64-bit window resource, because the 'type'
>>> >>         information is not captured anywhere in b_res.
>>> >>
>>> >>         You would basically have a disconnect between what is sized and
>>> >>         what is allocated. Unless offcourse you pass that 'type' to
>>> >>         the b_res->flags, which is currently not the case.
>>> >
>>> > Right, we ideally would need the core to query the alignment once per
>>> > "apertures" it tries as a candidate to allocate a given resource... but
>>> > that's for later.
>>> >
>>> > For now we can probably live with giving out the max of the minimum
>>> > alignment we support for M64 and our M32 segment size.
>>>
>>> We already know the aperture we're proposing to allocate from (the
>>> result of find_free_bus_resource()), don't we?  What if we passed it
>>> to pcibios_window_alignment() along with the struct pci_bus *, e.g.:
>>>
>>>   resource_size_t pcibios_window_alignment(struct pci_bus *bus, struct
>>> resource *window)
>>
>> Hmm..'struct resource *window' may not yet know which aperature it is
>> allocated from. Will it? We are still in the sizing process, the allocation will
>> be done much later.
>
>Of course, you're absolutely right; I had this backwards.  In
>pbus_size_io/mem(), we do "b_res = find_free_bus_resource()", so b_res
>is a bus resource that matches the desired type (IO/MEM).  This
>resource represents an aperture of the upstream bridge leading to the
>bus.  I was thinking that b_res->start would contain address
>information that the arch could use to decide alignment.
>
>But at this point, in pbus_size_io/mem(), we set "b_res->start =
>min_align", so obviously b_res contains no information about the
>window base that will eventually be assigned.  I think b_res is
>basically the *container* into which we'll eventually put the P2P
>aperture start/end, but here, we're using that container to hold the
>information about the size and alignment we need for that aperture.
>
>The fact that we deal with alignment in pbus_size_mem() and again in
>__pci_assign_resource() (via pcibios_align_resource) is confusing to
>me -- I don't have a clear idea of what sorts of alignment are done in
>each place.  Could this powerpc alignment be done in
>pcibios_align_resource()?  We do have the actual proposed address
>there, as well as the pci_dev.
>

If I understood correctly, it's a bit hard to put PowerPC alignment in
the function pcibios_align_resource(). The target of those patches is
to make those I/O and memory windows of p2p bridges aligned based on
the special requirement from specific platform, so that we can put
the corresponding PCI bus directed from the p2p bridge into separate
EEH segment. Unforunately, pcibios_align_resource() was implemented
based on individual bars (resources) and individual bars doesn't
have the alignment requirement under current situation :-)

Thanks,
Gavin

>Bjorn
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
>
