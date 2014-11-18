Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4F061A061F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 20:44:35 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support
 default IO/MEM resources
Date: Tue, 18 Nov 2014 10:36:34 +0100
Message-ID: <2447172.ADYWdCTnMP@wuerfel>
In-Reply-To: <546AF8D7.9010103@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <2732970.7HG94QvVBv@wuerfel> <546AF8D7.9010103@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 Suravee.Suthikulpanit@amd.com, Yijing Wang <wangyijing@huawei.com>,
 linux-ia64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 Yijing Wang <wangyijing0307@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 18 November 2014 15:44:23 Yijing Wang wrote:
> On 2014/11/17 18:08, Arnd Bergmann wrote:
> > On Monday 17 November 2014 18:21:35 Yijing Wang wrote:
> >> -       list_for_each_entry(window, resources, list)
> >> -               if (window->res->flags & IORESOURCE_BUS) {
> >> -                       found = true;
> >> -                       break;
> >> -               }
> >> +       if (!resources) {
> >> +               pci_add_resource(&default_res, &ioport_resource);
> >> +               pci_add_resource(&default_res, &iomem_resource);
> >> +               pci_add_resource(&default_res, &busn_resource);
> >> +       } else {
> >>
> > 
> > Isn't it almost always wrong to do this? You are adding all of the
> > I/O ports and memory to the host bridge, which will prevent you from
> > adding another host bridge, and the iomem_resource normally
> > includes a lot of addresses that are not accessible by the PCI host.
> 
> Hi Arnd, pci host bridge windows are the ranges allow child devices to setup
> from. Add all of IO/MEM here just a limit to child devices, no request for these
> resources, so it won't hurt another host bridge. Some platforms have no dts or ACPI
> report host bridge resources, in this case, we directly assign ioport/iomem_resources
> as the root resources of PCI devices.

But it would be wrong to allow hosts to allocate a device BAR that is not
visible through the host bridge. I think we need to keep these separate
from the general case: if you call any of the modern interfaces you have
to provide the resources and a device. I notice that there is only one
caller of pci_scan_bus_parented(), we should probably change that over to
pci_scan_root_bus() or your new interface and remove the old one, but
keep pci_scan_bus() as the only entry point for all of the legacy users
that do not know about the resources.

	Arnd
