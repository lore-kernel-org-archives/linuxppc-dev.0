Return-Path: <airlied@gmail.com>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32B452C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 13:17:27 +1000 (EST)
Received: by mail-ee0-f48.google.com with SMTP id b15so17408eek.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 20:17:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7vxSJix83DQcsARPWYWbx8UGxQ9FN61OtEJrEv7GhK=g@mail.gmail.com>
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1365685994-32603-3-git-send-email-lucaskt@linux.vnet.ibm.com>
 <CAErSpo7vxSJix83DQcsARPWYWbx8UGxQ9FN61OtEJrEv7GhK=g@mail.gmail.com>
Date: Tue, 16 Apr 2013 13:17:23 +1000
Message-ID: <CAPM=9tywoBnCsY-WZp4_owidXZ8nLNvizagjfi-_hWkt8uKCjA@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] radeon: use max_bus_speed to activate gen2 speeds
From: Dave Airlie <airlied@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>
>> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
>> index 305a657..3291f62 100644
>> --- a/drivers/gpu/drm/radeon/evergreen.c
>> +++ b/drivers/gpu/drm/radeon/evergreen.c
>> @@ -3855,8 +3855,7 @@ void evergreen_fini(struct radeon_device *rdev)
>>
>>  void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
>>  {
>> -       u32 link_width_cntl, speed_cntl, mask;
>> -       int ret;
>> +       u32 link_width_cntl, speed_cntl;
>>
>>         if (radeon_pcie_gen2 == 0)
>>                 return;
>> @@ -3871,11 +3870,7 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
>>         if (ASIC_IS_X2(rdev))
>>                 return;
>>
>> -       ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
>> -       if (ret != 0)
>> -               return;
>> -
>> -       if (!(mask & DRM_PCIE_SPEED_50))
>> +       if (rdev->pdev->bus->max_bus_speed < PCIE_SPEED_5_0GT)
>
> For devices on a root bus, we previously dereferenced a NULL pointer
> in drm_pcie_get_speed_cap_mask() because pdev->bus->self is NULL on a
> root bus.  (I think this is the original problem you tripped over,
> Lucas.)
>
> These patches fix that problem.  On pseries, where the device *is* on
> a root bus, your patches set max_bus_speed so this will work as
> expected.  On most other systems, max_bus_speed for root buses will be
> PCI_SPEED_UNKNOWN (set in pci_alloc_bus() and never updated because
> most arches don't have code like the pseries code you're adding).
>
> PCI_SPEED_UNKNOWN = 0xff, so if we see another machine with a GPU on
> the root bus, we'll attempt to enable Gen2 on the device even though
> we have no idea what the bus will support.
>
> That's why I originally suggested skipping the Gen2 stuff if
> "max_bus_speed == PCI_SPEED_UNKNOWN".  I was just being conservative,
> thinking that it's better to have a functional but slow GPU rather
> than the unknown (to me) effects of enabling Gen2 on a link that might
> not support it.  But I'm fine with this being either way.
>
> It would be nice if we could get rid of drm_pcie_get_speed_cap_mask()
> altogether.  It is exported, but I have no idea of anybody else uses
> it.  Maybe it could at least be marked __deprecated now?
>
> I don't know who should take these patches.  They don't touch
> drivers/pci, but I'd be happy to push them, given the appropriate ACKs
> from DRM and powerpc folks.
>

Acked-by: Dave Airlie <airlied@redhat.com>

I'm happy to see these go via pci tree to avoid interdependent trees.

Dave.
