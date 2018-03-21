Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dS71PBszF1jg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:20:55 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id r18so5142593ioa.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:20:54 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id p65sm2121444iop.63.2018.03.20.22.20.51
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:20:52 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] powerpc/eeh: Add eeh_state_active() helper
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <c7cc2334ac3a7c88cc68b45337de890bcdcc80f7.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a3f9ccc1-270f-597e-4121-0833ea16b2aa@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:20:49 +1100
MIME-Version: 1.0
In-Reply-To: <c7cc2334ac3a7c88cc68b45337de890bcdcc80f7.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:49 pm, Sam Bobroff wrote:
> Checking for a "fully active" device state requires testing two flag
> bits, which is open coded in several places, so add a function to do
> it.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/include/asm/eeh.h               |  6 ++++++
>  arch/powerpc/kernel/eeh.c                    | 19 ++++++-------------
>  arch/powerpc/platforms/powernv/eeh-powernv.c |  9 ++-------
>  3 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index fd37cc101f4f..c2266ca61853 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -256,6 +256,12 @@ static inline void eeh_serialize_unlock(unsigned long flags)
>  	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
>  }
>  
> +static inline bool eeh_state_active(int state)
> +{
> +	return (state & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
> +	== (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
> +}
> +
>  typedef void *(*eeh_traverse_func)(void *data, void *flag);
>  void eeh_set_pe_aux_size(int size);
>  int eeh_phb_pe_create(struct pci_controller *phb);
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 2b9df0040d6b..bc640e4c5ca5 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -394,9 +394,7 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
>  	/* Check PHB state */
>  	ret = eeh_ops->get_state(phb_pe, NULL);
>  	if ((ret < 0) ||
> -	    (ret == EEH_STATE_NOT_SUPPORT) ||
> -	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
> -	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
> +	    (ret == EEH_STATE_NOT_SUPPORT) || eeh_state_active(ret)) {
>  		ret = 0;
>  		goto out;
>  	}
> @@ -433,7 +431,6 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
>  int eeh_dev_check_failure(struct eeh_dev *edev)
>  {
>  	int ret;
> -	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>  	unsigned long flags;
>  	struct device_node *dn;
>  	struct pci_dev *dev;
> @@ -525,8 +522,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>  	 * state, PE is in good state.
>  	 */
>  	if ((ret < 0) ||
> -	    (ret == EEH_STATE_NOT_SUPPORT) ||
> -	    ((ret & active_flags) == active_flags)) {
> +	    (ret == EEH_STATE_NOT_SUPPORT) || eeh_state_active(ret)) {
>  		eeh_stats.false_positives++;
>  		pe->false_positives++;
>  		rc = 0;
> @@ -546,8 +542,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>  
>  		/* Frozen parent PE ? */
>  		ret = eeh_ops->get_state(parent_pe, NULL);
> -		if (ret > 0 &&
> -		    (ret & active_flags) != active_flags)
> +		if (ret > 0 && !eeh_state_active(ret))
>  			pe = parent_pe;
>  
>  		/* Next parent level */
> @@ -888,7 +883,6 @@ static void *eeh_set_dev_freset(void *data, void *flag)
>   */
>  int eeh_pe_reset_full(struct eeh_pe *pe)
>  {
> -	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>  	int reset_state = (EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
>  	int type = EEH_RESET_HOT;
>  	unsigned int freset = 0;
> @@ -919,7 +913,7 @@ int eeh_pe_reset_full(struct eeh_pe *pe)
>  
>  		/* Wait until the PE is in a functioning state */
>  		state = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
> -		if ((state & active_flags) == active_flags)
> +		if (eeh_state_active(state))
>  			break;
>  
>  		if (state < 0) {
> @@ -1352,16 +1346,15 @@ static int eeh_pe_change_owner(struct eeh_pe *pe)
>  	struct eeh_dev *edev, *tmp;
>  	struct pci_dev *pdev;
>  	struct pci_device_id *id;
> -	int flags, ret;
> +	int ret;
>  
>  	/* Check PE state */
> -	flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>  	ret = eeh_ops->get_state(pe, NULL);
>  	if (ret < 0 || ret == EEH_STATE_NOT_SUPPORT)
>  		return 0;
>  
>  	/* Unfrozen PE, nothing to do */
> -	if ((ret & flags) == flags)
> +	if (eeh_state_active(ret))
>  		return 0;
>  
>  	/* Frozen PE, check if it needs PE level reset */
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 33c86c1a1720..ddfc3544d285 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1425,11 +1425,8 @@ static int pnv_eeh_get_pe(struct pci_controller *hose,
>  	dev_pe = dev_pe->parent;
>  	while (dev_pe && !(dev_pe->type & EEH_PE_PHB)) {
>  		int ret;
> -		int active_flags = (EEH_STATE_MMIO_ACTIVE |
> -				    EEH_STATE_DMA_ACTIVE);
> -
>  		ret = eeh_ops->get_state(dev_pe, NULL);
> -		if (ret <= 0 || (ret & active_flags) == active_flags) {
> +		if (ret <= 0 || eeh_state_active(ret)) {
>  			dev_pe = dev_pe->parent;
>  			continue;
>  		}
> @@ -1463,7 +1460,6 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>  	struct eeh_pe *phb_pe, *parent_pe;
>  	__be64 frozen_pe_no;
>  	__be16 err_type, severity;
> -	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>  	long rc;
>  	int state, ret = EEH_NEXT_ERR_NONE;
>  
> @@ -1626,8 +1622,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>  
>  				/* Frozen parent PE ? */
>  				state = eeh_ops->get_state(parent_pe, NULL);
> -				if (state > 0 &&
> -				    (state & active_flags) != active_flags)
> +				if (state > 0 && !eeh_state_active(state))
>  					*pe = parent_pe;
>  
>  				/* Next parent level */
> 


-- 
Alexey
