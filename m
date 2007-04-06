Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8AE0DDE40
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Apr 2007 04:53:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l36IrdwM001946
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 14:53:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l36Iqtnj277658
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 14:52:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l36Iqs5A022524
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 14:52:55 -0400
Date: Fri, 6 Apr 2007 13:52:54 -0500
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Add powerpc PCI-E reset API implementation
Message-ID: <20070406185254.GE4922@austin.ibm.com>
References: <11758684222896-patch-mail.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11758684222896-patch-mail.ibm.com>
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

On Fri, Apr 06, 2007 at 09:07:04AM -0500, Brian King wrote:
> 
> This patch requires a generic PCI layer patch, which is in Greg's
> queue for 2.6.22, 

I managed to miss seeing that patch, even though I thought I was 
subscribed to the mailing list. Was there any discusion of it?

> +int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)

I think you'll need an EXPORT_SMBOL_GPL if you plan to call this from
a module.

> +	switch (state) {
> +	case pci_reset_normal:
> +		rtas_pci_slot_reset(pdn, 0);

I find this naming confusing. rtas_pci_slot_reset(pdn, 0),
for PCI ad PCI-X means "deassert the reset"; it does not 
mean "do a normal reset".

> +		break;
> +	case pci_reset_pcie_hot_reset:
> +		rtas_pci_slot_reset(pdn, 1);
> +		break;
> +	case pci_reset_pcie_warm_reset:
> +		rtas_pci_slot_reset(pdn, 3);

For PCI and PCI-X, rtas_pci_slot_reset(pdn, 1) means "hold the
reset line high, until such time that its de-asserted."

> +	return 0;

I notice that you do no error checking. I recently wrapped 
rtas_set_slot_reset() to wait for slot status to settle down 
before reporting success or failure of the reset. 

Although the PAPR maps 1 to hot reset, and 3 to #PERST, I always
had the impression that they managed to reverse meaing of these two
(i.e. its a poor match to what the PCI-E spec says), and I never 
understood why. I am still thinking that the correct reset seqeunce
on linux is to try "3" first, if its supported, and then try a "1".
I've not taken steps to do this, though.

I could wrap rtas_set_slot_reset()  to try a "3" first, for 
PCI-E slots, and do 1 "1" only if that fails. Would this solve 
the problem that you are having?

--linas
