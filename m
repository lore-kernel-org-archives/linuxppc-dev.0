Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk5Pk1w4vzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:10:18 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id f27so5112099pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 06:10:17 -0700 (PDT)
Subject: Re: [PATCH] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
To: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <mopsfelder@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
References: <201706080005.vXjRK5G3%fengguang.wu@intel.com>
 <a0d62075-cb00-c69b-7f39-95a3b53f4061@ozlabs.ru>
 <871squemf2.fsf@concordia.ellerman.id.au>
 <e426fff2-ad3e-64c6-7c6b-2c37c16c00c1@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <dc26bfd2-9ba6-b3bd-afa9-ed0d801757b7@ozlabs.ru>
Date: Thu, 8 Jun 2017 23:10:10 +1000
MIME-Version: 1.0
In-Reply-To: <e426fff2-ad3e-64c6-7c6b-2c37c16c00c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/17 22:45, Murilo Opsfelder Araújo wrote:
> On 06/08/2017 08:41 AM, Michael Ellerman wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>
>>> Hi,
>>>
>>> How did you manage to have CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n? "make
>>> oldconfig" fixes this to CONFIG_VFIO_SPAPR_EEH=y.
>>
>> Hmm, Murilo did you confirm the bug still happens on upstream with that
>> rand config?
> 
> Yes, it's still happening with next-20170607.


The config you attached in the first mail has CONFIG_VFIO_SPAPR_EEH=m, here
is my confusion. The config from the link below does not have KVM_BOOK3S_64
which selects SPAPR_TCE_IOMMU and which in turn selects VFIO_IOMMU_SPAPR_TCE.

So
https://github.com/0day-ci/linux/commit/36ed1ddb05e132aa3cfbb610f0f8402a0774da12
looks correct.



> 
> For me, `make oldconfig` hasn't changed it to CONFIG_VFIO_SPAPR_EEH=y. See:
> 
>     $ git clean -dfxq
>     $ git reset --hard origin/master
>     HEAD is now at 8d1b80c Add linux-next specific files for 20170607
> 
>     $ curl http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/config/ -o .config
>     $ grep -E 'EEH|SPAPR' .config
>     CONFIG_EEH=y
>     # CONFIG_SPAPR_TCE_IOMMU is not set
> 
>     $ yes '' | make oldconfig
> 
>     $ grep -E 'EEH|SPAPR' .config
>     CONFIG_EEH=y
>     # CONFIG_SPAPR_TCE_IOMMU is not set
> 
>     $ make -j 160 ARCH=powerpc
>     ...
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
>     vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_eeh_release'
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
>     vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_eeh_open'
>     make: *** [vmlinux] Error 1
> 


-- 
Alexey
