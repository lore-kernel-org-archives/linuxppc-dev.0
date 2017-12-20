Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z21f73rS4zF0jN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 04:16:47 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBKHFqkh099304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:16:43 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyukv1hnm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:16:43 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 17:16:41 -0000
Subject: Re: [PATCH v4 1/2] powerpc/powernv: Enable tunneled operations
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, benh@au1.ibm.com
References: <20171215134818.23864-1-felix@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 18:16:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171215134818.23864-1-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7cf4e1dc-c60b-b2bb-7a40-a6f87323f920@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 15/12/2017 à 14:48, Philippe Bergheaud a écrit :
> P9 supports PCI tunneled operations (atomics and as_notify). This
> patch adds support for tunneled operations on powernv, with a new
> API, to be called by device drivers:
> 
> pnv_pci_get_tunnel_ind()
>     Tell driver the 16-bit ASN indication used by kernel.
> 
> pnv_pci_set_tunnel_bar()
>     Tell kernel the Tunnel BAR Response address used by driver.
>     This function uses two new OPAL calls, as the PBCQ Tunnel BAR
>     register is configured by skiboot.
> 
> void pnv_pci_get_as_notify_info()
>     Return the ASN info of the thread to be woken up.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2: Do not set the ASN indication. Get it from the device tree.
> 
> v3: Make pnv_pci_get_phb_node() available when compiling without cxl.
> 
> v4: Add pnv_pci_get_as_notify_info().
>      Rebase opal call numbers on skiboot 5.9.6.
> 
> This patch depends on the following skiboot prerequisites:
> 
> https://patchwork.ozlabs.org/patch/849162/
> https://patchwork.ozlabs.org/patch/849163/
> ---
>   arch/powerpc/include/asm/opal-api.h            |  4 +-
>   arch/powerpc/include/asm/opal.h                |  2 +
>   arch/powerpc/include/asm/pnv-pci.h             |  5 ++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |  2 +
>   arch/powerpc/platforms/powernv/pci-cxl.c       |  8 ---
>   arch/powerpc/platforms/powernv/pci.c           | 93 ++++++++++++++++++++++++++
>   6 files changed, 105 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 233c7504b1f2..b901f4d9f009 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -201,7 +201,9 @@
>   #define OPAL_SET_POWER_SHIFT_RATIO		155
>   #define OPAL_SENSOR_GROUP_CLEAR			156
>   #define OPAL_PCI_SET_P2P			157
> -#define OPAL_LAST				157
> +#define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		159
> +#define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		160
> +#define OPAL_LAST				160
> 
>   /* Device tree flags */
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 0c545f7fc77b..8705e422b893 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -198,6 +198,8 @@ int64_t opal_unregister_dump_region(uint32_t id);
>   int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
>   int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
>   int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
> +int64_t opal_pci_get_pbcq_tunnel_bar(uint64_t phb_id, uint64_t *addr);
> +int64_t opal_pci_set_pbcq_tunnel_bar(uint64_t phb_id, uint64_t addr);
>   int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
>   		uint64_t msg_len);
>   int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index 3e5cf251ad9a..4839e09663f2 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -29,6 +29,11 @@ extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
>   extern int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
>   			   u64 desc);
> 
> +extern int pnv_pci_get_tunnel_ind(struct pci_dev *dev, uint64_t *ind);
> +extern int pnv_pci_set_tunnel_bar(struct pci_dev *dev, uint64_t addr,
> +				  int enable);
> +extern void pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid,
> +				       u32 *pid, u32 *tid);
>   int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
>   int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
>   			   unsigned int virq);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 6f4b00a2ac46..5da790fb7fef 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -320,3 +320,5 @@ OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
>   OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
>   OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
>   OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
> +OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
> +OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
> diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
> index 94498a04558b..cee003de63af 100644
> --- a/arch/powerpc/platforms/powernv/pci-cxl.c
> +++ b/arch/powerpc/platforms/powernv/pci-cxl.c
> @@ -16,14 +16,6 @@
> 
>   #include "pci.h"
> 
> -struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -
> -	return of_node_get(hose->dn);
> -}
> -EXPORT_SYMBOL(pnv_pci_get_phb_node);
> -
>   int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 5422f4a6317c..c42e69789bd2 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -38,6 +38,7 @@
>   #include "pci.h"
> 
>   static DEFINE_MUTEX(p2p_mutex);
> +static DEFINE_MUTEX(tunnel_mutex);
> 
>   int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
>   {
> @@ -1092,6 +1093,98 @@ int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target, u64 desc)
>   }
>   EXPORT_SYMBOL_GPL(pnv_pci_set_p2p);
> 
> +struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> +
> +	return of_node_get(hose->dn);
> +}
> +EXPORT_SYMBOL(pnv_pci_get_phb_node);
> +
> +int pnv_pci_get_tunnel_ind(struct pci_dev *dev, u64 *asnind)
> +{
> +	struct device_node *np;
> +	const __be32 *prop;
> +
> +	if (!(np = pnv_pci_get_phb_node(dev)))
> +		return -ENXIO;
> +
> +	prop = of_get_property(np, "ibm,phb-indications", NULL);
> +	if (!prop || !prop[1])
> +		return -ENXIO;
> +
> +	*asnind = (u64)be32_to_cpu(prop[1]);


pnv_pci_get_phb_node() increments the ref count on the device node, so 
it needs to be released.

[ need to double-check, but I'm under the impression that 
cxl_setup_psl_timebase() is having a similar problem ]



> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_tunnel_ind);
> +
> +int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
> +{
> +	__be64 val;
> +	struct pci_controller *hose;
> +	struct pnv_phb *phb;
> +	u64 tunnel_bar;
> +	int rc;
> +
> +	if (!opal_check_token(OPAL_PCI_GET_PBCQ_TUNNEL_BAR))
> +		return -ENXIO;
> +	if (!opal_check_token(OPAL_PCI_SET_PBCQ_TUNNEL_BAR))
> +		return -ENXIO;
> +
> +	hose = pci_bus_to_host(dev->bus);
> +	phb = hose->private_data;
> +
> +	mutex_lock(&tunnel_mutex);
> +	rc = opal_pci_get_pbcq_tunnel_bar(phb->opal_id, &val);
> +	if (rc != OPAL_SUCCESS) {
> +		rc = -EIO;
> +		goto out;
> +	}
> +	tunnel_bar = be64_to_cpu(val);
> +	if (enable) {
> +		/*
> +		* Only one device per PHB can use atomics.
> +		* Our policy is first-come, first-served.
> +		*/
> +		if (tunnel_bar) {
> +			rc = -EBUSY;
> +			goto out;
> +		}
> +	} else {
> +		/*
> +		* The device that owns atomics and wants to release
> +		* them must pass the same address with enable == 0.
> +		*/
> +		if (tunnel_bar != addr) {
> +			rc = -EPERM;
> +			goto out;
> +		}
> +		addr = 0x0ULL;
> +	}
> +	rc = opal_pci_set_pbcq_tunnel_bar(phb->opal_id, addr);
> +	rc = opal_error_code(rc);
> +out:
> +	mutex_unlock(&tunnel_mutex);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_set_tunnel_bar);
> +
> +#ifdef CONFIG_PPC64

Why the ifdef?


> +void pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid, u32 *pid,
> +				u32 *tid)
> +{
> +	*lpid = mfspr(SPRN_LPID);
> +	if (task) {
> +		*pid = pid_nr(get_task_pid(task, PIDTYPE_PID));

No! the PID register is filled with with the memory context ID. You can 
check how cxllib does it.
Which also shows that this API should fail if not in radix mode.


> +		*tid = task->thread.tidr;
> +	} else {
> +		*pid = 0;
> +		*tid = 0;

I think we should fail the call if task == NULL.

   Fred


> +	}
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_as_notify_info);
> +#endif
> +
>   void pnv_pci_shutdown(void)
>   {
>   	struct pci_controller *hose;
> 
