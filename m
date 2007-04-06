Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85689DDEB9
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Apr 2007 06:30:37 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l36KVHMp020284
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 16:31:17 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l36KUXQ8277292
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 16:30:33 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l36KUW2E023285
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 16:30:33 -0400
Date: Fri, 6 Apr 2007 15:30:32 -0500
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Add powerpc PCI-E reset API implementation
Message-ID: <20070406203032.GF4922@austin.ibm.com>
References: <20070406185254.GE4922@austin.ibm.com>
	<46169D28.6010507@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46169D28.6010507@linux.vnet.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	paulus@samba.org, thlin@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 06, 2007 at 02:19:04PM -0500, Brian King wrote:
> Linas Vepstas wrote:
> > On Fri, Apr 06, 2007 at 09:07:04AM -0500, Brian King wrote:
> 
> >> +	switch (state) {
> >> +	case pci_reset_normal:
> >> +		rtas_pci_slot_reset(pdn, 0);
> > 
> > I find this naming confusing. rtas_pci_slot_reset(pdn, 0),
> > for PCI ad PCI-X means "deassert the reset"; it does not 
> > mean "do a normal reset".
> 
> Normal refers to the reset state of the slot, not the type of reset.
> I'm happy to change it if that would be less confusing.

Hmm. Well, then, can I get you to change it to "pcie_deassert_reset"?

> >> +	case pci_reset_pcie_hot_reset:

and while we're at it, shorten this to "pcie_hot_reset"

> >> +	case pci_reset_pcie_warm_reset:

"pcie_warm_reset"

> Correct. This is a PCI-E only API. 

which is why I suggest the shortened names.

> I don't think we want to be
> supporting an API that allows asserting reset on a potentially
> shared PCI bus.

Actually, we very nearly do so already.  The "pci error recovery" API 
does define a way of coordinating a pending reset to be delivered 
to multiple PCI functions or multiple PCI cards.  What's missing 
is an external, public API for triggering the thing; right now, 
its only triggered by the hardware and handled by static, private 
routines.

> >> +	return 0;
> > 
> > I notice that you do no error checking. I recently wrapped 
> > rtas_set_slot_reset() to wait for slot status to settle down 
> > before reporting success or failure of the reset. 
> 
> I didn't do any error checking because there was no error checking
> in __rtas_set_slot_reset either. 

Yeah, its a new function: "eeh_wait_for_slot_status", its public,
but cleary very arch dependent. Just FYI, I don't think you'd want
to use it.

> > Although the PAPR maps 1 to hot reset, and 3 to #PERST, I always
> > had the impression that they managed to reverse meaing of these two
[...]
> The device may respond just fine to config cycles after a failed "3", but
> still not actually be in a healthy state. As a corollary, with this particular
> ipr adapter a hot reset appears to work from a pci config access perspective,
> but the adapter firmware ends up in a bad state since the adapter's processor
> does not get reset. Its not clear would don't have adapters that have issues
> in the other direction.

Yes... we had this conversation once before, didn't we?  The ugliness of
it all made me scurry away to some other task. 

--linas
