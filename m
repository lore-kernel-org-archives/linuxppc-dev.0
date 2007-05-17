Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BECF8DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 14:59:26 +1000 (EST)
Subject: Re: eeh bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <1179377184.32247.274.camel@localhost.localdomain>
References: <1179377184.32247.274.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 May 2007 14:59:06 +1000
Message-Id: <1179377946.32247.281.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-17 at 14:46 +1000, Benjamin Herrenschmidt wrote:
> Hi Linas !
> 
> While debugging some other issues, I had a couple of oopses caused by
> what looks like a bug in EEH:
> 
> When an RTAS PCI config space call returns all f's, we do an eeh error
> check by calling eeh_dn_check_failure(pdn->node, NULL);
> 
> The problem is that second argument... NULL for the pci_dev *. It looks
> like the EEH code will try to printk pci_name of that and later on
> dereference it within eehd, thus causing an oops.

Ok, so I just added a

	if (dev == NULL)
		dev = pdn->pcidev;

To eeh_dn_check_failure(), and that fixes one of the NULL (name
printing), but I get another one a bit later, in pci_find_capability
called from eeh_slot_error_detail called from handle_eeh_events.
(Probably in gather_pci_data).

One thing that looks suspicions is that just before that I see:

EEH: of node=/pci/@8000000200000d3/pci@2,4

Which is not a device but the bridge above it... not sure why, maybe we
have a NULL pdn->pcidev at that level.. we should probably not sure
pci_find_capability in that code anyway and implent our own version
using RTAS in case we don't have a pci_dev around, don't you think ?

Cheers,
Ben.
