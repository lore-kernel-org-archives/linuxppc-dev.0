Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC2921A069B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 18:45:03 +1100 (AEDT)
Message-ID: <546AF8D7.9010103@huawei.com>
Date: Tue, 18 Nov 2014 15:44:23 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support
 default IO/MEM resources
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
 <2732970.7HG94QvVBv@wuerfel>
In-Reply-To: <2732970.7HG94QvVBv@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>, Suravee.Suthikulpanit@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, Yijing Wang <wangyijing0307@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/11/17 18:08, Arnd Bergmann wrote:
> On Monday 17 November 2014 18:21:35 Yijing Wang wrote:
>> -       list_for_each_entry(window, resources, list)
>> -               if (window->res->flags & IORESOURCE_BUS) {
>> -                       found = true;
>> -                       break;
>> -               }
>> +       if (!resources) {
>> +               pci_add_resource(&default_res, &ioport_resource);
>> +               pci_add_resource(&default_res, &iomem_resource);
>> +               pci_add_resource(&default_res, &busn_resource);
>> +       } else {
>>
> 
> Isn't it almost always wrong to do this? You are adding all of the
> I/O ports and memory to the host bridge, which will prevent you from
> adding another host bridge, and the iomem_resource normally
> includes a lot of addresses that are not accessible by the PCI host.

Hi Arnd, pci host bridge windows are the ranges allow child devices to setup
from. Add all of IO/MEM here just a limit to child devices, no request for these
resources, so it won't hurt another host bridge. Some platforms have no dts or ACPI
report host bridge resources, in this case, we directly assign ioport/iomem_resources
as the root resources of PCI devices.

Thanks!
Yijing.

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing
