Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46D3F1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 10:59:48 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 05:29:45 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 107A0E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:30:05 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPNxcNr54853808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:29:38 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPNxgbp011446
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:29:42 +0530
Date: Wed, 26 Nov 2014 10:59:41 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/8] powerpc/powernv: Export functions to retrieve slot
 status
Message-ID: <20141125235940.GB20556@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416869365-7671-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416956433.5089.7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416956433.5089.7.camel@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 10:00:33AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2014-11-25 at 09:49 +1100, Gavin Shan wrote:
>> The patch exports two functions, which base on corresponding OPAL
>> APIs to retrieve PCI slot status:
>> 
>>    pnv_pci_get_power_status()     opal_pci_get_power_status()
>>    pnv_pci_get_presence_status()  opal_pci_get_presence_status()
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/opal.h                |  6 +++-
>>  arch/powerpc/include/asm/pnv-pci.h             |  3 ++
>>  arch/powerpc/platforms/powernv/eeh-ioda.c      | 34 ++---------------------
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |  2 ++
>>  arch/powerpc/platforms/powernv/pci.c           | 38 ++++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/pci.h           |  1 +
>>  6 files changed, 51 insertions(+), 33 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index b59811f..b75be1c 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -153,6 +153,8 @@ struct opal_sg_list {
>>  #define OPAL_HANDLE_HMI				98
>>  #define OPAL_REGISTER_DUMP_REGION		101
>>  #define OPAL_UNREGISTER_DUMP_REGION		102
>> +#define OPAL_PCI_GET_POWER_STATUS		110
>> +#define OPAL_PCI_GET_PRESENCE_STATUS		111
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> @@ -905,7 +907,7 @@ int64_t opal_get_epow_status(__be64 *status);
>>  int64_t opal_set_system_attention_led(uint8_t led_action);
>>  int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
>>  			    __be16 *pci_error_type, __be16 *severity);
>> -int64_t opal_pci_poll(uint64_t id);
>> +int64_t opal_pci_poll(uint64_t id, uint8_t *val);
>>  int64_t opal_return_cpu(void);
>>  int64_t opal_check_token(uint64_t token);
>>  int64_t opal_reinit_cpus(uint64_t flags);
>> @@ -946,6 +948,8 @@ int64_t opal_handle_hmi(void);
>>  int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
>>  int64_t opal_unregister_dump_region(uint32_t id);
>>  int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
>> +int64_t opal_pci_get_power_status(uint64_t id, uint8_t *status);
>> +int64_t opal_pci_get_presence_status(uint64_t id, uint8_t *status);
>>  
>>  /* Internal functions */
>>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
>> index f09a22f..527d97a 100644
>> --- a/arch/powerpc/include/asm/pnv-pci.h
>> +++ b/arch/powerpc/include/asm/pnv-pci.h
>> @@ -13,6 +13,9 @@
>>  #include <linux/pci.h>
>>  #include <misc/cxl.h>
>>  
>> +extern int pnv_pci_get_power_status(unsigned int index, unsigned char *status);
>> +extern int pnv_pci_get_presence_status(unsigned int index, unsigned char *status);
>> +
>>  int pnv_phb_to_cxl(struct pci_dev *dev);
>>  int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
>>  			   unsigned int virq);
>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> index 4bf2fb5..fb66c74 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> @@ -490,24 +490,6 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
>>  	return ioda_eeh_get_pe_state(pe);
>>  }
>>  
>> -static s64 ioda_eeh_phb_poll(uint64_t id)
>> -{
>> -	s64 rc = OPAL_HARDWARE;
>> -
>> -	while (1) {
>> -		rc = opal_pci_poll(id);
>> -		if (rc <= 0)
>> -			break;
>> -
>> -		if (system_state < SYSTEM_RUNNING)
>> -			udelay(1000 * rc);
>> -		else
>> -			msleep(rc);
>> -	}
>> -
>> -	return rc;
>> -}
>> -
>>  int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
>>  {
>>  	struct pnv_phb *phb = hose->private_data;
>> @@ -542,13 +524,7 @@ int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
>>  	 * need the PCI bus settlement delay.
>>  	 */
>>  	rc = opal_pci_reset(phb->opal_id, reset_scope);
>> -	if (rc > 0)
>> -		rc = ioda_eeh_phb_poll(phb->opal_id);
>> -
>> -	if (rc != OPAL_SUCCESS)
>> -		return -EIO;
>> -
>> -	return 0;
>> +	return pnv_pci_poll(phb->opal_id, rc, NULL);
>>  }
>
>Patch does too mutch, the factoring out of pnv_pci_poll should be a
>separate patch.
>

Agree, I'll have separate patch for factoring pnv_pci_poll().

>>  static int __ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
>> @@ -641,13 +617,7 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
>>  	phb = hose->private_data;
>>  	id |= ((phb->opal_id << 16) | (dev->bus->number << 8) | (dev->devfn));
>>  	rc = opal_pci_reset(id, reset_scope);
>> -	if (rc > 0)
>> -		rc = ioda_eeh_phb_poll(id);
>> -
>> -	if (rc != OPAL_SUCCESS)
>> -		return -EIO;
>> -
>> -	return 0;
>> +	return pnv_pci_poll(id, rc, NULL);
>>  }
>>  
>>  static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> index b6474a1..b2c15ff 100644
>> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
>> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> @@ -249,3 +249,5 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
>>  OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
>>  OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
>>  OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CXL_MODE);
>> +OPAL_CALL(opal_pci_get_power_status,		OPAL_PCI_GET_POWER_STATUS);
>> +OPAL_CALL(opal_pci_get_presence_status,		OPAL_PCI_GET_PRESENCE_STATUS);
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index b2187d0..f5bae4f 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -45,6 +45,44 @@
>>  #define cfg_dbg(fmt...)	do { } while(0)
>>  //#define cfg_dbg(fmt...)	printk(fmt)
>>  
>> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
>> +{
>> +	while (rval > 0) {
>> +		rval = opal_pci_poll(id, pval);
>> +		if (rval <= 0)
>> +			break;
>> +
>> +		if (system_state < SYSTEM_RUNNING)
>> +			udelay(1000 * rval);
>> +		else
>> +			msleep(rval);
>> +	}
>> +
>> +	return rval ? -EIO : 0;
>> +}
>
>Do we need the udelay case still nowadays ? When do we call this early
>enough that msleep won't work ?
>

The second kernel in kexec scenario issue reset on PHBs to eliminate
bogus PCI traffic. That time, msleep() can't work yet.

Thanks,
Gavin

>> +int pnv_pci_get_power_status(unsigned int index, unsigned char *status)
>> +{
>> +	uint64_t id = (0x1ul << 63);
>> +	long rc;
>> +
>> +	id |= index;
>> +	rc = opal_pci_get_power_status(id, status);
>> +	return pnv_pci_poll(id, rc, status);
>> +}
>> +EXPORT_SYMBOL_GPL(pnv_pci_get_power_status);
>> +
>> +int pnv_pci_get_presence_status(unsigned int index, unsigned char *status)
>> +{
>> +	uint64_t id = (0x1ul << 63);
>> +	long rc;
>> +
>> +	id |= index;
>> +	rc = opal_pci_get_presence_status(id, status);
>> +	return pnv_pci_poll(id, rc, status);
>> +}
>> +EXPORT_SYMBOL_GPL(pnv_pci_get_presence_status);
>> +
>>  #ifdef CONFIG_PCI_MSI
>>  static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>  {
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 6c02ff8..396fe02 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -217,6 +217,7 @@ extern struct pci_ops pnv_pci_ops;
>>  extern struct pnv_eeh_ops ioda_eeh_ops;
>>  #endif
>>  
>> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
>>  void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>>  				unsigned char *log_buff);
>>  int pnv_pci_cfg_read(struct device_node *dn,
>
>
