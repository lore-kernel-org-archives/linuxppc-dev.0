Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8300DDF53
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 10:28:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0NNTLGt013784
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 18:29:21 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0NNSiNS277824
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 18:28:44 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0NNSinD014901
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 18:28:44 -0500
Message-ID: <45B69A2A.9060207@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2007 17:28:42 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Export PCI slot reset API
References: <11686349711123-patch-mail.ibm.com>
In-Reply-To: <11686349711123-patch-mail.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, linas@boardhead.austin.ibm.com, linuxppc-dev@ozlabs.org
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any comments on this?

Thanks,

Brian

Brian King wrote:
> Adds two new APIs to assert/deassert PCI reset to a given
> device. This is needed for an ipr PCI-E adapter which does not
> properly implement either BIST nor PCI-E hot reset, requiring
> a PCI-E warm reset, which is what this implements.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c |   41 +++++++++++++++++
>  linux-2.6-bjking1/include/asm-powerpc/ppc-pci.h        |    3 +
>  2 files changed, 44 insertions(+)
> 
> diff -puN arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api2 arch/powerpc/platforms/pseries/eeh.c
> --- linux-2.6/arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api2	2007-01-11 15:52:57.000000000 -0600
> +++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c	2007-01-11 15:52:57.000000000 -0600
> @@ -591,6 +591,47 @@ static void __rtas_set_slot_reset(struct
>  	msleep (PCI_BUS_SETTLE_TIME_MSEC);
>  }
> 
> +/**
> + * pci_set_slot_reset - Assert PCI reset to the PCI slot
> + * @dev:	pci device struct
> + *
> + * After asserting PCI reset, the caller should wait for
> + * 100 milliseconds or longer.
> + *
> + * Return value:
> + * 	0 if success
> + **/
> +int pci_set_slot_reset(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +	struct pci_dn *pdn = PCI_DN(dn);
> +
> +	rtas_pci_slot_reset(pdn, 3);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_set_slot_reset);
> +
> +/**
> + * pci_clear_slot_reset - Clear PCI reset to the PCI slot
> + * @dev:	pci device struct
> + *
> + * After clearing PCI reset, the caller should wait 1.8 seconds
> + * or longer for the bus to stabilize and the device to come
> + * ready.
> + *
> + * Return value:
> + * 	0 if success
> + **/
> +int pci_clear_slot_reset(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +	struct pci_dn *pdn = PCI_DN(dn);
> +
> +	rtas_pci_slot_reset (pdn, 0);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_clear_slot_reset);
> +
>  int rtas_set_slot_reset(struct pci_dn *pdn)
>  {
>  	int i, rc;
> diff -puN include/asm-powerpc/ppc-pci.h~powerpc_slot_reset_api2 include/asm-powerpc/ppc-pci.h
> --- linux-2.6/include/asm-powerpc/ppc-pci.h~powerpc_slot_reset_api2	2007-01-11 15:52:57.000000000 -0600
> +++ linux-2.6-bjking1/include/asm-powerpc/ppc-pci.h	2007-01-11 15:52:57.000000000 -0600
> @@ -124,6 +124,9 @@ void eeh_clear_slot (struct device_node
>  /* Find the associated "Partiationable Endpoint" PE */
>  struct device_node * find_device_pe(struct device_node *dn);
> 
> +int pci_set_slot_reset(struct pci_dev *dev);
> +int pci_clear_slot_reset(struct pci_dev *dev);
> +
>  #endif
> 
>  #endif /* __KERNEL__ */
> _


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
