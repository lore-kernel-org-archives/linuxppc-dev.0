Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRDqM1khXzDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 01:53:03 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9VElYrW084125
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 10:53:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dxrv8jb2u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 10:53:00 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 08:53:00 -0600
Subject: Re: [PATCH v4 3/3] pci/iov: Expose VF drivers Auto Probe Globally
To: helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-devel@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, linuxppc-dev@lists.ozlabs.org
References: <20171031144724.27808-1-bryantly@linux.vnet.ibm.com>
 <20171031144724.27808-4-bryantly@linux.vnet.ibm.com>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 09:52:55 -0500
MIME-Version: 1.0
In-Reply-To: <20171031144724.27808-4-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <01c04bf3-36bf-31f6-c714-a616ea2fcf56@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add linuxppc-dev@lists.ozlabs.org

On 10/31/17 9:47 AM, Bryant G. Ly wrote:

> When SR-IOV is supported in pci_dev struct the
> member variable drivers_autoprobe controls the
> VF drivers auto probe functionality. This
> patch exposes a gloabal function to be used
> if needed when configuring the pci_dev sriov object.
>
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pci.c |  2 ++
>  drivers/pci/iov.c                    | 12 ++++++++++++
>  include/linux/pci.h                  |  2 ++
>  3 files changed, 16 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 14a90cf471cc..48d3af026f90 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -63,6 +63,7 @@ int pseries_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>  {
>  	/* Allocate PCI data */
>  	add_dev_pci_data(pdev);
> +	pci_vf_drivers_autoprobe(pdev, false);
>  	return 0;
>  }
>
> @@ -70,6 +71,7 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
>  {
>  	/* Release PCI data */
>  	remove_dev_pci_data(pdev);
> +	pci_vf_drivers_autoprobe(pdev, true);
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ac41c8be9200..41465c06975c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -634,6 +634,18 @@ void pci_restore_iov_state(struct pci_dev *dev)
>  }
>
>  /**
> + * pci_vf_drivers_autoprobe - set pf property drivers_autoprobe for vfs
> + * @dev: the PCI device
> + * @auto_probe: set vf drivers auto probe flag
> + */
> +void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
> +{
> +	if (dev->is_physfn)
> +		dev->sriov->drivers_autoprobe = auto_probe;
> +}
> +EXPORT_SYMBOL_GPL(pci_vf_drivers_autoprobe);
> +
> +/**
>   * pci_iov_bus_range - find bus range used by Virtual Function
>   * @bus: the PCI bus
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f4f8ee5a7362..17a08554baa2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1965,6 +1965,7 @@ int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
> +void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
>  #else
>  static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>  {
> @@ -1992,6 +1993,7 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>  { return 0; }
>  static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>  { return 0; }
> +static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
>  #endif
>
>  #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
