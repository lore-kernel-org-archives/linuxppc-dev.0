Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 645441A0E09
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 00:44:53 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so73630899pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2015 07:44:51 -0700 (PDT)
Message-ID: <554E1D5D.4000309@ozlabs.ru>
Date: Sun, 10 May 2015 00:44:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/21] powerpc/powernv: Functions to get/reset PCI
 slot status
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-15-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 04:03 PM, Gavin Shan wrote:
> The patch exports 3 functions, which base on corresponding OPAL
> APIs to get or set PCI slot status. Those functions are going to
> be used by PCI hotplug module in subsequent patches:
>
>     pnv_pci_get_presence_status()  opal_pci_get_presence_status()
>     pnv_pci_get_power_status()     opal_pci_get_power_status()
>     pnv_pci_set_power_status()     opal_pci_set_power_status()
>
> Besides, the patch also exports pnv_pci_hotplug_notifier() to allow
> registering PCI hotplug notifier, which will be used to receive PCI
> hotplug message from skiboot firmware.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/opal-api.h            |  7 +++-
>   arch/powerpc/include/asm/opal.h                |  3 ++
>   arch/powerpc/include/asm/pnv-pci.h             |  5 +++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |  3 ++
>   arch/powerpc/platforms/powernv/pci.c           | 45 ++++++++++++++++++++++++++
>   5 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 0321a90..29b407d 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -153,7 +153,10 @@
>   #define OPAL_FLASH_READ				110
>   #define OPAL_FLASH_WRITE			111
>   #define OPAL_FLASH_ERASE			112
> -#define OPAL_LAST				112
> +#define OPAL_PCI_GET_PRESENCE_STATUS		116
> +#define OPAL_PCI_GET_POWER_STATUS		117
> +#define OPAL_PCI_SET_POWER_STATUS		118
> +#define OPAL_LAST				118
>
>   /* Device tree flags */
>
> @@ -352,6 +355,8 @@ enum opal_msg_type {
>   	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
>   	OPAL_MSG_HMI_EVT,
>   	OPAL_MSG_DPO,
> +	OPAL_MSG_PRD,
> +	OPAL_MSG_PCI_HOTPLUG,
>   	OPAL_MSG_TYPE_MAX,
>   };
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 6d467df..a0eb206 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -200,6 +200,9 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
>   		uint64_t size, uint64_t token);
>   int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
>   		uint64_t token);
> +int64_t opal_pci_get_presence_status(uint64_t id, uint8_t *status);
> +int64_t opal_pci_get_power_status(uint64_t id, uint8_t *status);
> +int64_t opal_pci_set_power_status(uint64_t id, uint8_t status);
>
>   /* Internal functions */
>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index f9b4982..50d92a4 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -13,6 +13,11 @@
>   #include <linux/pci.h>
>   #include <misc/cxl.h>
>
> +extern int pnv_pci_get_presence_status(uint64_t id, uint8_t *status);
> +extern int pnv_pci_get_power_status(uint64_t id, uint8_t *status);
> +extern int pnv_pci_set_power_status(uint64_t id, uint8_t status);
> +extern int pnv_pci_hotplug_notifier(struct notifier_block *nb, bool enable);
> +
>   int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
>   int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
>   			   unsigned int virq);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index a7ade94..aa95dcb 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -295,3 +295,6 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
>   OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
>   OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
>   OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
> +OPAL_CALL(opal_pci_get_presence_status,		OPAL_PCI_GET_PRESENCE_STATUS);
> +OPAL_CALL(opal_pci_get_power_status,		OPAL_PCI_GET_POWER_STATUS);
> +OPAL_CALL(opal_pci_set_power_status,		OPAL_PCI_SET_POWER_STATUS);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index a2da9a3..60e6d65 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -60,6 +60,51 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
>   	return rval ? -EIO : 0;
>   }
>
> +int pnv_pci_get_presence_status(uint64_t id, uint8_t *status)
> +{
> +	long rc;
> +
> +	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATUS))


I got a question about the style (i.e. I do not mean the patch is wrong :) )

Everywhere else you use int64_t or s64 for the value returned by OPAL but 
not with opal_check_point(). And you would compare it to OPAL_SUCCESS 
rather than plain zero. What does opal_check_token() return when succeeded? 
1, -1,...? OPAL_SUCCESS means here an error, right?


> +		return -ENXIO;
> +
> +	rc = opal_pci_get_presence_status(id, status);
> +	return pnv_pci_poll(id, rc, status);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_presence_status);
> +
> +int pnv_pci_get_power_status(uint64_t id, uint8_t *status)
> +{
> +	long rc;
> +
> +	if (!opal_check_token(OPAL_PCI_GET_POWER_STATUS))
> +		return -ENXIO;
> +
> +	rc = opal_pci_get_power_status(id, status);
> +	return pnv_pci_poll(id, rc, status);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_get_power_status);
> +
> +int pnv_pci_set_power_status(uint64_t id, uint8_t status)
> +{
> +	long rc;
> +
> +	if (!opal_check_token(OPAL_PCI_SET_POWER_STATUS))
> +		return -ENXIO;
> +
> +	rc = opal_pci_set_power_status(id, status);
> +	return pnv_pci_poll(id, rc, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_set_power_status);
> +
> +int pnv_pci_hotplug_notifier(struct notifier_block *nb, bool enable)
> +{
> +	if (enable)
> +		return opal_message_notifier_register(OPAL_MSG_PCI_HOTPLUG, nb);
> +
> +	return opal_message_notifier_unregister(OPAL_MSG_PCI_HOTPLUG, nb);
> +}
> +EXPORT_SYMBOL_GPL(pnv_pci_hotplug_notifier);
> +
>   #ifdef CONFIG_PCI_MSI
>   static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>   {
>


-- 
Alexey
