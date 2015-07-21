Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACFE91A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 12:45:59 +1000 (AEST)
Date: Tue, 21 Jul 2015 12:45:54 +1000
From: Anton Blanchard <anton@samba.org>
To: "Ian Munsie" <imunsie@au1.ibm.com>, Benjamin Herrenschmidt
 <benh@au1.ibm.com>
Cc: "sonal.santan" <sonal.santan@xilinx.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>,
 Jeremy Kerr <jk@ozlabs.org>, Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
Message-ID: <20150721124554.332dd228@kryten>
In-Reply-To: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,

> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If the system has a PCI device with a memory-controller device node,
> kexec-lite would spew hundreds of double free warnings and eventually
> segfault. This would result in a "kexec load failed" message from
> petitboot.
> 
> This was due to kexec_memory_map() searching for "memory" nodes, but
> actually matching any node that started with "memory", including these
> "memory-controller" nodes. This patch changes the search to look for
> nodes starting with "memory@", which should only match memory nodes.

Nice catch! I wonder if we should be checking for device_type
"memory". Ben?

Anton

> An example of a device tree that can trigger this bug is as follows:
> 
> {
> 	pciex@3fffe40000000 {
> 		...
> 		pci@0 {
> 			#address-cells = <0x3>;
> 			#size-cells = <0x2>;
> 			...
> 			memory-controller@0 {
> 				reg = <0x10000 0x0 0x0 0x0 0x0>;
> 				...
> 			};
> 		};
> 	};
> };
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  kexec_memory_map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec_memory_map.c b/kexec_memory_map.c
> index fc1b7af..7f18de7 100644
> --- a/kexec_memory_map.c
> +++ b/kexec_memory_map.c
> @@ -192,7 +192,7 @@ void kexec_memory_map(void *fdt, int
> reserve_initrd) 
>  		name = fdt_get_name(fdt, nodeoffset, NULL);
>  
> -		if (!name || strncmp(name, "memory",
> strlen("memory")))
> +		if (!name || strncmp(name, "memory@",
> strlen("memory@"))) continue;
>  
>  		reg = fdt_getprop(fdt, nodeoffset, "reg", &len);
