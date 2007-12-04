Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Dec 2007 11:52:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Improved documentation of device tree 'ranges'.
Message-ID: <20071204005238.GE32577@localhost.localdomain>
References: <20071203174403.C740719B0073@mail119-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071203174403.C740719B0073@mail119-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 03, 2007 at 09:45:03AM -0800, Stephen Neuendorffer wrote:
> I was misled by the prior language.  I've attempted to clarify how
> 'ranges' are used, in particular, how to get a 1:1 mapping.

Sounds good, except for one detail.  I think we should avoid using
the "1:1" terminology: to a mathematician, at least, "1:1" is much
weaker than "identity mapping" which is what an empty ranges actually
implies.

So, I think we should explicitly say that an empty ranges implies that
parent bus address space is identical to child bus address space.

> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index e9a3cb1..aad8bf5 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -711,13 +711,14 @@ define a bus type with a more complex address format, including things
>  like address space bits, you'll have to add a bus translator to the
>  prom_parse.c file of the recent kernels for your bus type.
>  
> -The "reg" property only defines addresses and sizes (if #size-cells
> -is non-0) within a given bus. In order to translate addresses upward
> +The "reg" property only defines addresses and sizes (if #size-cells is
> +non-0) within a given bus. In order to translate addresses upward
>  (that is into parent bus addresses, and possibly into CPU physical
>  addresses), all busses must contain a "ranges" property. If the
>  "ranges" property is missing at a given level, it's assumed that
> -translation isn't possible. The format of the "ranges" property for a
> -bus is a list of:
> +translation isn't possible, i.e., the registers are not visible on the
> +parent bus.  The format of the "ranges" property for a bus is a list
> +of:
>  
>  	bus address, parent bus address, size
>  
> @@ -735,6 +736,8 @@ fit in a single 32-bit word.   New 32-bit powerpc boards should use a
>  1/1 format, unless the processor supports physical addresses greater
>  than 32-bits, in which case a 2/1 format is recommended.
>  
> +Alternatively, the "ranges" property may be empty, indicating that the
> +registers are visible on the parent bus, with 1:1 address translation.
>  
>  2) Note about "compatible" properties
>  -------------------------------------

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
