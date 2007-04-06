Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 287AEDDEB8
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Apr 2007 05:19:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l36JJ6ch002016
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 15:19:06 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l36JJ6Md305592
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 15:19:06 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l36JJ6wL031069
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 15:19:06 -0400
Message-ID: <46169D28.6010507@linux.vnet.ibm.com>
Date: Fri, 06 Apr 2007 14:19:04 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Add powerpc PCI-E reset API implementation
References: <11758684222896-patch-mail.ibm.com>
	<20070406185254.GE4922@austin.ibm.com>
In-Reply-To: <20070406185254.GE4922@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	paulus@samba.org, thlin@linux.vnet.ibm.com
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Fri, Apr 06, 2007 at 09:07:04AM -0500, Brian King wrote:
>> This patch requires a generic PCI layer patch, which is in Greg's
>> queue for 2.6.22, 
> 
> I managed to miss seeing that patch, even though I thought I was 
> subscribed to the mailing list. Was there any discusion of it?

http://marc.info/?t=117035109100003&r=1&w=2

>> +int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
> 
> I think you'll need an EXPORT_SMBOL_GPL if you plan to call this from
> a module.

It is only to be called from the generic PCI layer. Anyone else should be
calling pci_set_pcie_reset_state, which is the PCI layer wrapper for it.

>> +	switch (state) {
>> +	case pci_reset_normal:
>> +		rtas_pci_slot_reset(pdn, 0);
> 
> I find this naming confusing. rtas_pci_slot_reset(pdn, 0),
> for PCI ad PCI-X means "deassert the reset"; it does not 
> mean "do a normal reset".

Normal refers to the reset state of the slot, not the type of reset.
I'm happy to change it if that would be less confusing.


>> +		break;
>> +	case pci_reset_pcie_hot_reset:
>> +		rtas_pci_slot_reset(pdn, 1);
>> +		break;
>> +	case pci_reset_pcie_warm_reset:
>> +		rtas_pci_slot_reset(pdn, 3);
> 
> For PCI and PCI-X, rtas_pci_slot_reset(pdn, 1) means "hold the
> reset line high, until such time that its de-asserted."

Correct. This is a PCI-E only API. I don't think we want to be
supporting an API that allows asserting reset on a potentially
shared PCI bus.

>> +	return 0;
> 
> I notice that you do no error checking. I recently wrapped 
> rtas_set_slot_reset() to wait for slot status to settle down 
> before reporting success or failure of the reset. 

I didn't do any error checking because there was no error checking
in __rtas_set_slot_reset either. I can add error checking if needed,
but I'm not sure I would do anything with it in ipr. 

> Although the PAPR maps 1 to hot reset, and 3 to #PERST, I always
> had the impression that they managed to reverse meaing of these two
> (i.e. its a poor match to what the PCI-E spec says), and I never 
> understood why. I am still thinking that the correct reset seqeunce
> on linux is to try "3" first, if its supported, and then try a "1".
> I've not taken steps to do this, though.

Possibly. Its not clear to me how you can tell if a 3 is supported, however.
You can check if the platform supports it, but there is no guarantee
that the adapter itself supports it. It may ignore it, or it may do
bad things.

> I could wrap rtas_set_slot_reset()  to try a "3" first, for 
> PCI-E slots, and do 1 "1" only if that fails. Would this solve 
> the problem that you are having?

rtas_set_slot_reset can sleep, which means the amount of code and
complexity in the ipr driver to use this API would grow quite a bit.

Additionally, as I already mentioned, how would you know that 3 failed?
The device may respond just fine to config cycles after a failed "3", but
still not actually be in a healthy state. As a corollary, with this particular
ipr adapter a hot reset appears to work from a pci config access perspective,
but the adapter firmware ends up in a bad state since the adapter's processor
does not get reset. Its not clear would don't have adapters that have issues
in the other direction.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
