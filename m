Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49E1D1A0C39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 16:36:01 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so63155966pas.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 22:35:58 -0700 (PDT)
Subject: Re: [PATCH V10 12/12] powerpc/eeh: Handle hot removed VF when PF is
 EEH aware
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-13-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <563301BA.7050207@ozlabs.ru>
Date: Fri, 30 Oct 2015 16:35:54 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-13-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/26/2015 02:16 PM, Wei Yang wrote:
> When PF is EEH aware while VFs are not, VFs will be removed during EEH
> recovery. This is not supported in current code, while will leads to the VF
> lost.
>
> This patch fixes this by adding VFs back. VFs should be added back after PF
> get recovered properly.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

btw please remove my "sob" from this patchset (here and 11/12 at least) as 
I did not "sob" the upstream versions of these and I did not post them and 
there is no public tree of mine with these patches. When I agree that the 
patches are good to go, it will be "reviewed-by" or "acked-by".


> ---
>   arch/powerpc/include/asm/eeh.h   |  6 ++++++
>   arch/powerpc/kernel/eeh_dev.c    |  1 +
>   arch/powerpc/kernel/eeh_driver.c | 30 +++++++++++++++++++++++-------
>   3 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index ea1f13c4..c529a23 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -127,6 +127,11 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
>   #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
>   #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
>
> +struct eeh_rmv_data {
> +	struct list_head edev_list;
> +	int removed;
> +};
> +
>   struct eeh_dev {
>   	int mode;			/* EEH mode			*/
>   	int class_code;			/* Class code of the device	*/
> @@ -139,6 +144,7 @@ struct eeh_dev {
>   	int af_cap;			/* Saved AF capability		*/
>   	struct eeh_pe *pe;		/* Associated PE		*/
>   	struct list_head list;		/* Form link list in the PE	*/
> +	struct list_head rmv_list;	/* Record the removed edev 	*/
>   	struct pci_controller *phb;	/* Associated PHB		*/
>   	struct pci_dn *pdn;		/* Associated PCI device node	*/
>   	struct pci_dev *pdev;		/* Associated PCI device	*/
> diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
> index aabba94..7815095 100644
> --- a/arch/powerpc/kernel/eeh_dev.c
> +++ b/arch/powerpc/kernel/eeh_dev.c
> @@ -67,6 +67,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
>   	edev->pdn = pdn;
>   	edev->phb = phb;
>   	INIT_LIST_HEAD(&edev->list);
> +	INIT_LIST_HEAD(&edev->rmv_list);
>
>   	return NULL;
>   }
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 99868e2..f2406b4 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -420,7 +420,8 @@ static void *eeh_rmv_device(void *data, void *userdata)
>   	struct pci_driver *driver;
>   	struct eeh_dev *edev = (struct eeh_dev *)data;
>   	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
> -	int *removed = (int *)userdata;
> +	struct eeh_rmv_data *rmv_data = (struct eeh_rmv_data *)userdata;
> +	int *removed = rmv_data ? &rmv_data->removed : NULL;


You just touched @userdata/@removed in [10/12] and now you are touching it 
again.

It feels like this patch is better to be merged into [10/12], this will 
reduce the noise about the userdata pointer changes passed into 
eeh_pe_dev_traverse() and make more sense as "powerpc/eeh: Support error 
recovery for VF PE" without adding VFs back is pretty useless.




>   	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>
>   	/*
> @@ -467,6 +468,9 @@ static void *eeh_rmv_device(void *data, void *userdata)
>   		 * required to plug the VF successfully.
>   		 */
>   		pdn->pe_number = IODA_INVALID_PE;
> +
> +		if (rmv_data)
> +			list_add(&edev->rmv_list, &rmv_data->edev_list);
>   	} else {
>   		pci_lock_rescan_remove();
>   		pci_stop_and_remove_bus_device(dev);
> @@ -585,11 +589,12 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>    * During the reset, udev might be invoked because those affected
>    * PCI devices will be removed and then added.
>    */
> -static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
> +static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
> +				struct eeh_rmv_data *rmv_data)
>   {
>   	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
>   	struct timeval tstamp;
> -	int cnt, rc, removed = 0;
> +	int cnt, rc;
>   	struct eeh_dev *edev;
>
>   	/* pcibios will clear the counter; save the value */
> @@ -612,7 +617,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>   			pci_unlock_rescan_remove();
>   		}
>   	} else if (frozen_bus)
> -		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
> +		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
>
>   	/*
>   	 * Reset the pci controller. (Asserts RST#; resets config space).
> @@ -659,7 +664,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>   			eeh_add_virt_device(edev, NULL);
>   		else
>   			pcibios_add_pci_devices(bus);
> -	} else if (frozen_bus && removed) {
> +	} else if (frozen_bus && rmv_data->removed) {
>   		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
>   		ssleep(5);
>
> @@ -687,8 +692,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>   static void eeh_handle_normal_event(struct eeh_pe *pe)
>   {
>   	struct pci_bus *frozen_bus;
> +	struct eeh_dev *edev, *tmp;
>   	int rc = 0;
>   	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
> +	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
>
>   	frozen_bus = eeh_pe_bus_get(pe);
>   	if (!frozen_bus) {
> @@ -735,7 +742,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>   	 */
>   	if (result == PCI_ERS_RESULT_NONE) {
>   		pr_info("EEH: Reset with hotplug activity\n");
> -		rc = eeh_reset_device(pe, frozen_bus);
> +		rc = eeh_reset_device(pe, frozen_bus, NULL);
>   		if (rc) {
>   			pr_warn("%s: Unable to reset, err=%d\n",
>   				__func__, rc);
> @@ -787,7 +794,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>   	/* If any device called out for a reset, then reset the slot */
>   	if (result == PCI_ERS_RESULT_NEED_RESET) {
>   		pr_info("EEH: Reset without hotplug activity\n");
> -		rc = eeh_reset_device(pe, NULL);
> +		rc = eeh_reset_device(pe, NULL, &rmv_data);
>   		if (rc) {
>   			pr_warn("%s: Cannot reset, err=%d\n",
>   				__func__, rc);
> @@ -807,6 +814,15 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>   		goto hard_fail;
>   	}
>
> +	/*
> +	 * For those hot removed VFs, we should add back them after PF get
> +	 * recovered properly.
> +	 */
> +	list_for_each_entry_safe(edev, tmp, &rmv_data.edev_list, rmv_list) {
> +		eeh_add_virt_device(edev, NULL);
> +		list_del(&edev->rmv_list);
> +	}
> +
>   	/* Tell all device drivers that they can resume operations */
>   	pr_info("EEH: Notify device driver to resume\n");
>   	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
>


-- 
Alexey
