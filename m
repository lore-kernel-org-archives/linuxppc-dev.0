Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id D0FF1DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 11:11:17 +1100 (EST)
Date: Tue, 11 Dec 2007 17:13:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>
Subject: Re: [PATCH 3/5] PowerPC 74xx: Katana Qp bootwrapper
Message-ID: <20071212001315.GE12698@mag.az.mvista.com>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129153951.GD13751@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129153951.GD13751@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 06:39:51PM +0300, Andrei Dolnikov wrote:
> Bootwrapper sources for Emerson Katana Qp
> 
> Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvista.com>
> 
> ---
>  Makefile          |    3
>  cuboot-katanaqp.c |  470 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 472 insertions(+), 1 deletion(-)

<snip> 

> diff --git a/arch/powerpc/boot/cuboot-katanaqp.c b/arch/powerpc/boot/cuboot-katanaqp.c
> new file mode 100644
> index 0000000..19ba901
> --- /dev/null
> +++ b/arch/powerpc/boot/cuboot-katanaqp.c
> @@ -0,0 +1,470 @@

<snip>

> +	/* Get the cpu -> pci i/o & mem mappings from the device tree */
> +	devp = finddevice("/mv64x60");
> +	if (devp == NULL)
> +		fatal("Error: Missing /mv64x60 device tree node\n\r");
> +
> +
> +	enables = in_le32((u32 *) (bridge_base + MV64x60_CPU_BAR_ENABLE));
> +	enables |= 0x0007fe00;	/* Disable all cpu->pci windows */
> +	out_le32((u32 *) (bridge_base + MV64x60_CPU_BAR_ENABLE), enables);
> +
> +	for (i = 0; i < 12; i += 6) {
> +		switch (v[i] & 0xff000000) {
> +		case 0x01000000:	/* PCI I/O Space */
> +			tbl = mv64x60_cpu2pci_io;
> +			break;
> +		case 0x02000000:	/* PCI MEM Space */
> +			tbl = mv64x60_cpu2pci_mem;
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		pci_base_hi = v[i + 1];
> +		pci_base_lo = v[i + 2];
> +		cpu_base = v[i + 3];
> +		size = v[i + 5];
> +
> +		buf[0] = cpu_base;
> +		buf[1] = size;
> +
> +		if (!dt_xlate_addr(devp, buf, sizeof(buf), &cpu_base))
> +			fatal("Error: Can't translate PCI address 0x%x\n\r",
> +			      (u32) cpu_base);
> +
> +		mv64x60_config_cpu2pci_window(bridge_base, 1, pci_base_hi,
> +					      pci_base_lo, cpu_base, size, tbl);
> +	}

Looks like we could factor out some of this code that's the same here
and in prpmc2800.c.  I can do that later, though.

<snip>

> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +		   unsigned long r6, unsigned long r7)
> +{
> +
> +	CUBOOT_INIT();
> +
> +	if (ft_init(_dtb_start, _dtb_end - _dtb_start, 16))
> +		exit();

This should be replaced by fdt_init(dtb) now.

<snip>

Mark
