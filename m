Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFA0F2C0319
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 17:21:21 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 17:14:12 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 66A142CE8044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 17:21:16 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J76Y3Z1245636
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 17:06:34 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J7LFTm031515
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 17:21:15 +1000
Message-ID: <51C15BE3.70906@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 15:21:07 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/31] powerpc/eeh: Trace PCI bus from PE
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371544435-4943-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-6-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/6/18 16:33, Gavin Shan 写道:
> There're several types of PEs can be supported for now: PHB, Bus
> and Device dependent PE. For PCI bus dependent PE, tracing the
> corresponding PCI bus from PE (struct eeh_pe) would make the code
> more efficient. The patch also enables the retrieval of PCI bus based
> on the PCI bus dependent PE.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/eeh.h |    1 +
>   arch/powerpc/kernel/eeh_pe.c   |   22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index acdfcaa..f3b49d6 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -59,6 +59,7 @@ struct eeh_pe {
>   	int config_addr;		/* Traditional PCI address	*/
>   	int addr;			/* PE configuration address	*/
>   	struct pci_controller *phb;	/* Associated PHB		*/
> +	struct pci_bus *bus;		/* Top PCI bus for bus PE	*/
>   	int check_count;		/* Times of ignored error	*/
>   	int freeze_count;		/* Times of froze up		*/
>   	int false_positives;		/* Times of reported #ff's	*/
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 3d2dcf5..5bd1637 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -304,6 +304,7 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>   int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   {
>   	struct eeh_pe *pe, *parent;
> +	struct eeh_dev *first_edev;
>
>   	eeh_lock();
>
> @@ -326,6 +327,21 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   		pe->type = EEH_PE_BUS;
>   		edev->pe = pe;
>
> +		/*
> +		 * For PCI bus sensitive PE, we can reset the parent
> +		 * bridge in order for hot-reset. However, the PCI
> +		 * devices including the associated EEH devices might
> +		 * be removed when EEH core is doing recovery. So that
> +		 * won't safe to retrieve the bridge through downstream
> +		 * EEH device. We have to trace the parent PCI bus, then
> +		 * the parent bridge explicitly.
> +		 */
> +		if (eeh_probe_mode_dev() && !pe->bus) {
> +			first_edev = list_first_entry(&pe->edevs,
> +						      struct eeh_dev, list);
> +			pe->bus = eeh_dev_to_pci_dev(first_edev)->bus;
> +		}
Hi Gavin

I have qestion, can we keep pe->bus for a device pe ? the value is the 
bus which edev belongs to.

so that we can make the code more efficient for device pe.

I have no idea of whether this will cause side effect

Thanks
Mike
> +
>   		/* Put the edev to PE */
>   		list_add_tail(&edev->list, &pe->edevs);
>   		eeh_unlock();
> @@ -641,12 +657,18 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
>   		bus = pe->phb->bus;
>   	} else if (pe->type & EEH_PE_BUS ||
>   		   pe->type & EEH_PE_DEVICE) {
> +		if (pe->bus) {
> +			bus = pe->bus;
> +			goto out;
> +		}
> +
>   		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
>   		pdev = eeh_dev_to_pci_dev(edev);
>   		if (pdev)
>   			bus = pdev->bus;
>   	}
>
> +out:
>   	eeh_unlock();
>
>   	return bus;
