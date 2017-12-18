Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0TSX3K7fzDsFn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 16:03:07 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id h12so8444700iof.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 21:03:07 -0800 (PST)
Subject: Re: [PATCH v1 4/7] powerpc/kernel Add EEH operations to notify resume
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-5-bryantly@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b2d30341-1945-0331-fb36-d441efc89109@ozlabs.ru>
Date: Mon, 18 Dec 2017 16:02:56 +1100
MIME-Version: 1.0
In-Reply-To: <20171213153242.98015-5-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/12/17 02:32, Bryant G. Ly wrote:
> When pseries SR-IOV is enabled and after a PF driver
> has resumed from EEH, platform has to be notified
> of the event so the child VFs can be allowed to
> resume their normal recovery path.
> 
> This patch makes the EEH operation allow unfreeze
> platform dependent code and adds the call to
> pseries EEH code.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |   1 +
>  arch/powerpc/kernel/eeh_driver.c             |   4 ++
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   3 +-
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 100 ++++++++++++++++++++++++++-
>  4 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 5161c37dd039..12d52a0cd447 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -214,6 +214,7 @@ struct eeh_ops {
>  	int (*write_config)(struct pci_dn *pdn, int where, int size, u32 val);
>  	int (*next_error)(struct eeh_pe **pe);
>  	int (*restore_config)(struct pci_dn *pdn);
> +	int (*notify_resume)(struct pci_dn *pdn);
>  };
>  
>  extern int eeh_subsystem_flags;
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index c61bf770282b..dbda0cda559b 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -361,6 +361,7 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	bool was_in_error;
>  	struct pci_driver *driver;
>  	char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};
> +	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> @@ -384,6 +385,9 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	driver->err_handler->resume(dev);
>  	eeh_pcid_put(dev);
>  	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
> +#ifdef CONFIG_PCI_IOV
> +	eeh_ops->notify_resume(pdn);

eeh_ops->notify_resume(eeh_dev_to_pdn(edev));

otherwise the compiler will complain at @pdn declaration if
!defined(CONFIG_PCI_IOV). Just try compiling without CONFIG_PCI_IOV.


> +#endif
>  	return NULL;
>  }
>  
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 961e64115d92..8575b3a29e7c 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1763,7 +1763,8 @@ static struct eeh_ops pnv_eeh_ops = {
>  	.read_config            = pnv_eeh_read_config,
>  	.write_config           = pnv_eeh_write_config,
>  	.next_error		= pnv_eeh_next_error,
> -	.restore_config		= pnv_eeh_restore_config
> +	.restore_config		= pnv_eeh_restore_config,
> +	.notify_resume		= NULL


.notify_resume is NULL already.


>  };
>  
>  #ifdef CONFIG_PCI_IOV
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 5bdd1678a9ff..2b36fbf4ce74 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -798,6 +798,103 @@ static int pseries_eeh_restore_config(struct pci_dn *pdn)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PCI_IOV
> +int pseries_send_allow_unfreeze(struct eeh_pe *pe,
> +				u16 *vf_pe_array, int cur_vfs)
> +{
> +	int  rc, config_addr;
> +	int ibm_allow_unfreeze = rtas_token("ibm,open-sriov-allow-unfreeze");
> +
> +	config_addr = pe->config_addr;

@config_addr is pointless - it is used just once, even pr_warn few lines
below uses pe->config_addr.



> +	spin_lock(&rtas_data_buf_lock);
> +	memcpy(rtas_data_buf, vf_pe_array, RTAS_DATA_BUF_SIZE);
> +	rc = rtas_call(ibm_allow_unfreeze, 5, 1, NULL,
> +		       config_addr,
> +		       BUID_HI(pe->phb->buid),
> +		       BUID_LO(pe->phb->buid),
> +		       rtas_data_buf, cur_vfs * sizeof(u16));
> +	spin_unlock(&rtas_data_buf_lock);
> +	if (rc)
> +		pr_warn("%s: Failed to allow unfreeze for PHB#%x-PE#%x, rc=%x\n",
> +			__func__,
> +			pe->phb->global_number,
> +			pe->config_addr, rc);
> +	return rc;
> +}
> +
> +static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
> +{
> +	struct eeh_pe *pe;
> +	struct pci_dn *pdn, *tmp, *parent, *physfn_pdn;
> +	int cur_vfs, rc, vf_index;
> +	u16 *vf_pe_array;
> +
> +	vf_pe_array = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> +	if (!vf_pe_array)
> +		return -ENOMEM;
> +
> +	memset(vf_pe_array, 0, RTAS_DATA_BUF_SIZE);


"z" from kzalloc says it reset the memory.


> +	cur_vfs = 0;
> +	rc = 0;
> +	if (edev->pdev->is_physfn) {
> +		pe = eeh_dev_to_pe(edev);
> +		cur_vfs = pci_num_vf(edev->pdev);
> +		pdn = eeh_dev_to_pdn(edev);
> +		parent  = pdn->parent;
> +		/* For each of its VF
> +		 * call allow unfreeze
> +		 */
> +		for (vf_index = 0; vf_index < cur_vfs; vf_index++)
> +			vf_pe_array[vf_index] =
> +				be16_to_cpu(pdn->pe_num_map[vf_index]);

It is kind of assumed that the number of VFs is always less than 2048 minus
rtas call parameters (RTAS_DATA_BUF_SIZE==4096 now)?

Is the upper limit of cur_vfs checked anywhere?

We can afford 4K on stack if we know for sure this is all we n


> +
> +		rc = pseries_send_allow_unfreeze(pe, vf_pe_array, cur_vfs);
> +		pdn->last_allow_rc = rc;


Is this PF or VF pdn (I assume PF)?


> +		for (vf_index = 0; vf_index < cur_vfs; vf_index++) {
> +			list_for_each_entry_safe(pdn, tmp, &parent->child_list,
> +						 list) {
> +				if (pdn->busno
> +				    != pci_iov_virtfn_bus(edev->pdev,
> +							  vf_index) ||
> +				    pdn->devfn
> +				    != pci_iov_virtfn_devfn(edev->pdev,
> +							    vf_index))
> +					continue;
> +				pdn->last_allow_rc = rc;


I am missing the point of copying last_allow_rc - cannot
eeh_notify_resume_show() just return it from the PF?

May be just add another flag to eeh_pe::state for last_allow_rc? How many
different @rc do we expect here?


> +			}
> +		}
> +	} else {
> +		pdn = pci_get_pdn(edev->pdev);
> +		vf_pe_array[0] = be16_to_cpu(pdn->pe_number);
> +		physfn_pdn      =  pci_get_pdn(edev->physfn);

Way too many spaces, why? :)


> +		edev = pdn_to_eeh_dev(physfn_pdn);
> +		pe = eeh_dev_to_pe(edev);
> +		rc = pseries_send_allow_unfreeze(pe, vf_pe_array, 1);
> +		pdn->last_allow_rc = rc;
> +	}
> +
> +	kfree(vf_pe_array);
> +	return rc;
> +}
> +
> +static int pseries_notify_resume(struct pci_dn *pdn)
> +{
> +	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
> +
> +	if (!edev)
> +		return -EEXIST;
> +
> +	if (rtas_token("ibm,open-sriov-allow-unfreeze")
> +	    == RTAS_UNKNOWN_SERVICE)
> +		return -EINVAL;

Is this the only possible error code?


> +
> +	if (edev->pdev->is_physfn  || edev->pdev->is_virtfn)
> +		return pseries_call_allow_unfreeze(edev);
> +
> +	return 0;
> +}
> +#endif
> +
>  static struct eeh_ops pseries_eeh_ops = {
>  	.name			= "pseries",
>  	.init			= pseries_eeh_init,
> @@ -813,7 +910,8 @@ static struct eeh_ops pseries_eeh_ops = {
>  	.read_config		= pseries_eeh_read_config,
>  	.write_config		= pseries_eeh_write_config,
>  	.next_error		= NULL,
> -	.restore_config		= pseries_eeh_restore_config
> +	.restore_config		= pseries_eeh_restore_config,
> +	.notify_resume		= pseries_notify_resume
>  };
>  
>  /**
> 


-- 
Alexey
