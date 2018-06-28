Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GxP404PkzF1cc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 09:50:47 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SNnM98027130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:50:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jw7akcks1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:50:45 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Jun 2018 00:50:43 +0100
Subject: Re: [PATCH v2 08/10] Revert "cxl: Add cxl_slot_is_supported API"
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 vaibhav@linux.ibm.com, clombard@linux.ibm.com, felix@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
 <20180628100509.17413-9-fbarrat@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 29 Jun 2018 09:50:37 +1000
MIME-Version: 1.0
In-Reply-To: <20180628100509.17413-9-fbarrat@linux.ibm.com>
Message-Id: <b7cf4b11-357a-651e-bb45-88fa0fbb843a@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/06/18 20:05, Frederic Barrat wrote:
> Remove abandonned capi support for the Mellanox CX4.
> 
> This reverts commit 4e56f858bdde5cbfb70f61baddfaa56a8ed851bf.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/cxl/pci.c | 37 -------------------------------------
>   include/misc/cxl.h     | 15 ---------------
>   2 files changed, 52 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 193ff22f610b..0ca818396524 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1808,43 +1808,6 @@ int cxl_slot_is_switched(struct pci_dev *dev)
>   	return (depth > CXL_MAX_PCIEX_PARENT);
>   }
>   
> -bool cxl_slot_is_supported(struct pci_dev *dev, int flags)
> -{
> -	if (!cpu_has_feature(CPU_FTR_HVMODE))
> -		return false;
> -
> -	if ((flags & CXL_SLOT_FLAG_DMA) && (!pvr_version_is(PVR_POWER8NVL))) {
> -		/*
> -		 * CAPP DMA mode is technically supported on regular P8, but
> -		 * will EEH if the card attempts to access memory < 4GB, which
> -		 * we cannot realistically avoid. We might be able to work
> -		 * around the issue, but until then return unsupported:
> -		 */
> -		return false;
> -	}
> -
> -	if (cxl_slot_is_switched(dev))
> -		return false;
> -
> -	/*
> -	 * XXX: This gets a little tricky on regular P8 (not POWER8NVL) since
> -	 * the CAPP can be connected to PHB 0, 1 or 2 on a first come first
> -	 * served basis, which is racy to check from here. If we need to
> -	 * support this in future we might need to consider having this
> -	 * function effectively reserve it ahead of time.
> -	 *
> -	 * Currently, the only user of this API is the Mellanox CX4, which is
> -	 * only supported on P8NVL due to the above mentioned limitation of
> -	 * CAPP DMA mode and therefore does not need to worry about this. If the
> -	 * issue with CAPP DMA mode is later worked around on P8 we might need
> -	 * to revisit this.
> -	 */
> -
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(cxl_slot_is_supported);
> -
> -
>   static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   {
>   	struct cxl *adapter;
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index 74da2e440763..ea9ff4a1a9ca 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -24,21 +24,6 @@
>    * generic PCI API. This API is agnostic to the actual AFU.
>    */
>   
> -#define CXL_SLOT_FLAG_DMA 0x1
> -
> -/*
> - * Checks if the given card is in a cxl capable slot. Pass CXL_SLOT_FLAG_DMA if
> - * the card requires CAPP DMA mode to also check if the system supports it.
> - * This is intended to be used by bi-modal devices to determine if they can use
> - * cxl mode or if they should continue running in PCI mode.
> - *
> - * Note that this only checks if the slot is cxl capable - it does not
> - * currently check if the CAPP is currently available for chips where it can be
> - * assigned to different PHBs on a first come first serve basis (i.e. P8)
> - */
> -bool cxl_slot_is_supported(struct pci_dev *dev, int flags);
> -
> -
>   /* Get the AFU associated with a pci_dev */
>   struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
