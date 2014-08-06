Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A3671A071A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 23:05:51 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id rd3so3413923pab.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Aug 2014 06:05:48 -0700 (PDT)
Message-ID: <53E22827.2000204@ozlabs.ru>
Date: Wed, 06 Aug 2014 23:05:43 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/4] drivers/vfio: Enable VFIO if EEH is not supported
References: <1407318545-17554-1-git-send-email-gwshan@linux.vnet.ibm.com>	
 <1407318545-17554-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407329433.316.80.camel@ul30vt.home>
In-Reply-To: <1407329433.316.80.camel@ul30vt.home>
Content-Type: text/plain; charset=koi8-r
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2014 10:50 PM, Alex Williamson wrote:
> On Wed, 2014-08-06 at 19:49 +1000, Gavin Shan wrote:
>> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> The existing vfio_pci_open() fails upon error returned from
>> vfio_spapr_pci_eeh_open(), which breaks POWER7's P5IOC2 PHB
>> support which this patch brings back.
>>
>> The patch fixes the issue by dropping the return value of
>> vfio_spapr_pci_eeh_open().
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>> v3: Drop return value of vfio_spapr_pci_eeh_open()
>> ---
>>  drivers/vfio/pci/vfio_pci.c   | 6 +-----
>>  drivers/vfio/vfio_spapr_eeh.c | 4 ++--
>>  include/linux/vfio.h          | 5 ++---
>>  3 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index e2ee80f..32d69c8 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -178,11 +178,7 @@ static int vfio_pci_open(void *device_data)
>>  		if (ret)
>>  			goto error;
>>  
>> -		ret = vfio_spapr_pci_eeh_open(vdev->pdev);
>> -		if (ret) {
>> -			vfio_pci_disable(vdev);
>> -			goto error;
>> -		}
>> +		vfio_spapr_pci_eeh_open(vdev->pdev);
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
>> index 4779cac..86dfceb 100644
>> --- a/drivers/vfio/vfio_spapr_eeh.c
>> +++ b/drivers/vfio/vfio_spapr_eeh.c
>> @@ -19,9 +19,9 @@
>>  #define DRIVER_DESC	"VFIO IOMMU SPAPR EEH"
>>  
>>  /* We might build address mapping here for "fast" path later */
>> -int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>> +void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>  {
>> -	return eeh_dev_open(pdev);
>> +	eeh_dev_open(pdev);
> 
> Wasn't there some intent to provide a warning message, that would now be
> done here?  Has that idea been dropped?


Comrade Gavin just forgot it :)

Gavin, please add it. Thanks!



> 
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
>>  
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index 224128a..d320411 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -100,15 +100,14 @@ extern long vfio_external_check_extension(struct vfio_group *group,
>>  
>>  struct pci_dev;
>>  #ifdef CONFIG_EEH
>> -extern int vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
>> +extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
>>  extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
>>  extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>>  				       unsigned int cmd,
>>  				       unsigned long arg);
>>  #else
>> -static inline int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>> +static inline void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>  {
>> -	return 0;
>>  }
>>  
>>  static inline void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
> 
> 
> 


-- 
Alexey
