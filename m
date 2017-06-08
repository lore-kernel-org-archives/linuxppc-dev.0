Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjvL13kCQzDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 15:36:25 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f27so3878031pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 22:36:25 -0700 (PDT)
Subject: Re: [PATCH] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: kbuild test robot <lkp@intel.com>,
 Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <201706080005.vXjRK5G3%fengguang.wu@intel.com>
 <a0d62075-cb00-c69b-7f39-95a3b53f4061@ozlabs.ru>
Message-ID: <9abe6f3d-f5ce-2c95-6e1f-b3d4f8273054@ozlabs.ru>
Date: Thu, 8 Jun 2017 15:36:18 +1000
MIME-Version: 1.0
In-Reply-To: <a0d62075-cb00-c69b-7f39-95a3b53f4061@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/17 15:35, Alexey Kardashevskiy wrote:
> Hi,
> 
> How did you manage to have CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n? "make
> oldconfig" fixes this to CONFIG_VFIO_SPAPR_EEH=y.


Also, the attached config has "CONFIG_VFIO_SPAPR_EEH=m" and cannot produce
the error below, what am I missing here?



> 
> 
> 
> On 08/06/17 02:31, kbuild test robot wrote:
>> Hi Murilo,
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.12-rc4 next-20170607]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Murilo-Opsfelder-Araujo/include-linux-vfio-h-Guard-powerpc-specific-functions-with-CONFIG_VFIO_SPAPR_EEH/20170607-000643
>> config: powerpc-allmodconfig (attached as .config)
>> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=powerpc 
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/vfio/vfio_spapr_eeh.c:22:6: error: redefinition of 'vfio_spapr_pci_eeh_open'
>>     void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>          ^~~~~~~~~~~~~~~~~~~~~~~
>>    In file included from drivers/vfio/vfio_spapr_eeh.c:14:0:
>>    include/linux/vfio.h:160:20: note: previous definition of 'vfio_spapr_pci_eeh_open' was here
>>     static inline void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>                        ^~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/vfio/vfio_spapr_eeh.c:28:6: error: redefinition of 'vfio_spapr_pci_eeh_release'
>>     void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>    In file included from drivers/vfio/vfio_spapr_eeh.c:14:0:
>>    include/linux/vfio.h:164:20: note: previous definition of 'vfio_spapr_pci_eeh_release' was here
>>     static inline void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/vfio/vfio_spapr_eeh.c:34:6: error: redefinition of 'vfio_spapr_iommu_eeh_ioctl'
>>     long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>    In file included from drivers/vfio/vfio_spapr_eeh.c:14:0:
>>    include/linux/vfio.h:168:20: note: previous definition of 'vfio_spapr_iommu_eeh_ioctl' was here
>>     static inline long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> vim +/vfio_spapr_pci_eeh_open +22 drivers/vfio/vfio_spapr_eeh.c
>>
>> 1b69be5e Gavin Shan           2014-06-10  16  
>> 89a2edd6 Alexey Kardashevskiy 2014-08-08  17  #define DRIVER_VERSION	"0.1"
>> 89a2edd6 Alexey Kardashevskiy 2014-08-08  18  #define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
>> 89a2edd6 Alexey Kardashevskiy 2014-08-08  19  #define DRIVER_DESC	"VFIO IOMMU SPAPR EEH"
>> 89a2edd6 Alexey Kardashevskiy 2014-08-08  20  
>> 1b69be5e Gavin Shan           2014-06-10  21  /* We might build address mapping here for "fast" path later */
>> 9b936c96 Alexey Kardashevskiy 2014-08-08 @22  void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>> 1b69be5e Gavin Shan           2014-06-10  23  {
>> 9b936c96 Alexey Kardashevskiy 2014-08-08  24  	eeh_dev_open(pdev);
>> 1b69be5e Gavin Shan           2014-06-10  25  }
>> 92d18a68 Gavin Shan           2014-08-08  26  EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
>> 1b69be5e Gavin Shan           2014-06-10  27  
>> 1b69be5e Gavin Shan           2014-06-10 @28  void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
>> 1b69be5e Gavin Shan           2014-06-10  29  {
>> 1b69be5e Gavin Shan           2014-06-10  30  	eeh_dev_release(pdev);
>> 1b69be5e Gavin Shan           2014-06-10  31  }
>> 92d18a68 Gavin Shan           2014-08-08  32  EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_release);
>> 1b69be5e Gavin Shan           2014-06-10  33  
>> 1b69be5e Gavin Shan           2014-06-10 @34  long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>> 1b69be5e Gavin Shan           2014-06-10  35  				unsigned int cmd, unsigned long arg)
>> 1b69be5e Gavin Shan           2014-06-10  36  {
>> 1b69be5e Gavin Shan           2014-06-10  37  	struct eeh_pe *pe;
>>
>> :::::: The code at line 22 was first introduced by commit
>> :::::: 9b936c960f22954bfb89f2fefd8f96916bb42908 drivers/vfio: Enable VFIO if EEH is not supported
>>
>> :::::: TO: Alexey Kardashevskiy <aik@ozlabs.ru>
>> :::::: CC: Alex Williamson <alex.williamson@redhat.com>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
> 
> 


-- 
Alexey
