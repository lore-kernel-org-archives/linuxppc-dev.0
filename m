Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpycQ37LgzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:20:06 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id 184so4578781pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:20:06 -0700 (PDT)
Subject: Re: [PATCH v8 31/45] powerpc/pci: Don't scan empty slot
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-32-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715EA2E.4090105@ozlabs.ru>
Date: Tue, 19 Apr 2016 18:19:58 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-32-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> In hotplug case, function pci_add_pci_devices() is called to rescan
> the specified PCI bus, which might not have any child devices. Access
> to the PCI bus's child device node will cause kernel crash without
> exception.
>
> This adds one more check to skip scanning PCI bus that doesn't have
> any subordinate devices from device-tree, in order to avoid kernel
> crash.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/kernel/pci-hotplug.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 7929a1c..3628c38 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -120,7 +120,8 @@ void pci_add_pci_devices(struct pci_bus *bus)
>   	if (mode == PCI_PROBE_DEVTREE) {
>   		/* use ofdt-based probe */
>   		of_rescan_bus(dn, bus);
> -	} else if (mode == PCI_PROBE_NORMAL) {
> +	} else if (mode == PCI_PROBE_NORMAL &&
> +		   dn->child && PCI_DN(dn->child)) {
>   		/*
>   		 * Use legacy probe. In the partial hotplug case, we
>   		 * probably have grandchildren devices unplugged. So
>


-- 
Alexey
