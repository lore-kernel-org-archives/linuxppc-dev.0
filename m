Return-Path: <alexdeucher@gmail.com>
Received: from mail-vb0-x232.google.com (mail-vb0-x232.google.com
 [IPv6:2607:f8b0:400c:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1A512C0189
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 06:17:26 +1000 (EST)
Received: by mail-vb0-f50.google.com with SMTP id w15so1577572vbb.23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 13:17:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4TDYrNZthVMkFF0E-U5bt31=WQvO_RN6xQLEnq7yOaWw@mail.gmail.com>
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1365685994-32603-3-git-send-email-lucaskt@linux.vnet.ibm.com>
 <CAErSpo7vxSJix83DQcsARPWYWbx8UGxQ9FN61OtEJrEv7GhK=g@mail.gmail.com>
 <516E97A9.7050102@linux.vnet.ibm.com>
 <CADnq5_MA6T0Qu61_WxkHnAJc_PmR+un6W-rfHUVecjWydoXHVw@mail.gmail.com>
 <CAErSpo4TDYrNZthVMkFF0E-U5bt31=WQvO_RN6xQLEnq7yOaWw@mail.gmail.com>
Date: Wed, 17 Apr 2013 16:17:22 -0400
Message-ID: <CADnq5_MvDfziNtWMdUxfxFV_iRuLdAhfT6diZmL9n2xf2K7WHw@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] radeon: use max_bus_speed to activate gen2 speeds
From: Alex Deucher <alexdeucher@gmail.com>
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

On Wed, Apr 17, 2013 at 4:11 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Apr 17, 2013 at 2:04 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Wed, Apr 17, 2013 at 8:38 AM, Lucas Kannebley Tavares
>> <lucaskt@linux.vnet.ibm.com> wrote:
>>> On 04/12/2013 01:38 PM, Bjorn Helgaas wrote:
>>>>
>>>> On Thu, Apr 11, 2013 at 7:13 AM, Lucas Kannebley Tavares
>>>> <lucaskt@linux.vnet.ibm.com>  wrote:
>>>>>
>>>>> radeon currently uses a drm function to get the speed capabilities for
>>>>> the bus. However, this is a non-standard method of performing this
>>>>> detection and this patch changes it to use the max_bus_speed attribute.
>>>>> ---
>>>>>   drivers/gpu/drm/radeon/evergreen.c |    9 ++-------
>>>>>   drivers/gpu/drm/radeon/r600.c      |    8 +-------
>>>>>   drivers/gpu/drm/radeon/rv770.c     |    8 +-------
>>>>>   3 files changed, 4 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/radeon/evergreen.c
>>>>> b/drivers/gpu/drm/radeon/evergreen.c
>>>>> index 305a657..3291f62 100644
>>>>> --- a/drivers/gpu/drm/radeon/evergreen.c
>>>>> +++ b/drivers/gpu/drm/radeon/evergreen.c
>>>>> @@ -3855,8 +3855,7 @@ void evergreen_fini(struct radeon_device *rdev)
>>>>>
>>>>>   void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
>>>>>   {
>>>>> -       u32 link_width_cntl, speed_cntl, mask;
>>>>> -       int ret;
>>>>> +       u32 link_width_cntl, speed_cntl;
>>>>>
>>>>>          if (radeon_pcie_gen2 == 0)
>>>>>                  return;
>>>>> @@ -3871,11 +3870,7 @@ void evergreen_pcie_gen2_enable(struct
>>>>> radeon_device *rdev)
>>>>>          if (ASIC_IS_X2(rdev))
>>>>>                  return;
>>>>>
>>>>> -       ret = drm_pcie_get_speed_cap_mask(rdev->ddev,&mask);
>>>>> -       if (ret != 0)
>>>>> -               return;
>>>>> -
>>>>> -       if (!(mask&  DRM_PCIE_SPEED_50))
>>>>>
>>>>> +       if (rdev->pdev->bus->max_bus_speed<  PCIE_SPEED_5_0GT)
>>>>
>>>>
>>>> For devices on a root bus, we previously dereferenced a NULL pointer
>>>> in drm_pcie_get_speed_cap_mask() because pdev->bus->self is NULL on a
>>>> root bus.  (I think this is the original problem you tripped over,
>>>> Lucas.)
>>>>
>>>> These patches fix that problem.  On pseries, where the device *is* on
>>>> a root bus, your patches set max_bus_speed so this will work as
>>>> expected.  On most other systems, max_bus_speed for root buses will be
>>>> PCI_SPEED_UNKNOWN (set in pci_alloc_bus() and never updated because
>>>> most arches don't have code like the pseries code you're adding).
>>>>
>>>> PCI_SPEED_UNKNOWN = 0xff, so if we see another machine with a GPU on
>>>> the root bus, we'll attempt to enable Gen2 on the device even though
>>>> we have no idea what the bus will support.
>>>>
>>>> That's why I originally suggested skipping the Gen2 stuff if
>>>> "max_bus_speed == PCI_SPEED_UNKNOWN".  I was just being conservative,
>>>> thinking that it's better to have a functional but slow GPU rather
>>>> than the unknown (to me) effects of enabling Gen2 on a link that might
>>>> not support it.  But I'm fine with this being either way.
>>>
>>>
>>> You're right here, of course. I'll test for it being different from 5_0GT
>>> and 8_0GT instead. Though at some point I suppose someone will want to
>>> tackle Gen3 speeds.
>>
>> drm_pcie_get_speed_cap_mask() actually checked the pci bridge to see
>> what speeds it supported.  If the new code doesn't actually check the
>> bridge caps then the new code does not seem like a valid replacement
>> unless I'm missing something.
>
> The max_bus_speed in struct pci_bus is set in pci_set_bus_speed()
> based on the PCIe, PCI-X, or AGP capabilities.  This happens when we
> enumerate the bridge device.  Or, in this case, Lucas added
> powerpc-specific code to set max_bus_speed for the root bus based on
> platform-specific host bridge knowledge.
>
> So it still does check the PCI bridge capabilities, just not as
> directly as it did before.

Ah, ok.  Thanks.  The previous comments about PCI_SPEED_UNKNOWN being
set in pci_alloc_bus() and never updated confused me.

Alex
