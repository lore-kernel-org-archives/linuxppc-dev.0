Return-Path: <dgibson@ozlabs.org>
Date: Thu, 17 Jan 2008 12:58:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 4/4 v2] powerpc: Katana750i - Add platform support
Message-ID: <20080117015815.GB11567@localhost.localdomain>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114230057.GC22862@mag.az.mvista.com>
	<20080116221210.GC7228@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080116221210.GC7228@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 16, 2008 at 03:12:10PM -0700, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> Add support for the Emerson Katana 750i & 752i platforms.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
[snip]
> +typedef enum {
> +	BOARD_TYPE_750I,
> +	BOARD_TYPE_752I,
> +} katana750i_board_type;

This enum appears to be pointless.  You never use it as a type, and
there's no reason to explicitly give array indices for the
board_info[] array.

> +struct katana750i_board_info {
> +	char	cpld_prod_id;
> +	char	*model;
> +	char	*bridge_type;
> +};
> +
> +static struct katana750i_board_info katana750i_board_info[] = {
> +	[BOARD_TYPE_750I] = {
> +		.cpld_prod_id	= KATANA750I_PRODUCT_ID_750I,
> +		.model		= "Katana-750i",
> +		.bridge_type	= "mv64360",
> +	},
> +	[BOARD_TYPE_752I] = {
> +		.cpld_prod_id	= KATANA750I_PRODUCT_ID_752I,
> +		.model		= "Katana-752i",
> +		.bridge_type	= "mv64460",
> +	},
> +};
[...]

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
