Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrmWV1mZWzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:52:06 +1000 (AEST)
Message-ID: <1461307925.32306.46.camel@neuling.org>
Subject: Re: [PATCH V2 55/68] powerpc/mm: VMALLOC abstraction
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 22 Apr 2016 16:52:05 +1000
In-Reply-To: <1460182444-2468-56-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-56-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh,

I'm not sure why we need this patch.

It seems to be moving the initialisation of some global variables into
init functions from the definitions.  And renames some things.

> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 41503d7d53a1..3759df52bd67 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -38,7 +38,7 @@
>   * ISA drivers use hard coded offsets.  If no ISA bus exists nothing
>   * is mapped on the first 64K of IO space
>   */
> -unsigned long pci_io_base =3D ISA_IO_BASE;
> +unsigned long pci_io_base;
>  EXPORT_SYMBOL(pci_io_base);
> =20
>  static int __init pcibios_init(void)
> @@ -47,6 +47,7 @@ static int __init pcibios_init(void)
> =20
>  	printk(KERN_INFO "PCI: Probing PCI hardware\n");
> =20
> +	pci_io_base =3D ISA_IO_BASE;

Did you mean to change this in this patch?  This seems to be a random
change in pci code.

Mikey
