Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 11:03:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 07/10] bootwrapper: Add PlanetCore firmware support.
Message-ID: <20070907010304.GK26079@localhost.localdomain>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192115.GG32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192115.GG32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 02:21:15PM -0500, Scott Wood wrote:
> This is a library that board code can use to extract information from the
> PlanetCore configuration keys.  PlanetCore is used on various boards from
> Embedded Planet.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

[snip]
> +void planetcore_set_mac_addrs(const char *table)
> +{
> +	char addr[4][6];
> +	u64 int_addr;
> +	int i, j;
> +
> +	if (!planetcore_get_hex(table, PLANETCORE_KEY_MAC_ADDR, &int_addr))
> +		return;
> +
> +	for (i = 0; i < 4; i++) {
> +		u64 this_dev_addr = int_addr | mac_table[i];
> +
> +		for (j = 5; j >= 0; j--) {
> +			addr[i][j] = this_dev_addr & 0xff;
> +			this_dev_addr >>= 8;
> +		}
> +	}
> +
> +	dt_fixup_mac_addresses(addr[0], addr[1], addr[2], addr[3]);
> +}

It seems a bit silly to loop generating the MAC addresses, then loop
again assigning them to the device nodes.  Better, I think, to extract
the loop innards from dt_fixup_mac_addresses(), taking the
network-index as a parameter, then call that from within your loop
here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
