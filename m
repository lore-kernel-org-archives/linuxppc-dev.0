Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 04AC82C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:14:31 +1000 (EST)
Message-ID: <1370060064.3766.2.camel@pasglop>
Subject: Re: [PATCH 03/23] powerpc/eeh: Make eeh_phb_pe_get() public
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:14:24 +1000
In-Reply-To: <1369902245-5886-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-4-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
> While processing EEH event interrupt from P7IOC, we need function
> to retrieve the PE according to the indicated PCI host controller
> (struct pci_controller). The patch makes function eeh_phb_pe_get()
> public so that other source files can call it for that purpose.

Just to make things clear to me... You always have the concept of a
"controller PE" ? What does it actually correspond to in terms of HW
setting ? Bus 0 ? Bus 0..255 ? IE, A "catch all" fallback ?

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h          |    1 +
>  arch/powerpc/platforms/pseries/eeh_pe.c |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index eeaeab6..4b48178 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -185,6 +185,7 @@ static inline void eeh_unlock(void)
>  typedef void *(*eeh_traverse_func)(void *data, void *flag);
>  typedef void *(*eeh_pci_traverse_func)(struct pci_dev *dev, void *flag);
>  int eeh_phb_pe_create(struct pci_controller *phb);
> +struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
>  void *eeh_pe_dev_traverse(struct eeh_pe *root,
> diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
> index fe43d1a..6e3eb43 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pe.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pe.c
> @@ -95,7 +95,7 @@ int eeh_phb_pe_create(struct pci_controller *phb)
>   * hierarchy tree is composed of PHB PEs. The function is used
>   * to retrieve the corresponding PHB PE according to the given PHB.
>   */
> -static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
> +struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
>  {
>  	struct eeh_pe *pe;
>  
