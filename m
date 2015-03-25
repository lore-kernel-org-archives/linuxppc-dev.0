Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [58.251.152.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA4FC1A176F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 18:44:01 +1100 (AEDT)
Message-ID: <551266DE.3030609@huawei.com>
Date: Wed, 25 Mar 2015 15:42:22 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v8 19/30] powerpc/pci: Use pci_scan_host_bridge() for
 simplicity
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>	
 <1427168064-8657-20-git-send-email-wangyijing@huawei.com>
 <1427241523.2685.18.camel@axtens.net>
In-Reply-To: <1427241523.2685.18.camel@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Rusty Russell <rusty@rustcorp.com.au>,
 linux-ia64@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org,
 linux-m68k@lists.linux-m68k.org, Tony Luck <tony.luck@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-alpha@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/3/25 7:58, Daniel Axtens wrote:
> On Tue, 2015-03-24 at 11:34 +0800, Yijing Wang wrote:
>> Now we could use pci_scan_host_bridge() to scan
>> pci buses, provide powerpc specific pci_host_bridge_ops.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: linuxppc-dev@lists.ozlabs.org
>> ---
>>  arch/powerpc/kernel/pci-common.c |   60 +++++++++++++++++++++++--------------
>>  1 files changed, 37 insertions(+), 23 deletions(-)
> 
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 2c58200..e2b50a2 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -773,6 +773,29 @@ void pcibios_set_root_bus_speed(struct pci_host_bridge *bridge)
>>  		return ppc_md.pcibios_set_root_bus_speed(bridge);
>>  }
>>  
>> +static int pci_host_scan_bus(struct pci_host_bridge *host)
>> +{
>> +	int mode = PCI_PROBE_NORMAL;
>> +	struct pci_bus *bus = host->bus;
>> +	struct pci_controller *hose = dev_get_drvdata(&host->dev);
> Is there any reason this isn't *hose = pci_bus_to_host(bus)?

Hi Daniel, thanks for your review and comments. We want to make a generic pci_host_bridge,
which would hold the common host information, for example, pci domain is common info for
pci host bridge, this series saved domain in pci_host_bridge, then we no need to
extract out domain by pci_bus->sysdata by platform specific pci_domain_nr().
Also we store the sysdata in pci_host_bridge, and pci_bus_to_host() is the platform
interface, I think use the common interface would be better.

>> +
>> +	/* Get probe mode and perform scan */
>> +	if (hose->dn && ppc_md.pci_probe_mode)
>> +		mode = ppc_md.pci_probe_mode(bus);
>> +
>> +	pr_debug("    probe mode: %d\n", mode);
>> +	if (mode == PCI_PROBE_DEVTREE)
>> +		of_scan_bus(hose->dn, bus);
>> +
>> +	if (mode == PCI_PROBE_NORMAL) {
>> +		pci_bus_update_busn_res_end(bus, 255);
>> +		hose->last_busno = pci_scan_child_bus(bus);
>> +		pci_bus_update_busn_res_end(bus, hose->last_busno);
>> +	}
>> +
>> +	return pci_bus_child_max_busnr(bus);
>> +}
>> +
> I'm having trouble convincing myself that this patch covers every
> variation within our PCI implementations. In particular, there's a
> stanza in of_scan_pci_bridge in kernel/pci_of_scan.c that's almost
> identical to this function. Does that implementation need to be cleaned
> up and replaced with this function too?
> 

This is a pci_host_bridge_ops hook function, which would be called in
PCI core, and after applied this series, we only need to call pci_scan_host_bridge()
to scan pci devices, and this function is also extracted from the pcibios_scan_phb(),
it's not the redundant code.

> 
>> @@ -1641,9 +1655,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
>>  		ppc_md.pcibios_fixup_phb(hose);
>>  
>>  	/* Configure PCI Express settings */
>> -	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>> +	if (host->bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>>  		struct pci_bus *child;
>> -		list_for_each_entry(child, &bus->children, node)
>> +		list_for_each_entry(child, &host->bus->children, node)
>>  			pcie_bus_configure_settings(child);
>>  	}
>>  }
> Two things: Firstly, the function uses hose throughout, not host.
> Secondly, you're not deleting the bus variable: what's the purpose of
> this change?

host is the common pci_host_bridge which is created by PCI core for pci host bridge driver,
the hose is the platform data used in powerpc. The purpose of the patch/series is to simplify
pci enumeration interface, and try to reduce the weak functions which were used to setup pci bus/devices
during PCI enumeration.

> 
> Regards,
> Daniel
> 


-- 
Thanks!
Yijing
