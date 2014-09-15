Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16D091A001E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 12:49:02 +1000 (EST)
Message-ID: <1410749341.24738.4.camel@concordia>
Subject: Re: [PATCH V2] powerpc/eeh: Fix kernel crash when passing through VF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 12:49:01 +1000
In-Reply-To: <20140912050518.GA17933@shangw>
References: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1410494123.17540.2.camel@concordia> <20140912050518.GA17933@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-12 at 15:05 +1000, Gavin Shan wrote:
> On Fri, Sep 12, 2014 at 01:55:23PM +1000, Michael Ellerman wrote:
> >On Thu, 2014-09-11 at 11:42 +0800, Wei Yang wrote:
> >> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> >> index 4a45ba8..403445e 100644
> >> --- a/arch/powerpc/kernel/eeh.c
> >> +++ b/arch/powerpc/kernel/eeh.c
> >> @@ -625,7 +625,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
> >>  int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
> >>  {
> >>  	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
> >> -	struct eeh_pe *pe = edev->pe;
> >> +	struct eeh_pe *pe = edev ? edev->pe : NULL;
> >>  
> >>  	if (!pe) {
> >>  		pr_err("%s: No PE found on PCI device %s\n",
> >
> >
> >We seem to do this or something similar in a few places. Is it worth having a
> >pci_dev_to_eeh_pe() inline?
> >
> 
> Yes, maybe we just need a eeh_dev_to_pe() because converting
> pci_dev to eeh_dev is already coverred by pci_dev_to_eeh_dev().
> 
> With eeh_dev_to_pe(), it looks like this:
> 
> struct pci_dev *pdev;
> struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> struct eeh_pe *pe = eeh_dev_to_pe(edev);
> 
> Or another case:
> 
> struct device_node *dn;
> struct eeh_dev *edev = of_node_to_eeh_dev(dn);
> struct eeh_pe *pe = eeh_dev_to_pe(edev);

Yeah I guess.

I saw a few places where we go from pci_dev to eeh_pe via a eeh_dev but then
don't use the eeh_dev at all. So for those it would make sense to have one
macro that does the full conversion from pci_dev to eeh_pe.

But if you think that's not very common then yeah a macro to do each stage is
fine.

cheers
