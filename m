Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq0NH6tcWzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:39:43 +1000 (AEST)
Received: by mail-pa0-x235.google.com with SMTP id er2so5078799pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:39:43 -0700 (PDT)
Subject: Re: [PATCH v8 38/45] powerpc/powernv: Functions to get/set PCI slot
 status
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-39-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715FCD6.90703@ozlabs.ru>
Date: Tue, 19 Apr 2016 19:39:34 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-39-git-send-email-gwshan@linux.vnet.ibm.com>
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
> This exports 4 functins, which base on the corresponding OPAL


s/functins/functions/


> APIs to get/set PCI slot status. Those functions are going to
> be used by PowerNV PCI hotplug driver:
>
>     pnv_pci_get_device_tree()    opal_get_device_tree()
>     pnv_pci_get_presence_state() opal_pci_get_presence_state()
>     pnv_pci_get_power_state()    opal_pci_get_power_state()
>     pnv_pci_set_power_state()    opal_pci_set_power_state()
>
> Besides, the patch also exports pnv_pci_hotplug_notifier_{register,
> unregister}() to allow registration and unregistration of PCI hotplug
> notifier, which will be used to receive PCI hotplug message from
> skiboot firmware in PowerNV PCI hotplug driver.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/opal-api.h            | 17 ++++++-
>   arch/powerpc/include/asm/opal.h                |  4 ++
>   arch/powerpc/include/asm/pnv-pci.h             |  7 +++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++
>   arch/powerpc/platforms/powernv/pci.c           | 66 ++++++++++++++++++++++++++
>   5 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index f8faaae..a6af338 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -158,7 +158,11 @@
>   #define OPAL_LEDS_SET_INDICATOR			115
>   #define OPAL_CEC_REBOOT2			116
>   #define OPAL_CONSOLE_FLUSH			117
> -#define OPAL_LAST				117
> +#define OPAL_GET_DEVICE_TREE			118
> +#define OPAL_PCI_GET_PRESENCE_STATE		119
> +#define OPAL_PCI_GET_POWER_STATE		120
> +#define OPAL_PCI_SET_POWER_STATE		121
> +#define OPAL_LAST				121
>
>   /* Device tree flags */
>
> @@ -344,6 +348,16 @@ enum OpalPciResetState {
>   	OPAL_ASSERT_RESET   = 1
>   };
>
> +enum OpalPciSlotPresentenceState {
> +	OPAL_PCI_SLOT_EMPTY	= 0,
> +	OPAL_PCI_SLOT_PRESENT	= 1
> +};
> +
> +enum OpalPciSlotPowerState {
> +	OPAL_PCI_SLOT_POWER_OFF	= 0,
> +	OPAL_PCI_SLOT_POWER_ON	= 1
> +};
> +
>   enum OpalSlotLedType {
>   	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
>   	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
> @@ -378,6 +392,7 @@ enum opal_msg_type {
>   	OPAL_MSG_DPO,
>   	OPAL_MSG_PRD,
>   	OPAL_MSG_OCC,
> +	OPAL_MSG_PCI_HOTPLUG,
>   	OPAL_MSG_TYPE_MAX,
>   };
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9e0039f..899bcb941 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -209,6 +209,10 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
>   		uint64_t size, uint64_t token);
>   int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
>   		uint64_t token);
> +int64_t opal_get_device_tree(uint32_t phandle, uint64_t buf, uint64_t len);
> +int64_t opal_pci_get_presence_state(uint64_t id, uint8_t *state);
> +int64_t opal_pci_get_power_state(uint64_t id, uint8_t *state);
> +int64_t opal_pci_set_power_state(uint64_t id, uint8_t state);
>
>   /* Internal functions */
>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index 6f77f71..d9d095b 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -13,6 +13,13 @@
>   #include <linux/pci.h>
>   #include <misc/cxl-base.h>
>
> +extern int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len);
> +extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
> +extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
> +extern int pnv_pci_set_power_state(uint64_t id, uint8_t state);
> +extern int pnv_pci_hotplug_notifier_register(struct notifier_block *nb);
> +extern int pnv_pci_hotplug_notifier_unregister(struct notifier_block *nb);
> +
>   int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
>   int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
>   			   unsigned int virq);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index e45b88a..3ea1a855 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -302,3 +302,7 @@ OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
>   OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
>   OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
>   OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
> +OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
> +OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
> +OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
> +OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index a458703..206385f 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -63,6 +63,72 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state)
>   	return (rval == OPAL_SUCCESS) ? 0 : -EIO;
>   }
>
> +int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len)
> +{
> +	int64_t rc;
> +
> +	if (!opal_check_token(OPAL_GET_DEVICE_TREE))
> +		return -ENXIO;
> +
> +	rc = opal_get_device_tree(phandle, (uint64_t)buf, len);
> +	if (rc != OPAL_SUCCESS)
> +		return -EIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_device_tree);
> +
> +int pnv_pci_get_presence_state(uint64_t id, uint8_t *state)
> +{
> +	int64_t rc;
> +
> +	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATE))
> +		return -ENXIO;
> +
> +	rc = opal_pci_get_presence_state(id, state);
> +	if (rc != OPAL_SUCCESS)
> +		return -EIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_presence_state);
> +
> +int pnv_pci_get_power_state(uint64_t id, uint8_t *state)
> +{
> +	int64_t rc;
> +
> +	if (!opal_check_token(OPAL_PCI_GET_POWER_STATE))
> +		return -ENXIO;
> +
> +	rc = opal_pci_get_power_state(id, state);


Out of curiosity - if rc==OPAL_SUCCESS, @state should already contain the 
correct state and you do not have to call pnv_pci_poll() (which will call 
opal_pci_poll() immediately), is that correct?

Anyway, looks correct.


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> +	return pnv_pci_poll(id, rc, state);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_power_state);
> +
> +int pnv_pci_set_power_state(uint64_t id, uint8_t state)
> +{
> +	int64_t rc;
> +
> +	if (!opal_check_token(OPAL_PCI_SET_POWER_STATE))
> +		return -ENXIO;
> +
> +	rc = opal_pci_set_power_state(id, state);
> +	return pnv_pci_poll(id, rc, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_set_power_state);
> +
> +int pnv_pci_hotplug_notifier_register(struct notifier_block *nb)
> +{
> +	return opal_message_notifier_register(OPAL_MSG_PCI_HOTPLUG, nb);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_hotplug_notifier_register);
> +
> +int pnv_pci_hotplug_notifier_unregister(struct notifier_block *nb)
> +{
> +	return opal_message_notifier_unregister(OPAL_MSG_PCI_HOTPLUG, nb);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_hotplug_notifier_unregister);
> +
>   #ifdef CONFIG_PCI_MSI
>   int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>   {
>


-- 
Alexey
