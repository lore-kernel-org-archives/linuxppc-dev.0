Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 51145DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 10:48:15 +1100 (EST)
Date: Tue, 11 Dec 2007 16:50:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>
Subject: Re: [PATCH 2/5] PowerPC 74xx: Minor updates to MV64x60 boot code
Message-ID: <20071211235013.GA12698@mag.az.mvista.com>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129153555.GC13751@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129153555.GC13751@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 06:35:55PM +0300, Andrei Dolnikov wrote:

Hi Andrei.  I have a few comments below.

> This patch adds new functionality to MV64x60 boot code. The changes are required
> to access DevCS windows registers and set PCI bus and devfn numbers for MV644x60
> PCI/PCI-X interfaces.
> 
> Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvista.com>
> 
> ---
>  mv64x60.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mv64x60.h |   10 ++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/arch/powerpc/boot/mv64x60.c b/arch/powerpc/boot/mv64x60.c
> index d207a0b..787a124 100644
> --- a/arch/powerpc/boot/mv64x60.c
> +++ b/arch/powerpc/boot/mv64x60.c
> @@ -32,6 +32,16 @@
>  #define MV64x60_CPU2MEM_3_BASE			0x0218
>  #define MV64x60_CPU2MEM_3_SIZE			0x0220
>  
> +#define MV64x60_DEV2MEM_WINDOWS			4
> +#define MV64x60_DEV2MEM_0_BASE			0x0028
> +#define MV64x60_DEV2MEM_0_SIZE			0x0030
> +#define MV64x60_DEV2MEM_1_BASE			0x0228
> +#define MV64x60_DEV2MEM_1_SIZE			0x0230
> +#define MV64x60_DEV2MEM_2_BASE			0x0248
> +#define MV64x60_DEV2MEM_2_SIZE			0x0250
> +#define MV64x60_DEV2MEM_3_BASE			0x0038
> +#define MV64x60_DEV2MEM_3_SIZE			0x0040
> +

These aren't device->memory windows, they're CPU->device windows so
they should be named MV64x60_CPU2DEV_xxx to be consistent with the
previously established naming convention.

>  #define MV64x60_ENET2MEM_BAR_ENABLE		0x2290
>  #define MV64x60_ENET2MEM_0_BASE			0x2200
>  #define MV64x60_ENET2MEM_0_SIZE			0x2204
> @@ -219,6 +229,25 @@ static struct mv64x60_mem_win mv64x60_cpu2mem[MV64x60_CPU2MEM_WINDOWS] = {
>  	},
>  };
>  
> +static struct mv64x60_mem_win mv64x60_devcs[MV64x60_DEV2MEM_WINDOWS] = {

Why not call this mv64x60_cpu2dev[]?

<snip>

> @@ -586,6 +645,21 @@ u32 mv64x60_get_mem_size(u8 *bridge_base)
>  	return mem;
>  }
>  
> +/* Read a size of DEV_CS window */
> +u32 mv64x60_get_devcs_size(u8 *bridge_base, u32 devcs)

u32 mv64x60_get_cpu2dev_size(...)

<snip>

> diff --git a/arch/powerpc/boot/mv64x60.h b/arch/powerpc/boot/mv64x60.h
> index d0b29a7..a633d2e 100644
> --- a/arch/powerpc/boot/mv64x60.h
> +++ b/arch/powerpc/boot/mv64x60.h
> @@ -12,6 +12,14 @@
>  
>  #define MV64x60_CPU_BAR_ENABLE			0x0278
>  
> +#define MV64x60_PCI0_MODE			0x0d00
> +#define MV64x60_PCI1_MODE			0x0d80
> +#define MV64x60_PCI0_P2P_CONF			0x1d14
> +#define MV64x60_PCI1_P2P_CONF			0x1d94
> +
> +#define MV64x60_PCI_MODE_MASK			0x00000030
> +#define MV64x60_PCI_CONVENTIONAL_MODE		0x00000000
> +

AFAICS these macros are only used in mv64x60.c so just put them there.
They only need to go in mv64x60.h if they're used in more than one .c
file.

Mark
