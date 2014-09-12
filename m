Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8C051A0024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 13:55:23 +1000 (EST)
Message-ID: <1410494123.17540.2.camel@concordia>
Subject: Re: [PATCH V2] powerpc/eeh: Fix kernel crash when passing through VF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Fri, 12 Sep 2014 13:55:23 +1000
In-Reply-To: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-11 at 11:42 +0800, Wei Yang wrote:
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 4a45ba8..403445e 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -625,7 +625,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
>  int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
>  {
>  	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
> -	struct eeh_pe *pe = edev->pe;
> +	struct eeh_pe *pe = edev ? edev->pe : NULL;
>  
>  	if (!pe) {
>  		pr_err("%s: No PE found on PCI device %s\n",


We seem to do this or something similar in a few places. Is it worth having a
pci_dev_to_eeh_pe() inline?

cheers
