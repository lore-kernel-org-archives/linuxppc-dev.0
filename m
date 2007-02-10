Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 13:56:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: Subject: [PATCH] Add support for the 8568 MDS board
Message-ID: <20070210025601.GA21415@localhost.localdomain>
References: <Pine.LNX.4.61.0702091727290.791@ld0175-tx32.am.freescale.net>
	<20070210004704.GC8276@localhost.localdomain>
	<F7DA9D5D-B489-48DA-A9A3-77B8A37395FF@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F7DA9D5D-B489-48DA-A9A3-77B8A37395FF@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 08:07:47PM -0600, Andy Fleming wrote:
> 
> On Feb 9, 2007, at 18:47, David Gibson wrote:
> 
> > On Fri, Feb 09, 2007 at 05:28:31PM -0600, Andy Fleming wrote:
> > [snip]
> >> +/ {
> >> +	model = "MPC8568EMDS";
> >> +	compatible = "MPC85xxMDS";
> >> +	#address-cells = <1>;
> >> +	#size-cells = <1>;
> >> +	linux,phandle = <100>;
> >> +
> >> +	cpus {
> >> +		#cpus = <1>;
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		linux,phandle = <200>;
> >
> > So, every Freescale device tree source I've seen so far has had these
> > hardcoded phandles all through it.  dtc has supported
> > reference-to-path to automatically generate the necessary phandles for
> > ages now.  Please can we use it...
> 
> Ok, I'll take a look.  Any pointers on syntax?

	interrupt-parent = <&/path/to/interrupt-controller>;

That will give a phandle to the target node, if it doesn't have one
already, and insert that phandle value as a cell into the property.

In very recent versions of dtc (as of about yesterday..) you can also
reference a node's label instead of it's path.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
