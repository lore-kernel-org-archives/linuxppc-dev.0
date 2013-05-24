Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 859F32C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 13:14:52 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id y11so3651476pdj.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 20:14:50 -0700 (PDT)
Message-ID: <519EDB22.1050509@ozlabs.ru>
Date: Fri, 24 May 2013 13:14:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/5 v2] VFIO PPC64: add VFIO support on POWERPC64
References: <1369107191-28547-1-git-send-email-aik@ozlabs.ru>
 <1369320984.2646.135.camel@ul30vt.home>
In-Reply-To: <1369320984.2646.135.camel@ul30vt.home>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2013 12:56 AM, Alex Williamson wrote:
> On Tue, 2013-05-21 at 13:33 +1000, Alexey Kardashevskiy wrote:
>> The series adds support for VFIO on POWERPC in user space (such as QEMU).
>> The in-kernel real mode IOMMU support is added by another series posted
>> separately.
>>
>> As the first and main aim of this series is the POWERNV platform support,
>> the "Enable on POWERNV platform" patch goes first and introduces an API
>> to be used by the VFIO IOMMU driver. The "Enable on pSeries platform" patch
>> simply registers PHBs in the IOMMU subsystem and expects the API to be present,
>> it enables VFIO support in fully emulated QEMU guests.
>>
>> The main change is that this series was changed and tested against v3.10-rc1.
>> It also contains some bugfixes which are mentioned (if any) in the patch messages.
>>
>> Alexey Kardashevskiy (3):
>>   powerpc/vfio: Enable on POWERNV platform
>>   powerpc/vfio: Implement IOMMU driver for VFIO
>>   powerpc/vfio: Enable on pSeries platform
>>
>>  Documentation/vfio.txt                      |   63 +++++
>>  arch/powerpc/include/asm/iommu.h            |   26 ++
>>  arch/powerpc/kernel/iommu.c                 |  323 +++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/pci-ioda.c   |    1 +
>>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |    5 +-
>>  arch/powerpc/platforms/powernv/pci.c        |    2 +
>>  arch/powerpc/platforms/pseries/iommu.c      |    4 +
>>  drivers/iommu/Kconfig                       |    8 +
>>  drivers/vfio/Kconfig                        |    6 +
>>  drivers/vfio/Makefile                       |    1 +
>>  drivers/vfio/vfio.c                         |    1 +
>>  drivers/vfio/vfio_iommu_spapr_tce.c         |  377 +++++++++++++++++++++++++++
>>  include/uapi/linux/vfio.h                   |   34 +++
>>  13 files changed, 850 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c
>>
> 
> These look ok to me, how do you want to integrate them?  Should I
> provide Acks on patches 2 & 3 and let them get pushed through the ppc
> tree or should I wait for patch 1 then push 2 & 3 through my tree?

Please ack on 2 & 3 and Ben will merge all three into his tree. Thanks!



-- 
Alexey
