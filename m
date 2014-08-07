Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C56931A0873
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:10:17 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 12:10:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 566FF3578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:10:11 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s772AjOc13434934
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 12:10:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s772AAjk028039
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 12:10:11 +1000
Date: Thu, 7 Aug 2014 12:10:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v3 4/4] drivers/vfio: Enable VFIO if EEH is not supported
Message-ID: <20140807021007.GA5230@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407318545-17554-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407318545-17554-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407329433.316.80.camel@ul30vt.home> <53E22827.2000204@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E22827.2000204@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2014 at 11:05:43PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2014 10:50 PM, Alex Williamson wrote:
>> On Wed, 2014-08-06 at 19:49 +1000, Gavin Shan wrote:
>>> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> The existing vfio_pci_open() fails upon error returned from
>>> vfio_spapr_pci_eeh_open(), which breaks POWER7's P5IOC2 PHB
>>> support which this patch brings back.
>>>
>>> The patch fixes the issue by dropping the return value of
>>> vfio_spapr_pci_eeh_open().
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>> v3: Drop return value of vfio_spapr_pci_eeh_open()
>>> ---
>>>  drivers/vfio/pci/vfio_pci.c   | 6 +-----
>>>  drivers/vfio/vfio_spapr_eeh.c | 4 ++--
>>>  include/linux/vfio.h          | 5 ++---
>>>  3 files changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>>> index e2ee80f..32d69c8 100644
>>> --- a/drivers/vfio/pci/vfio_pci.c
>>> +++ b/drivers/vfio/pci/vfio_pci.c
>>> @@ -178,11 +178,7 @@ static int vfio_pci_open(void *device_data)
>>>  		if (ret)
>>>  			goto error;
>>>  
>>> -		ret = vfio_spapr_pci_eeh_open(vdev->pdev);
>>> -		if (ret) {
>>> -			vfio_pci_disable(vdev);
>>> -			goto error;
>>> -		}
>>> +		vfio_spapr_pci_eeh_open(vdev->pdev);
>>>  	}
>>>  
>>>  	return 0;
>>> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
>>> index 4779cac..86dfceb 100644
>>> --- a/drivers/vfio/vfio_spapr_eeh.c
>>> +++ b/drivers/vfio/vfio_spapr_eeh.c
>>> @@ -19,9 +19,9 @@
>>>  #define DRIVER_DESC	"VFIO IOMMU SPAPR EEH"
>>>  
>>>  /* We might build address mapping here for "fast" path later */
>>> -int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>> +void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>>  {
>>> -	return eeh_dev_open(pdev);
>>> +	eeh_dev_open(pdev);
>> 
>> Wasn't there some intent to provide a warning message, that would now be
>> done here?  Has that idea been dropped?
>
>
>Comrade Gavin just forgot it :)
>
>Gavin, please add it. Thanks!
>

Sure, I'll add following warning message in eeh_dev_open() in
separate patch in v4 in case nobody objects.

int eeh_dev_open(struct pci_dev *pdev)
{
        :
        /* No EEH device or PE ? */
        edev = pci_dev_to_eeh_dev(pdev);
        if (!edev || !edev->pe) {
		pr_warn_once("%s: Device %s not supported\n",
			     __func__, pci_name(pdev));
                goto out;
        }
        :
}

Thanks,
Gavin

>
>
>> 
>>>  }
>>>  EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
>>>  
>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>> index 224128a..d320411 100644
>>> --- a/include/linux/vfio.h
>>> +++ b/include/linux/vfio.h
>>> @@ -100,15 +100,14 @@ extern long vfio_external_check_extension(struct vfio_group *group,
>>>  
>>>  struct pci_dev;
>>>  #ifdef CONFIG_EEH
>>> -extern int vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
>>> +extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
>>>  extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
>>>  extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>>>  				       unsigned int cmd,
>>>  				       unsigned long arg);
>>>  #else
>>> -static inline int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>> +static inline void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>>  {
>>> -	return 0;
>>>  }
>>>  
>>>  static inline void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
>> 
>> 
>> 
>
>
>-- 
>Alexey
>
