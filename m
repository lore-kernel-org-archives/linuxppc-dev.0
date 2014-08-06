Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A5901A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 16:57:52 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 12:27:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3DFE41258017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:27:49 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s766xruf65274062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:29:53 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s766viYq023116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:27:45 +0530
Date: Wed, 6 Aug 2014 16:57:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2 2/4] vfio: spapr: Fix build error
Message-ID: <20140806065738.GA25792@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
 <1407293313-24894-3-git-send-email-aik@ozlabs.ru>
 <1407294770.316.76.camel@ul30vt.home>
 <20140806035413.GA7681@shangw> <53E1CC39.9000401@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53E1CC39.9000401@ozlabs.ru>
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

On Wed, Aug 06, 2014 at 04:33:29PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2014 01:54 PM, Gavin Shan wrote:
>> On Tue, Aug 05, 2014 at 09:12:50PM -0600, Alex Williamson wrote:
>>> On Wed, 2014-08-06 at 12:48 +1000, Alexey Kardashevskiy wrote:
>>>> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>
>>>> The VFIO related components could be built as dynamic modules.
>>>> Unfortunately, CONFIG_EEH can't be configured to "m". The patch
>>>> fixes the build errors when configuring VFIO related components
>>>> as dynamic modules as follows:
>>>>
>>>>   CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
>>>> In file included from drivers/vfio/vfio.c:33:0:
>>>> include/linux/vfio.h:101:43: warning: =E2=80=98struct pci_dev=E2=80=99=
 declared \
>>>> inside parameter list [enabled by default]
>>>> :
>>>>   WRAP    arch/powerpc/boot/zImage.pseries
>>>>   WRAP    arch/powerpc/boot/zImage.maple
>>>>   WRAP    arch/powerpc/boot/zImage.pmac
>>>>   WRAP    arch/powerpc/boot/zImage.epapr
>>>>   MODPOST 1818 modules
>>>> ERROR: ".vfio_spapr_iommu_eeh_ioctl" [drivers/vfio/vfio_iommu_spapr_=
tce.ko]\
>>>> undefined!
>>>> ERROR: ".vfio_spapr_pci_eeh_open" [drivers/vfio/pci/vfio-pci.ko] und=
efined!
>>>> ERROR: ".vfio_spapr_pci_eeh_release" [drivers/vfio/pci/vfio-pci.ko] =
undefined!
>>>>
>>>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>> [removed include "pci.h" in vfio.c]
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v2:
>>>> * removed #include <linux/pci.h> from vfio.c and tested
>>=20
>> Appreciated for Alexey's help on it :)
>
>
>My bad, that was wrong actually, we still need this:
>

Yep, no worries. I'll fix it in next revision.

>diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>index 25a0fbd..224128a 100644
>--- a/include/linux/vfio.h
>+++ b/include/linux/vfio.h
>@@ -98,6 +98,7 @@ extern int vfio_external_user_iommu_id(struct vfio_gro=
up
>*group);
> extern long vfio_external_check_extension(struct vfio_group *group,
>                                          unsigned long arg);
>
>+struct pci_dev;
> #ifdef CONFIG_EEH
> extern int vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
> extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
>
>
>
>Otherwise it is "warning: =E2=80=98struct pci_dev=E2=80=99 declared insi=
de parameter list".
>For some reason I only see this warning when backporting this patch to 3=
.10
>and I do not see it in 3.16-rc7, I guess pci.h gets included somewhere.
>
>
>>=20
>>>
>>> I also commented regarding the ifdef around all of vfio_spapr_eeh.c:
>>>
>>>        Why not add a new CONFIG_VFIO_SPAPR_EEH option to handle this
>>>        instead?
>>>
>>> Did you disagree?  The ifdef is pretty ugly.
>>>
>>=20
>> I'll introduce CONFIG_VFIO_SPAPR_EEH.
>
>
>So, Gavin, then the patchset is yours (again), ok?
>

Sure. Thanks for your help, Alexey. I was busy with other
bugs with higher priority recently. I'm working on this.

Thanks,
Gavin

>
>
>
>> Thanks,
>> Gavin
>>=20
>>>> ---
>>>>  drivers/vfio/Makefile         | 4 ++--
>>>>  drivers/vfio/vfio_spapr_eeh.c | 6 ++++++
>>>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
>>>> index 50e30bc..4891cca 100644
>>>> --- a/drivers/vfio/Makefile
>>>> +++ b/drivers/vfio/Makefile
>>>> @@ -1,5 +1,5 @@
>>>>  obj-$(CONFIG_VFIO) +=3D vfio.o
>>>>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o
>>>> -obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o
>>>> -obj-$(CONFIG_EEH) +=3D vfio_spapr_eeh.o
>>>> +obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o \
>>>> +				      vfio_spapr_eeh.o
>>>>  obj-$(CONFIG_VFIO_PCI) +=3D pci/
>>>> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr=
_eeh.c
>>>> index f834b4c..1a93e83 100644
>>>> --- a/drivers/vfio/vfio_spapr_eeh.c
>>>> +++ b/drivers/vfio/vfio_spapr_eeh.c
>>>> @@ -14,15 +14,19 @@
>>>>  #include <asm/eeh.h>
>>>> =20
>>>>  /* We might build address mapping here for "fast" path later */
>>>> +#ifdef CONFIG_EEH
>>>> +
>>>>  int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
>>>>  {
>>>>  	return eeh_dev_open(pdev);
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
>>>> =20
>>>>  void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
>>>>  {
>>>>  	eeh_dev_release(pdev);
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_release);
>>>> =20
>>>>  long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>>>>  				unsigned int cmd, unsigned long arg)
>>>> @@ -85,3 +89,5 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group=
 *group,
>>>> =20
>>>>  	return ret;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(vfio_spapr_iommu_eeh_ioctl);
>>>> +#endif /* CONFIG_EEH */
>>>
>>>
>>>
>>=20
>
>
>--=20
>Alexey
>
