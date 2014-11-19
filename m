Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE4011A0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 12:16:27 +1100 (AEDT)
Message-ID: <546BEF40.70109@huawei.com>
Date: Wed, 19 Nov 2014 09:15:44 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support
 default IO/MEM resources
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <2732970.7HG94QvVBv@wuerfel> <546AF8D7.9010103@huawei.com>
 <2447172.ADYWdCTnMP@wuerfel> <546B317E.4090800@huawei.com>
 <20141118142354.GH12037@e106497-lin.cambridge.arm.com>
In-Reply-To: <20141118142354.GH12037@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "huxinwei@huawei.com" <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Yijing Wang <wangyijing0307@gmail.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/11/18 22:23, Liviu Dudau wrote:
> On Tue, Nov 18, 2014 at 11:46:06AM +0000, Yijing Wang wrote:
>> On 2014/11/18 17:36, Arnd Bergmann wrote:
>>> On Tuesday 18 November 2014 15:44:23 Yijing Wang wrote:
>>>> On 2014/11/17 18:08, Arnd Bergmann wrote:
>>>>> On Monday 17 November 2014 18:21:35 Yijing Wang wrote:
>>>>>> -       list_for_each_entry(window, resources, list)
>>>>>> -               if (window->res->flags & IORESOURCE_BUS) {
>>>>>> -                       found = true;
>>>>>> -                       break;
>>>>>> -               }
>>>>>> +       if (!resources) {
>>>>>> +               pci_add_resource(&default_res, &ioport_resource);
>>>>>> +               pci_add_resource(&default_res, &iomem_resource);
>>>>>> +               pci_add_resource(&default_res, &busn_resource);
>>>>>> +       } else {
>>>>>>
>>>>>
>>>>> Isn't it almost always wrong to do this? You are adding all of the
>>>>> I/O ports and memory to the host bridge, which will prevent you from
>>>>> adding another host bridge, and the iomem_resource normally
>>>>> includes a lot of addresses that are not accessible by the PCI host.
>>>>
>>>> Hi Arnd, pci host bridge windows are the ranges allow child devices to setup
>>>> from. Add all of IO/MEM here just a limit to child devices, no request for these
>>>> resources, so it won't hurt another host bridge. Some platforms have no dts or ACPI
>>>> report host bridge resources, in this case, we directly assign ioport/iomem_resources
>>>> as the root resources of PCI devices.
>>>
>>> But it would be wrong to allow hosts to allocate a device BAR that is not
>>> visible through the host bridge. I think we need to keep these separate
>>> from the general case: if you call any of the modern interfaces you have
>>> to provide the resources and a device. I notice that there is only one
>>> caller of pci_scan_bus_parented(), we should probably change that over to
>>> pci_scan_root_bus() or your new interface and remove the old one, but
>>> keep pci_scan_bus() as the only entry point for all of the legacy users
>>> that do not know about the resources.
>>
>> Ok, I will move this out of the generic interface.
> 
> My suggestion would actually be to trigger a warning/error if you detect that the resources
> are missing. That way we can force the drivers to clean up.

It make sense to me, thanks.

> 
> Best regards,
> Liviu
> 
>>
>> Thanks!
>> Yijing.
>>
>>>
>>> 	Arnd
>>>
>>> .
>>>
>>
>>
>> -- 
>> Thanks!
>> Yijing
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 


-- 
Thanks!
Yijing
