Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A611B1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 23:26:34 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 07/16] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
Date: Tue, 18 Nov 2014 13:25:32 +0100
Message-ID: <2911754.xsk2IUfQFO@wuerfel>
In-Reply-To: <546B3124.7070206@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1936415.emTbbPeHqx@wuerfel> <546B3124.7070206@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>, Suravee.Suthikulpanit@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 18 November 2014 19:44:36 Yijing Wang wrote:
> On 2014/11/18 17:30, Arnd Bergmann wrote:
> > On Tuesday 18 November 2014 16:32:26 Yijing Wang wrote:
> > 
> >>>> +static struct resource busn_resource = {
> >>>> +	.name	= "PCI busn",
> >>>> +	.start	= 0,
> >>>> +	.end	= 255,
> >>>> +	.flags	= IORESOURCE_BUS,
> >>>> +};
> >>>
> >>> I think it would be better to require callers to pass the bus resource
> >>> down to the function.
> >>
> >> Hmm, I think most of caller will provide the bus resource, but some others
> >> will not give any bus resource, extremely, no any resources :(. But we still
> >> need properly configure their resources for compatibility.
> > 
> > I think that is what the conversion to pci_scan_bus_parented() is about:
> > The idea is that we add the correct bus resource to callers of
> > pci_scan_bus_parented or pci_scan_bus and then change them to call
> > pci_scan_root_bus instead.
> 
> It looks good to me, but for simplification, or I will try to use a wrapper to
> process the drivers don't pass the busnr resources, and make sure the generic
> pci_create_host_bridge() always get the valid resources.

Ok.
 
> >>>> +struct pci_host_bridge *pci_create_host_bridge(
> >>>> +		struct device *parent, u32 db, 
> >>>> +		struct pci_ops *ops, void *sysdata, 
> >>>> +		struct list_head *resources)
> >>>> +{
> >>>
> >>> Do we still need to pass the 'sysdata' in here? If we are guaranteed to
> >>> have a device pointer, we should always be able to get the driver
> >>> private data from dev_get_drvdata(host->dev->parent).
> >>
> >> We need, some platforms pass NULL pointer as host bridge parent.
> > 
> > But those don't have to use the new pci_create_host_bridge() function,
> > right?
> 
> As I mentioned in another reply, I hope all pci host drivers could use
> pci_create_host_bridge(), keep different PCI scan interfaces in PCI core
> make things become complex.

Doing this for all platforms that have PCI support would be a lot of
work though, I think it's better to focus on having a the best interface
for the majority of users.

	Arnd
