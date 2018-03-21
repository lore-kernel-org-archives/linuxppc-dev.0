Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dPD5t51zF1h4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:18:24 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id k135-v6so5317664ite.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:18:24 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id
 c1-v6sm2177081iti.20.2018.03.20.22.18.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:18:22 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] powerpc/eeh: Rename frozen_bus to bus in
 eeh_handle_normal_event()
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <a8d5f7792b761721852b68363c68519c6c8b62ff.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1bc55b96-c338-81aa-4a30-943cab1ab3c9@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:18:19 +1100
MIME-Version: 1.0
In-Reply-To: <a8d5f7792b761721852b68363c68519c6c8b62ff.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:47 pm, Sam Bobroff wrote:
> The name "frozen_bus" is misleading: it's not necessarily frozen, it's
> just the PE's PCI bus.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/kernel/eeh_driver.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 04a5d9db5499..cb584d72b0a5 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -754,14 +754,14 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>   */
>  void eeh_handle_normal_event(struct eeh_pe *pe)
>  {
> -	struct pci_bus *frozen_bus;
> +	struct pci_bus *bus;
>  	struct eeh_dev *edev, *tmp;
>  	int rc = 0;
>  	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
>  	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
>  
> -	frozen_bus = eeh_pe_bus_get(pe);
> -	if (!frozen_bus) {
> +	bus = eeh_pe_bus_get(pe);
> +	if (!bus) {
>  		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
>  			__func__, pe->phb->global_number, pe->addr);
>  		return;
> @@ -820,7 +820,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
>  	 */
>  	if (result == PCI_ERS_RESULT_NONE) {
>  		pr_info("EEH: Reset with hotplug activity\n");
> -		rc = eeh_reset_device(pe, frozen_bus, NULL);
> +		rc = eeh_reset_device(pe, bus, NULL);
>  		if (rc) {
>  			pr_warn("%s: Unable to reset, err=%d\n",
>  				__func__, rc);
> @@ -938,7 +938,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
>  		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>  
>  		pci_lock_rescan_remove();
> -		pci_hp_remove_devices(frozen_bus);
> +		pci_hp_remove_devices(bus);
>  		pci_unlock_rescan_remove();
>  		/* The passed PE should no longer be used */
>  		return;
> 


-- 
Alexey
