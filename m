Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82C98DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:44:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4HGifdq012570
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:44:41 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4HGifj7487902
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:44:41 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4HGifwI028301
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:44:41 -0400
Date: Thu, 17 May 2007 11:44:38 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: eeh bug
Message-ID: <20070517164438.GD4325@austin.ibm.com>
References: <1179377184.32247.274.camel@localhost.localdomain>
	<1179377946.32247.281.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179377946.32247.281.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 17, 2007 at 02:59:06PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2007-05-17 at 14:46 +1000, Benjamin Herrenschmidt wrote:
> > 
> > When an RTAS PCI config space call returns all f's, we do an eeh error
> > check by calling eeh_dn_check_failure(pdn->node, NULL);
> > 
> > The problem is that second argument... NULL for the pci_dev *. It looks
> > like the EEH code will try to printk pci_name of that and later on
> > dereference it within eehd, thus causing an oops.
> 
> Ok, so I just added a
> 
> 	if (dev == NULL)
> 		dev = pdn->pcidev;
> 
> To eeh_dn_check_failure(), and that fixes one of the NULL (name
> printing), but I get another one a bit later, in pci_find_capability
> called from eeh_slot_error_detail called from handle_eeh_events.
> (Probably in gather_pci_data).

OK, clearly I have been sloppy. The initial eeh design used pci_dev
for everything; and as time went on, I realized that the device node
made a better fit for what needed to be manipulated. So the code
migrated in that direction, but not unambiguously; it tried to
keep allegience to both ways of identifying a slot.

> One thing that looks suspicions is that just before that I see:
> 
> EEH: of node=/pci/@8000000200000d3/pci@2,4
> 
> Which is not a device but the bridge above it... 

That's the "partition endpoint", which is what the firmware wants. 
There's some ambiguity, as older systems with EADS and newer
direct-attached P5IOC slots have different relationships between
the "partition endpoint", the device, the slot, the bridge and 
PHB; which of these are equivalent and which are subordinate
can be confusing.

> we should probably not sure
> pci_find_capability in that code anyway and implent our own version
> using RTAS in case we don't have a pci_dev around, don't you think ?

I'll take a look. Usually, there's no pci_dev only when its a slot
with no device plugged into it; these can still receive EEH errors
during config space i/o to the bridge (I presume that the justification
is when aluminum scrap shorts out a pci connector or something like
that). In all other cases, there's a pci_dev, which is why the 
bug slipped by.

--linas

> 
