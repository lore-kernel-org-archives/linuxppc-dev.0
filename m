Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8D80E1400B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 19:16:00 +1000 (EST)
Message-ID: <1397116463.3671.181.camel@pasglop>
Subject: Re: [PATCH] Fix 3bc95598 'powerpc/PCI: Use list_for_each_entry()
 for bus traversal'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 17:54:23 +1000
In-Reply-To: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, paulus@samba.org, wangyijing@huawei.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-04-10 at 02:51 -0400, Mike Qiu wrote:
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc000000000041d78
> Oops: Kernel access of bad area, sig: 11 [#1]
> ...
> NIP [c000000000041d78] .sys_pciconfig_iobase+0x68/0x1f0
> LR [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0
> Call Trace:
> [c0000003b4787db0] [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0 (unreliable)
> [c0000003b4787e30] [c000000000009ed8] syscall_exit+0x0/0x98
> 
> This bug was introduced by commit 3bc955987fb377f3c95bc29deb498e96819b8451
> The root cause was the 'bus' has been set to null while try to access
> bus->next.

Good catch. Out of curiosity, what is using that syscall nowadays ? It's
been long buggy in all sort of ways and is pretty much deprecated...

Cheers,
Ben.

> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci_64.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 2a47790..7b6c1ae 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -209,6 +209,7 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>  {
>  	struct pci_controller* hose;
>  	struct pci_bus *bus = NULL;
> +	struct pci_bus *tmp_bus = NULL;
>  	struct device_node *hose_node;
>  
>  	/* Argh ! Please forgive me for that hack, but that's the
> @@ -229,10 +230,12 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>  	 * used on pre-domains setup. We return the first match
>  	 */
>  
> -	list_for_each_entry(bus, &pci_root_buses, node) {
> -		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
> +	list_for_each_entry(tmp_bus, &pci_root_buses, node) {
> +		if (in_bus >= tmp_bus->number &&
> +		    in_bus <= tmp_bus->busn_res.end) {
> +			bus = tmp_bus;
>  			break;
> -		bus = NULL;
> +		}
>  	}
>  	if (bus == NULL || bus->dev.of_node == NULL)
>  		return -ENODEV;
