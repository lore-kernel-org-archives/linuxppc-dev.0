Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Sep 2007 13:15:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 06/28] bootwrapper: Add PlanetCore firmware support.
Message-ID: <20070919031510.GH23646@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165735.GF6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165735.GF6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:57:35AM -0500, Scott Wood wrote:
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
> +	u32 i;
> +	int j;
> +	void *node;
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
> +
> +		node = find_node_by_prop_value(NULL, "linux,network-index",
> +		                               (void *)&i, 4);
> +		if (node) {
> +			printf("ENET%u: local-mac-address <-"
> +			       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", i,
> +			       addr[i][0], addr[i][1], addr[i][2],
> +			       addr[i][3], addr[i][4], addr[i][5]);
> +
> +			setprop(node, "local-mac-address", addr[i], 6);

Hrm.  When I said to extract the logic of fixup_mac_addrs(), I meant
to create a new one-address version of the function in devtree.c then
use it both here and in the fixup_mac_addrs() function.  Rather than
duplicating it inline here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
