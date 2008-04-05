Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 94759DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 02:31:31 +1000 (EST)
Message-ID: <47F7A935.3080803@ru.mvista.com>
Date: Sat, 05 Apr 2008 20:30:45 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 3/4] PowerPC: Add PCI entry to 440EPx Sequoia DTS.
References: <20071221162601.GA1700@ru.mvista.com>
In-Reply-To: <20071221162601.GA1700@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:

> This adds PCI entry to PowerPC 440EPx Sequoia DTS.

> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

> --- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-12-21 17:14:17.000000000 +0300
> +++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-12-21 17:18:32.000000000 +0300
> @@ -324,6 +324,33 @@
>  				has-new-stacr-staopc;
>  			};
>  		};
> +
> +		PCI0: pci@1ec000000 {
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			compatible = "ibm,plb440epx-pci", "ibm,plb-pci";
> +			primary;
> +			reg = <1 eec00000 8	/* Config space access */
> +			       1 eed00000 4	/* IACK */
> +			       1 eed00000 4	/* Special cycle */
> +			       1 ef400000 40>;	/* Internal registers */
> +
> +			/* Outbound ranges, one memory and one IO,
> +			 * later cannot be changed. Chip supports a second
> +			 * IO range but we don't use it for now
> +			 */
> +			ranges = <02000000 0 80000000 1 80000000 0 10000000

    I wonder why the AMCC's Sequoia/Rainier manual has PCI memory mapped at 
0x80000000-0xbfffffff? The 0x80000000-0x8fffffff mapping was assumed by 
arch/ppc/ code.  What/why changed here?
    As we now both know, having PCI memory space mapped beyound 4 GB makes 
some drivers misbehave as they use 'unsigned long' to store the result of 
pci_resource_start() and later ioremap() this truncated value -- which is 
64-bit on Sequoia due to CONFIG_RESOURCE_64BIT=y that is needed to store the 
beyond-4GB addresses.

> +				01000000 0 00000000 1 e8000000 0 00100000>;
> +
> +			/* Inbound 2GB range starting at 0 */
> +			dma-ranges = <42000000 0 0 0 0 0 80000000>;
> +
> +			/* All PCI interrupts are routed to IRQ 67 */
> +			interrupt-map-mask = <0000 0 0 0>;
> +			interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
> +		};
>  	};

WBR, Sergei
