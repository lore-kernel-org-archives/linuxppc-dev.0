Return-Path: <trini@kernel.crashing.org>
Date: Wed, 2 Aug 2006 09:10:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/6] bootwrapper: Add device tree ops for flattened device
	tree
Message-ID: <20060802161054.GG3075@smtp.west.cox.net>
References: <20060719230544.GD3887@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719230544.GD3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 04:05:44PM -0700, Mark A. Greer wrote:

> This patch adds the device tree operations (dt_ops) for a flattened
> device tree (fdt).
[snip]
> +/* Definitions used by the flattened device tree */
[snip]
...
> +struct fdt_bus {
> +	u64	(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
> +	int	(*translate)(u32 *addr, u64 offset, int na);
> +};

All of that should live in an fdt.h.

> +
> +static inline struct boot_param_header *
> +fdt_get_bph(void *dt_blob)
> +{
> +	return (struct boot_param_header *)dt_blob;
> +}

Er, can't we just do this in the few places directly?

> +		if (!(new_dtb_start = malloc(new_total_size))) {
> +			printf("Can't alloc space for new fdt\n\r");
> +			exit();
> +		}

Wasn't there a panic("Message") or so, for bootwrapper stuff?  If not,
maybe there should be..

-- 
Tom Rini
