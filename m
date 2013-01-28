Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 by ozlabs.org (Postfix) with ESMTP id AB7522C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 14:57:00 +1100 (EST)
Message-ID: <5105F51A.1060600@huawei.com>
Date: Mon, 28 Jan 2013 11:48:42 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 20/22] PCI, powerpc: Kill pci_root_buses in resources
 reservations
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
 <1359314629-18651-21-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-21-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013/1/28 3:23, Yinghai Lu wrote:
> Replace that with hotplug-safe version iteration.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/pci-common.c |   13 ++++++-------
>  arch/powerpc/kernel/pci_64.c     |    8 ++++----
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index abc0d08..9ccecbe 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1398,11 +1398,11 @@ static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
>  
>  void __init pcibios_resource_survey(void)
>  {
> -	struct pci_bus *b;
> +	struct pci_host_bridge *host_bridge = NULL;
>  
>  	/* Allocate and assign resources */
> -	list_for_each_entry(b, &pci_root_buses, node)
> -		pcibios_allocate_bus_resources(b);
> +	for_each_pci_host_bridge(host_bridge)
> +		pcibios_allocate_bus_resources(host_bridge->bus);
>  	pcibios_allocate_resources(0);
>  	pcibios_allocate_resources(1);
>  
> @@ -1410,10 +1410,9 @@ void __init pcibios_resource_survey(void)
>  	 * the low IO area and the VGA memory area if they intersect the
>  	 * bus available resources to avoid allocating things on top of them
>  	 */
> -	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> -		list_for_each_entry(b, &pci_root_buses, node)
> -			pcibios_reserve_legacy_regions(b);
> -	}
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		for_each_pci_host_bridge(host_bridge)
> +			pcibios_reserve_legacy_regions(host_bridge->bus);
>  
>  	/* Now, if the platform didn't decide to blindly trust the firmware,
>  	 * we proceed to assigning things that were left unassigned
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 2cbe676..f848325 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -208,9 +208,9 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>  			  unsigned long in_devfn)
>  {
>  	struct pci_controller* hose;
> -	struct list_head *ln;
> -	struct pci_bus *bus = NULL;
> +	struct pci_bus *bus;
>  	struct device_node *hose_node;
> +	struct pci_host_bridge *host_bridge = NULL;
>  
>  	/* Argh ! Please forgive me for that hack, but that's the
>  	 * simplest way to get existing XFree to not lockup on some
> @@ -230,8 +230,8 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>  	 * used on pre-domains setup. We return the first match
>  	 */
>  
> -	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
> -		bus = pci_bus_b(ln);
> +	for_each_pci_host_bridge(host_bridge) {
> +		bus = host_bridge->bus;
>  		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)

Need put_device(&host_bridge->dev).

>  			break;
>  		bus = NULL;
> 


-- 
Thanks!
Yijing
