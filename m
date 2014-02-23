Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 929E22C0307
 for <linuxppc-dev@ozlabs.org>; Sun, 23 Feb 2014 15:53:10 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 22 Feb 2014 21:53:07 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0B8CD1FF003F
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Feb 2014 21:53:05 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1N4qXCv5439988
 for <linuxppc-dev@ozlabs.org>; Sun, 23 Feb 2014 05:52:33 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1N4r4uF022761
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Feb 2014 21:53:04 -0700
Date: Sun, 23 Feb 2014 12:52:50 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc/powernv: Cache PHB diag-data
Message-ID: <20140223045250.GA24324@shangw.(null)>
References: <1392983613-10090-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1392983613-10090-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1393012887.6771.94.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393012887.6771.94.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 22, 2014 at 07:01:27AM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2014-02-21 at 19:53 +0800, Gavin Shan wrote:
>> EEH core tries to recover from fenced PHB or frozen PE. Unfortunately,
>> the log isn't consistent with the site because enabling IO path for
>> the frozen PE before collecting log would ruin the site. The patch
>> solves the problem to cache the PHB diag-data in advance with the
>> help of additional flag PNV_PHB_FLAG_DIAG to pnv_phb::flags.
>
>Ok, so correct me if I'm wrong, but you are
>
>  - Collecting the diag data in get_state, as a sort of side effect
>(what happens if get_state is called multiple times ?)
>
>  - Dumping it later on
>

Yeah, the patch would have some problems when get_state gets called
for multiple times: the log could be much more than what we expected
in case that frozen PE#1 detected and in progress to handle it (we
don't dump it yet), frozen PE#2 detected. The log would include all
information for frozen PE#1 and PE#2 and it's not expected.

Another case is get_state called for multiple times on frozen PE#1
and we can check EEH_PE_ISOLATED to avoid diag-data over-writting.

I'm thinking of a new mechanism (please refer to the reply below).

>Any reason why we can't instead dump it immediately ? Also do we have a
>clean trigger for when we detect an error condition ? It can either be
>the result of an interrupt or a driver called get_state following an
>ffffffff. Are both path eventually going into the same function to
>handle a "new" error condition ? That's where I would both collect and
>dump the EEH state..
>

The reason I don't want dump it immediately is that I would keep
struct pnv_eeh_ops::get_log() to dump diag-data to guest in the
future.

The problem is that we have only one PHB diag-data instance in
struct pnv_phb::diag.blob[]. I'm thinking of to have each PE
to have diag-data for itself and the things would look like
followings. Ben, please comment :-)

- Extend "struct eeh_pe" to have a platform pointer (void *data).
  And we still collect diag-data in get_state() or next_error(),
  which will be dumped in pnv_eeh_ops->get_log(). The disadvantage
  could be lots of memory (extra 8KB usually) consumed by each PE
  instance.
- For PCI config accessors and informative (also dead PHB, dead
  P7IOC), we still use pnv_phb::diag.blob[].

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/eeh-ioda.c |   65 ++++++++++++++++++-----------
>>  arch/powerpc/platforms/powernv/pci.c      |   21 ++++++----
>>  arch/powerpc/platforms/powernv/pci.h      |    1 +
>>  3 files changed, 55 insertions(+), 32 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> index 04b4710..3ed8d22 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> @@ -114,6 +114,27 @@ DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
>>  			ioda_eeh_inbB_dbgfs_set, "0x%llx\n");
>>  #endif /* CONFIG_DEBUG_FS */
>>  
>> +static void ioda_eeh_phb_diag(struct pci_controller *hose)
>> +{
>> +	struct pnv_phb *phb = hose->private_data;
>> +	unsigned long flags;
>> +	long rc;
>> +
>> +	spin_lock_irqsave(&phb->lock, flags);
>> +
>> +	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>> +					 PNV_PCI_DIAG_BUF_SIZE);
>> +	if (rc == OPAL_SUCCESS) {
>> +		phb->flags |= PNV_PHB_FLAG_DIAG;
>> +	} else {
>> +		pr_warn("%s: Can't get diag-data for PHB#%x (%ld)\n",
>> +			__func__, hose->global_number, rc);
>> +		phb->flags &= ~PNV_PHB_FLAG_DIAG;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&phb->lock, flags);
>> +}
>> +
>>  /**
>>   * ioda_eeh_post_init - Chip dependent post initialization
>>   * @hose: PCI controller
>> @@ -272,6 +293,8 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
>>  			result |= EEH_STATE_DMA_ACTIVE;
>>  			result |= EEH_STATE_MMIO_ENABLED;
>>  			result |= EEH_STATE_DMA_ENABLED;
>> +		} else {
>> +			ioda_eeh_phb_diag(hose);
>>  		}
>>  
>>  		return result;
>> @@ -541,24 +564,13 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
>>  static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
>>  			    char *drv_log, unsigned long len)
>>  {
>> -	s64 ret;
>> +	struct pnv_phb *phb = pe->phb->private_data;
>>  	unsigned long flags;
>> -	struct pci_controller *hose = pe->phb;
>> -	struct pnv_phb *phb = hose->private_data;
>>  
>>  	spin_lock_irqsave(&phb->lock, flags);
>>  
>> -	ret = opal_pci_get_phb_diag_data2(phb->opal_id,
>> -			phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
>> -	if (ret) {
>> -		spin_unlock_irqrestore(&phb->lock, flags);
>> -		pr_warning("%s: Can't get log for PHB#%x-PE#%x (%lld)\n",
>> -			   __func__, hose->global_number, pe->addr, ret);
>> -		return -EIO;
>> -	}
>> -
>> -	/* The PHB diag-data is always indicative */
>> -	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
>> +	pnv_pci_dump_phb_diag_data(pe->phb, phb->diag.blob);
>> +	phb->flags &= ~PNV_PHB_FLAG_DIAG;
>>  
>>  	spin_unlock_irqrestore(&phb->lock, flags);
>>  
>> @@ -646,19 +658,11 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
>>  	}
>>  }
>>  
>> -static void ioda_eeh_phb_diag(struct pci_controller *hose)
>> +static void ioda_eeh_phb_diag_dump(struct pci_controller *hose)
>>  {
>>  	struct pnv_phb *phb = hose->private_data;
>> -	long rc;
>> -
>> -	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>> -					 PNV_PCI_DIAG_BUF_SIZE);
>> -	if (rc != OPAL_SUCCESS) {
>> -		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
>> -			    __func__, hose->global_number, rc);
>> -		return;
>> -	}
>>  
>> +	ioda_eeh_phb_diag(hose);
>>  	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
>>  }
>>  
>> @@ -778,7 +782,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>>  				pr_info("EEH: PHB#%x informative error "
>>  					"detected\n",
>>  					hose->global_number);
>> -				ioda_eeh_phb_diag(hose);
>> +				ioda_eeh_phb_diag_dump(hose);
>>  				ret = EEH_NEXT_ERR_NONE;
>>  			}
>>  
>> @@ -809,6 +813,17 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>>  		}
>>  
>>  		/*
>> +		 * EEH core will try recover from fenced PHB or
>> +		 * frozen PE. In the time for frozen PE, EEH core
>> +		 * enable IO path for that before collecting logs,
>> +		 * but it ruins the site. So we have to cache the
>> +		 * log in advance here.
>> +		 */
>> +		if (ret == EEH_NEXT_ERR_FROZEN_PE ||
>> +		    ret == EEH_NEXT_ERR_FENCED_PHB)
>> +			ioda_eeh_phb_diag(hose);
>> +
>> +		/*
>>  		 * If we have no errors on the specific PHB or only
>>  		 * informative error there, we continue poking it.
>>  		 * Otherwise, we need actions to be taken by upper
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index 437c37d..67b2254 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -259,11 +259,15 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
>>  void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>>  				unsigned char *log_buff)
>>  {
>> +	struct pnv_phb *phb = hose->private_data;
>>  	struct OpalIoPhbErrorCommon *common;
>>  
>>  	if (!hose || !log_buff)
>>  		return;
>>  
>> +	if (!(phb->flags & PNV_PHB_FLAG_DIAG))
>> +		return;
>> +
>>  	common = (struct OpalIoPhbErrorCommon *)log_buff;
>>  	switch (common->ioType) {
>>  	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
>> @@ -281,13 +285,19 @@ void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>>  static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
>>  {
>>  	unsigned long flags, rc;
>> -	int has_diag;
>> +	bool has_diag = false;
>>  
>>  	spin_lock_irqsave(&phb->lock, flags);
>>  
>> -	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>> -					 PNV_PCI_DIAG_BUF_SIZE);
>> -	has_diag = (rc == OPAL_SUCCESS);
>> +	if (!(phb->flags & PNV_PHB_FLAG_DIAG)) {
>> +		rc = opal_pci_get_phb_diag_data2(phb->opal_id,
>> +						 phb->diag.blob,
>> +						 PNV_PCI_DIAG_BUF_SIZE);
>> +		if (rc == OPAL_SUCCESS) {
>> +			phb->flags |= PNV_PHB_FLAG_DIAG;
>> +			has_diag = true;
>> +		}
>> +	}
>>  
>>  	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
>>  				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>> @@ -303,9 +313,6 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
>>  		 */
>>  		if (has_diag)
>>  			pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
>> -		else
>> -			pr_warning("PCI %d: No diag data available\n",
>> -				   phb->hose->global_number);
>>  	}
>>  
>>  	spin_unlock_irqrestore(&phb->lock, flags);
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index adeb3c4..153af9a 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -82,6 +82,7 @@ struct pnv_eeh_ops {
>>  #endif /* CONFIG_EEH */
>>  
>>  #define PNV_PHB_FLAG_EEH	(1 << 0)
>> +#define PNV_PHB_FLAG_DIAG	(1 << 1)
>>  
>>  struct pnv_phb {
>>  	struct pci_controller	*hose;
>
>
