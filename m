Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Mar 2008 10:29:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
Message-ID: <20080304232940.GB8399@localhost.localdomain>
References: <20080304162322.GA19634@ru.mvista.com>
	<20080304163540.GD19634@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304163540.GD19634@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 07:35:40PM +0300, Alexandr Smirnov wrote:
> Add device tree file for Emerson KSI8560 board.
> 
> Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>

[snip]
> +		enet0: ethernet@24000 {
> +			linux,network-index = <0>;

We're trying to get rid of this.  Since I assume you're using u-boot,
I'm not sure why you'd need it now anyway.

> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";

This still looks like the old binding.

[snip]
> +		cpld@4,0 {
> +			compatible = "altera,maxii";

I'm guessing an Altera Maxii is just the name of the FPGA chip into
which the CPLD is programmed?  If so, it's not a suitable "comaptible"
value, because that needs to describe the register interface.  You
probably want something like
	compatible = "emerson,KSI8560-cpld";
here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
