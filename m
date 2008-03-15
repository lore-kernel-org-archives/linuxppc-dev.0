Return-Path: <dgibson@ozlabs.org>
Date: Sat, 15 Mar 2008 11:10:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 1/4] Emerson ATCA-C125 bootwrapper
Message-ID: <20080315001036.GA3487@localhost.localdomain>
References: <20080314142220.GA8228@ru.mvista.com>
	<20080314142703.GB8228@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080314142703.GB8228@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 14, 2008 at 05:27:03PM +0300, Alexandr Smirnov wrote:
> 
> Bootwraper for Emerson ATCA-C125 board. This board has
> four ethernet ports, so it has to use this code instead
> of generic.

[snip]
> +	/* Unfortunately, the specific model number is encoded in the
> +	 * soc node name in existing dts files -- once that is fixed,
> +	 * this can do a simple path lookup.
> +	 */

Since this is a new board, couldn't you name the soc node /soc and
dispense with this more complicated way of doing things?  Or would
that break other versions of u-boot that are in use?

> +	soc = find_node_by_devtype(NULL, "soc");
> +	if (soc) {
> +		void *serial = NULL;
> +
> +		setprop(soc, "bus-frequency", &bd.bi_busfreq,
> +			sizeof(bd.bi_busfreq));
> +
> +		while ((serial = find_node_by_devtype(serial, "serial"))) {
> +			if (get_parent(serial) != soc)
> +				continue;
> +
> +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> +				sizeof(bd.bi_busfreq));
> +		}
> +	}
> +}
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +		   unsigned long r6, unsigned long r7)
> +{
> +	CUBOOT_INIT();
> +	fdt_init(_dtb_start);
> +	serial_console_init();
> +	platform_ops.fixups = platform_fixups;
> +}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
