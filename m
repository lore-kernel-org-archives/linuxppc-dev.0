Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67D631A1DB6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:35:46 +1000 (AEST)
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B4EFD1401AF
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:35:45 +1000 (AEST)
Received: by pdco4 with SMTP id o4so3984826pdc.3
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 23:35:44 -0700 (PDT)
Date: Wed, 12 Aug 2015 16:36:37 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, Manoj Kumar
 <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v3 06/11] cxl: Refactor adaptor init/teardown
Message-ID: <20150812163637.1614367b@camb691>
In-Reply-To: <1439340500-18610-7-git-send-email-dja@axtens.net>
References: <1439340500-18610-1-git-send-email-dja@axtens.net>
 <1439340500-18610-7-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Aug 2015 10:48:15 +1000
Daniel Axtens <dja@axtens.net> wrote:

> Some aspects of initialisation are done only once in the lifetime of
> an adapter: for example, allocating memory for the adapter,
> allocating the adapter number, or setting up sysfs/debugfs files.
> 
> However, we may want to be able to do some parts of the
> initialisation multiple times: for example, in error recovery we
> want to be able to tear down and then re-map IO memory and IRQs.
> 
> Therefore, refactor CXL init/teardown as follows.
> 
>  - Keep the overarching functions 'cxl_init_adapter' and its pair,
>    'cxl_remove_adapter'.
> 
>  - Move all 'once only' allocation/freeing steps to the existing
>    'cxl_alloc_adapter' function, and its pair 'cxl_release_adapter'
>    (This involves moving allocation of the adapter number out of
>    cxl_init_adapter.)
> 
>  - Create two new functions: 'cxl_configure_adapter', and its pair
>    'cxl_deconfigure_adapter'. These two functions 'wire up' the
>    hardware --- they (de)configure resources that do not need to
>    last the entire lifetime of the adapter
> 

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/pci.c | 140 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 87 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 484d35a5aead..f6cb089ff981 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -965,7 +965,6 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
>  	CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
>  	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
>  	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> -	adapter->perst_loads_image = true;
>  	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
>  
>  	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
> @@ -1025,22 +1024,34 @@ static void cxl_release_adapter(struct device *dev)
>  
>  	pr_devel("cxl_release_adapter\n");
>  
> +	cxl_remove_adapter_nr(adapter);
> +
>  	kfree(adapter);
>  }
>  
> -static struct cxl *cxl_alloc_adapter(struct pci_dev *dev)
> +static struct cxl *cxl_alloc_adapter(void)
>  {
>  	struct cxl *adapter;
> +	int rc;
>  
>  	if (!(adapter = kzalloc(sizeof(struct cxl), GFP_KERNEL)))
>  		return NULL;
>  
> -	adapter->dev.parent = &dev->dev;
> -	adapter->dev.release = cxl_release_adapter;
> -	pci_set_drvdata(dev, adapter);
>  	spin_lock_init(&adapter->afu_list_lock);
>  
> +	if ((rc = cxl_alloc_adapter_nr(adapter)))
> +		goto err1;
> +
> +	if ((rc = dev_set_name(&adapter->dev, "card%i", adapter->adapter_num)))
> +		goto err2;
> +
>  	return adapter;
> +
> +err2:
> +	cxl_remove_adapter_nr(adapter);
> +err1:
> +	kfree(adapter);
> +	return NULL;
>  }
>  
>  static int sanitise_adapter_regs(struct cxl *adapter)
> @@ -1049,57 +1060,96 @@ static int sanitise_adapter_regs(struct cxl *adapter)
>  	return cxl_tlb_slb_invalidate(adapter);
>  }
>  
> -static struct cxl *cxl_init_adapter(struct pci_dev *dev)
> +/* This should contain *only* operations that can safely be done in
> + * both creation and recovery.
> + */
> +static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>  {
> -	struct cxl *adapter;
> -	bool free = true;
>  	int rc;
>  
> +	adapter->dev.parent = &dev->dev;
> +	adapter->dev.release = cxl_release_adapter;
> +	pci_set_drvdata(dev, adapter);
>  
> -	if (!(adapter = cxl_alloc_adapter(dev)))
> -		return ERR_PTR(-ENOMEM);
> +	rc = pci_enable_device(dev);
> +	if (rc) {
> +		dev_err(&dev->dev, "pci_enable_device failed: %i\n", rc);
> +		return rc;
> +	}
>  
>  	if ((rc = cxl_read_vsec(adapter, dev)))
> -		goto err1;
> +		return rc;
>  
>  	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
> -		goto err1;
> +	        return rc;
>  
>  	if ((rc = setup_cxl_bars(dev)))
> -		goto err1;
> +		return rc;
>  
>  	if ((rc = switch_card_to_cxl(dev)))
> -		goto err1;
> -
> -	if ((rc = cxl_alloc_adapter_nr(adapter)))
> -		goto err1;
> -
> -	if ((rc = dev_set_name(&adapter->dev, "card%i", adapter->adapter_num)))
> -		goto err2;
> +		return rc;
>  
>  	if ((rc = cxl_update_image_control(adapter)))
> -		goto err2;
> +		return rc;
>  
>  	if ((rc = cxl_map_adapter_regs(adapter, dev)))
> -		goto err2;
> +		return rc;
>  
>  	if ((rc = sanitise_adapter_regs(adapter)))
> -		goto err2;
> +		goto err;
>  
>  	if ((rc = init_implementation_adapter_regs(adapter, dev)))
> -		goto err3;
> +		goto err;
>  
>  	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_CAPI)))
> -		goto err3;
> +		goto err;
>  
>  	/* If recovery happened, the last step is to turn on snooping.
>  	 * In the non-recovery case this has no effect */
> -	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON))) {
> -		goto err3;
> -	}
> +	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON)))
> +		goto err;
>  
>  	if ((rc = cxl_register_psl_err_irq(adapter)))
> -		goto err3;
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	cxl_unmap_adapter_regs(adapter);
> +	return rc;
> +
> +}
> +
> +static void cxl_deconfigure_adapter(struct cxl *adapter)
> +{
> +	struct pci_dev *pdev = to_pci_dev(adapter->dev.parent);
> +
> +	cxl_release_psl_err_irq(adapter);
> +	cxl_unmap_adapter_regs(adapter);
> +
> +	pci_disable_device(pdev);
> +}
> +
> +static struct cxl *cxl_init_adapter(struct pci_dev *dev)
> +{
> +	struct cxl *adapter;
> +	int rc;
> +
> +	adapter = cxl_alloc_adapter();
> +	if (!adapter)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Set defaults for parameters which need to persist over
> +	 * configure/reconfigure
> +	 */
> +	adapter->perst_loads_image = true;
> +
> +	rc = cxl_configure_adapter(adapter, dev);
> +	if (rc) {
> +		pci_disable_device(dev);
> +		cxl_release_adapter(&adapter->dev);
> +		return ERR_PTR(rc);
> +	}
>  
>  	/* Don't care if this one fails: */
>  	cxl_debugfs_adapter_add(adapter);
> @@ -1117,35 +1167,25 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
>  	return adapter;
>  
>  err_put1:
> -	device_unregister(&adapter->dev);
> -	free = false;
> +	/* This should mirror cxl_remove_adapter, except without the
> +	 * sysfs parts
> +	 */
>  	cxl_debugfs_adapter_remove(adapter);
> -	cxl_release_psl_err_irq(adapter);
> -err3:
> -	cxl_unmap_adapter_regs(adapter);
> -err2:
> -	cxl_remove_adapter_nr(adapter);
> -err1:
> -	if (free)
> -		kfree(adapter);
> +	cxl_deconfigure_adapter(adapter);
> +	device_unregister(&adapter->dev);
>  	return ERR_PTR(rc);
>  }
>  
>  static void cxl_remove_adapter(struct cxl *adapter)
>  {
> -	struct pci_dev *pdev = to_pci_dev(adapter->dev.parent);
> -
> -	pr_devel("cxl_release_adapter\n");
> +	pr_devel("cxl_remove_adapter\n");
>  
>  	cxl_sysfs_adapter_remove(adapter);
>  	cxl_debugfs_adapter_remove(adapter);
> -	cxl_release_psl_err_irq(adapter);
> -	cxl_unmap_adapter_regs(adapter);
> -	cxl_remove_adapter_nr(adapter);
>  
> -	device_unregister(&adapter->dev);
> +	cxl_deconfigure_adapter(adapter);
>  
> -	pci_disable_device(pdev);
> +	device_unregister(&adapter->dev);
>  }
>  
>  static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
> @@ -1159,15 +1199,9 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (cxl_verbose)
>  		dump_cxl_config_space(dev);
>  
> -	if ((rc = pci_enable_device(dev))) {
> -		dev_err(&dev->dev, "pci_enable_device failed: %i\n", rc);
> -		return rc;
> -	}
> -
>  	adapter = cxl_init_adapter(dev);
>  	if (IS_ERR(adapter)) {
>  		dev_err(&dev->dev, "cxl_init_adapter failed: %li\n", PTR_ERR(adapter));
> -		pci_disable_device(dev);
>  		return PTR_ERR(adapter);
>  	}
>  
