Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1pZR31SvzDsPC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 03:57:35 +1000 (AEST)
Date: Tue, 26 Sep 2017 12:57:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] PCI: Remove reset argument from
 pci_iov_{add,remove}_virtfn()
Message-ID: <20170926175730.GN15970@bhelgaas-glaptop.roam.corp.google.com>
References: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 06, 2017 at 01:21:22AM +0200, Jan H. Schönherr wrote:
> The reset argument passed to pci_iov_add_virtfn() and
> pci_iov_remove_virtfn() is always zero since commit 46cb7b1bd86fc227a
> ("PCI: Remove unused SR-IOV VF Migration support").
> 
> Remove the argument together with the associated code.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>

Applied both (with Russell's ack on the first) to pci/virtualization
for v4.14, thanks!

> ---
>  arch/powerpc/kernel/eeh_driver.c |  4 ++--
>  drivers/pci/iov.c                | 18 +++++-------------
>  include/linux/pci.h              |  8 ++++----
>  3 files changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index c405c79..23ea86f 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -441,7 +441,7 @@ static void *eeh_add_virt_device(void *data, void *userdata)
>  	}
>  
>  #ifdef CONFIG_PPC_POWERNV
> -	pci_iov_add_virtfn(edev->physfn, pdn->vf_index, 0);
> +	pci_iov_add_virtfn(edev->physfn, pdn->vf_index);
>  #endif
>  	return NULL;
>  }
> @@ -499,7 +499,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
>  #ifdef CONFIG_PPC_POWERNV
>  		struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>  
> -		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index, 0);
> +		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index);
>  		edev->pdev = NULL;
>  
>  		/*
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 120485d..21b55ca 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -113,7 +113,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>  	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
>  }
>  
> -int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
> +int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  {
>  	int i;
>  	int rc = -ENOMEM;
> @@ -157,9 +157,6 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
>  		BUG_ON(rc);
>  	}
>  
> -	if (reset)
> -		__pci_reset_function(virtfn);
> -
>  	pci_device_add(virtfn, virtfn->bus);
>  
>  	pci_bus_add_device(virtfn);
> @@ -187,7 +184,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
>  	return rc;
>  }
>  
> -void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset)
> +void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
>  {
>  	char buf[VIRTFN_ID_LEN];
>  	struct pci_dev *virtfn;
> @@ -198,11 +195,6 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset)
>  	if (!virtfn)
>  		return;
>  
> -	if (reset) {
> -		device_release_driver(&virtfn->dev);
> -		__pci_reset_function(virtfn);
> -	}
> -
>  	sprintf(buf, "virtfn%u", id);
>  	sysfs_remove_link(&dev->dev.kobj, buf);
>  	/*
> @@ -317,7 +309,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	pci_cfg_access_unlock(dev);
>  
>  	for (i = 0; i < initial; i++) {
> -		rc = pci_iov_add_virtfn(dev, i, 0);
> +		rc = pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> @@ -329,7 +321,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  
>  failed:
>  	while (i--)
> -		pci_iov_remove_virtfn(dev, i, 0);
> +		pci_iov_remove_virtfn(dev, i);
>  
>  	pcibios_sriov_disable(dev);
>  err_pcibios:
> @@ -355,7 +347,7 @@ static void sriov_disable(struct pci_dev *dev)
>  		return;
>  
>  	for (i = 0; i < iov->num_VFs; i++)
> -		pci_iov_remove_virtfn(dev, i, 0);
> +		pci_iov_remove_virtfn(dev, i);
>  
>  	pcibios_sriov_disable(dev);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f958d07..4acf321 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1903,8 +1903,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
>  
>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>  void pci_disable_sriov(struct pci_dev *dev);
> -int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset);
> -void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset);
> +int pci_iov_add_virtfn(struct pci_dev *dev, int id);
> +void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
>  int pci_num_vf(struct pci_dev *dev);
>  int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
> @@ -1921,12 +1921,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>  }
>  static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>  { return -ENODEV; }
> -static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
> +static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  {
>  	return -ENOSYS;
>  }
>  static inline void pci_iov_remove_virtfn(struct pci_dev *dev,
> -					 int id, int reset) { }
> +					 int id) { }
>  static inline void pci_disable_sriov(struct pci_dev *dev) { }
>  static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
>  static inline int pci_vfs_assigned(struct pci_dev *dev)
> -- 
> 2.10.0.1.g70cd14e
> 
