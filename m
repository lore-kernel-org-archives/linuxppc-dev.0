Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq07K6DjgzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:28:29 +1000 (AEST)
Received: by mail-pf0-x22b.google.com with SMTP id n1so5131949pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:28:29 -0700 (PDT)
Subject: Re: [PATCH v8 36/45] powerpc/powernv: Support PCI slot ID
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-37-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715FA34.40004@ozlabs.ru>
Date: Tue, 19 Apr 2016 19:28:20 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-37-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> PowerNV platforms runs on top of skiboot firmware that includes
> changes to support PCI slots. PCI slots are identified by PHB's
> ID or the combo of that and PCI slot ID.
>
> This changes the EEH PowerNV backend to support PCI slots:
>
>     * Rename arguments of opal_pci_reset() and opal_pci_poll().
>     * One more argument (PCI slot's state) added to opal_pci_poll().
>     * Drop pnv_eeh_phb_poll() and introduce a enhanced similar
>       function pnv_pci_poll() that will be used by PowerNV hotplug
>       backends.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/opal.h              |  4 +--
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 42 ++++++----------------------
>   arch/powerpc/platforms/powernv/pci.c         | 21 ++++++++++++++
>   arch/powerpc/platforms/powernv/pci.h         |  1 +
>   4 files changed, 32 insertions(+), 36 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 07a99e6..9e0039f 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -131,7 +131,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
>   int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
>   					uint16_t dma_window_number, uint64_t pci_start_addr,
>   					uint64_t pci_mem_size);
> -int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
> +int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope, uint8_t assert_state);
>
>   int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
>   				   uint64_t diag_buffer_len);
> @@ -148,7 +148,7 @@ int64_t opal_get_dpo_status(__be64 *dpo_timeout);
>   int64_t opal_set_system_attention_led(uint8_t led_action);
>   int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
>   			    __be16 *pci_error_type, __be16 *severity);
> -int64_t opal_pci_poll(uint64_t phb_id);
> +int64_t opal_pci_poll(uint64_t id, uint8_t *state);
>   int64_t opal_return_cpu(void);
>   int64_t opal_check_token(uint64_t token);
>   int64_t opal_reinit_cpus(uint64_t flags);
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index c7454ba..e23b063 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -717,28 +717,11 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
>   	return ret;
>   }
>
> -static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
> -{
> -	s64 rc = OPAL_HARDWARE;
> -
> -	while (1) {
> -		rc = opal_pci_poll(phb->opal_id);
> -		if (rc <= 0)
> -			break;
> -
> -		if (system_state < SYSTEM_RUNNING)
> -			udelay(1000 * rc);
> -		else
> -			msleep(rc);
> -	}
> -
> -	return rc;
> -}
> -
>   int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
>   {
>   	struct pnv_phb *phb = hose->private_data;
>   	s64 rc = OPAL_HARDWARE;
> +	int ret;
>
>   	pr_debug("%s: Reset PHB#%x, option=%d\n",
>   		 __func__, hose->global_number, option);
> @@ -753,8 +736,6 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
>   		rc = opal_pci_reset(phb->opal_id,
>   				    OPAL_RESET_PHB_COMPLETE,
>   				    OPAL_DEASSERT_RESET);
> -	if (rc < 0)
> -		goto out;
>
>   	/*
>   	 * Poll state of the PHB until the request is done
> @@ -762,24 +743,22 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
>   	 * reset followed by hot reset on root bus. So we also
>   	 * need the PCI bus settlement delay.
>   	 */
> -	rc = pnv_eeh_phb_poll(phb);
> -	if (option == EEH_RESET_DEACTIVATE) {
> +	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
> +	if (option == EEH_RESET_DEACTIVATE && !ret) {
>   		if (system_state < SYSTEM_RUNNING)
>   			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
>   		else
>   			msleep(EEH_PE_RST_SETTLE_TIME);
>   	}
> -out:
> -	if (rc != OPAL_SUCCESS)
> -		return -EIO;
>
> -	return 0;
> +	return ret;
>   }
>
>   static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
>   {
>   	struct pnv_phb *phb = hose->private_data;
>   	s64 rc = OPAL_HARDWARE;
> +	int ret;
>
>   	pr_debug("%s: Reset PHB#%x, option=%d\n",
>   		 __func__, hose->global_number, option);
> @@ -801,18 +780,13 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
>   		rc = opal_pci_reset(phb->opal_id,
>   				    OPAL_RESET_PCI_HOT,
>   				    OPAL_DEASSERT_RESET);
> -	if (rc < 0)
> -		goto out;
>
>   	/* Poll state of the PHB until the request is done */
> -	rc = pnv_eeh_phb_poll(phb);
> -	if (option == EEH_RESET_DEACTIVATE)
> +	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
> +	if (option == EEH_RESET_DEACTIVATE && !ret)
>   		msleep(EEH_PE_RST_SETTLE_TIME);
> -out:
> -	if (rc != OPAL_SUCCESS)
> -		return -EIO;
>
> -	return 0;
> +	return ret;
>   }
>
>   static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index b87a315..a458703 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -42,6 +42,27 @@
>   #define cfg_dbg(fmt...)	do { } while(0)
>   //#define cfg_dbg(fmt...)	printk(fmt)
>
> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state)
> +{
> +	while (rval > 0) {
> +		if (system_state < SYSTEM_RUNNING)
> +			udelay(1000 * rval);
> +		else
> +			msleep(rval);
> +
> +		rval = opal_pci_poll(id, state);
> +	}
> +
> +	/*
> +	 * The caller expects to retrieve additional
> +	 * information if the last argument isn't NULL.
> +	 */
> +	if (rval == OPAL_SUCCESS && state)
> +		rval = opal_pci_poll(id, state);


Old OPAL won't touch @state so whatever garbage was there will stay there 
as the only caller which is passing not-NULL there is 
pnv_php_get_power_state() and it does not initialize @power_state (it is in 
"[PATCH v8 45/45] PCI/hotplug: PowerPC PowerNV PCI hotplug driver").


btw how will new OPAL react if old kernel is running, i.e. not passing 
@state at all? If it is initialized to NULL somewher - fine but what 
exactly does this initialization and makes sure that OPAL won't see garbage 
as a second parameter?

When ABI like this changes, I expect to see opal_pci_poll2() or 
opal_pci_poll_ex() rather than just an additional parameter to 
opal_pci_poll()...



> +
> +	return (rval == OPAL_SUCCESS) ? 0 : -EIO;
> +}
> +
>   #ifdef CONFIG_PCI_MSI
>   int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>   {
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 0cddde3..6857703 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -192,6 +192,7 @@ extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
>   		unsigned long *hpa, enum dma_data_direction *direction);
>   extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
>
> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state);
>   void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>   				unsigned char *log_buff);
>   int pnv_pci_cfg_read(struct pci_dn *pdn,
>


-- 
Alexey
