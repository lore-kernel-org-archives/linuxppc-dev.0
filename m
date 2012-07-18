Return-Path: <linuxram@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B5D52C0322
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 14:25:23 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 17 Jul 2012 22:25:21 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 85FD619D804C
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 04:25:16 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6I4PIsD150050
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 22:25:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6I4PGfH010384
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 22:25:17 -0600
Date: Wed, 18 Jul 2012 12:25:12 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120718042512.GA2375@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw>
 <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop>
 <20120717100314.GB25613@ram-ThinkPad-T61>
 <1342521498.3669.7.camel@pasglop>
 <CAErSpo4AS=QCRE3w-QBzuuSSEK8VeQ+PXxyp3mTyDAEvASxQcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4AS=QCRE3w-QBzuuSSEK8VeQ+PXxyp3mTyDAEvASxQcQ@mail.gmail.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org, yinghai@kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 11:14:51AM -0600, Bjorn Helgaas wrote:
> On Tue, Jul 17, 2012 at 4:38 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2012-07-17 at 18:03 +0800, Ram Pai wrote:
> >>         Lets say we passed that 'type' flag to size the minimum
> >>         alignment constraints for that b_res.  And window_alignment(bus,
> >>         type) of your platform  used that 'type' information to
> >>         determine whether to use the alignment constraints of 32-bit
> >>         window or 64-bit window.
> >>
> >>         However, later when the b_res is actually allocated a resource,
> >>         the pci_assign_resource() has no idea whether to allocate 32-bit
> >>         window resource or 64-bit window resource, because the 'type'
> >>         information is not captured anywhere in b_res.
> >>
> >>         You would basically have a disconnect between what is sized and
> >>         what is allocated. Unless offcourse you pass that 'type' to
> >>         the b_res->flags, which is currently not the case.
> >
> > Right, we ideally would need the core to query the alignment once per
> > "apertures" it tries as a candidate to allocate a given resource... but
> > that's for later.
> >
> > For now we can probably live with giving out the max of the minimum
> > alignment we support for M64 and our M32 segment size.
> 
> We already know the aperture we're proposing to allocate from (the
> result of find_free_bus_resource()), don't we?  What if we passed it
> to pcibios_window_alignment() along with the struct pci_bus *, e.g.:
> 
>   resource_size_t pcibios_window_alignment(struct pci_bus *bus, struct
> resource *window)

Hmm..'struct resource *window' may not yet know which aperature it is
allocated from. Will it? We are still in the sizing process, the allocation will
be done much later.

RP
