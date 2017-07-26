Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHJPf39H8zDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 12:06:30 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v190so15950205pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 19:06:30 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <mopsfelder@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170718172220.9954-1-mopsfelder@gmail.com>
 <c570cffb-f713-22d9-ebf7-46d752d562be@gmail.com>
 <20170725094439.7859c41c@w520.home>
Message-ID: <56e79980-8935-097f-86f8-065d7b55f535@ozlabs.ru>
Date: Wed, 26 Jul 2017 12:06:23 +1000
MIME-Version: 1.0
In-Reply-To: <20170725094439.7859c41c@w520.home>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/07/17 01:44, Alex Williamson wrote:
> [cc +Alexey, David]
> 
> Any comments from the usual suspects for vfio/spapr?  Thanks,

[trying once again as mailists rejected the previous response due to broken
outgoing mail encoding config in my thunderbird]

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Having EEH + VFIO_PCI and not having VFIO_SPAPR_EEH does not make practical
sense and won't be seen in the wild so EEH + VFIO should enforce
VFIO_SPAPR_EEH but this is for another patch.


> 
> Alex
> 
> On Tue, 25 Jul 2017 10:56:38 -0300
> Murilo Opsfelder Araújo <mopsfelder@gmail.com> wrote:
> 
>> On 07/18/2017 02:22 PM, Murilo Opsfelder Araujo wrote:
>>> When CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n, build fails with the
>>> following:
>>>
>>>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
>>>     vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_eeh_release'
>>>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
>>>     vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_eeh_open'
>>>
>>> In this case, vfio_pci.c should use the empty definitions of
>>> vfio_spapr_pci_eeh_open and vfio_spapr_pci_eeh_release functions.
>>>
>>> This patch fixes it by guarding these function definitions with
>>> CONFIG_VFIO_SPAPR_EEH, the symbol that controls whether vfio_spapr_eeh.c is
>>> built, which is where the non-empty versions of these functions are. We need to
>>> make use of IS_ENABLED() macro because CONFIG_VFIO_SPAPR_EEH is a tristate
>>> option.
>>>
>>> This issue was found during a randconfig build. Logs are here:
>>>
>>>     http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/
>>>
>>> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
>>> ---
>>>
>>> Changes from v1:
>>> - Rebased on top of next-20170718.  
>>
>> Hi, Alex.
>>
>> Are you applying this?
>>
>> Thanks!
>>
> 


-- 
Alexey
