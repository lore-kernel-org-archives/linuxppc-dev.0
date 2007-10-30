Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 09:58:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030225827.GA2784@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 09:23:14AM -0700, Yoder Stuart-B08248 wrote:
> 
> > Explicitly specifying what device class bindings / conventions the
> > node complies with is cute, but not actually all that useful in
> > practice.  If it looks like a "duck" class device node, and it
> > quacks^Whas the properties of a "duck" class device node, it's "duck"
> > class compliant.
> 
> Don't know how cute it is, but I think it is practically 
> helpful.   Take another example:
> 
> Say you-- a human reader-- see this in a device
> tree:
> 
> ...
> interrupts = <b 8>;
> interrupt-parent = < &mpic >;
> ...
> 
> What does the 'b' and '8' mean?  You look
> at the interrupt controller node--
> 
>   mpic: pic@40000 {
>      clock-frequency = <0>;
>      interrupt-controller;
>      #address-cells = <0>;
>      #interrupt-cells = <2>;
>      reg = <40000 40000>;
>      compatible = "fsl,xyz";
>      big-endian;
> }
> 
> Note-- I removed the device_type property and changed
> compatible somewhat.  How are you going to find where
> the meaning interrupt controller's interrupt cells are
> defined?   What spec will you look at?
> 
> device_type = "open-pic"; makes it perfectly clear.
> It's an open-pic type controller and follows that
> binding.

That's an extremely contrived example - it only works because for
historical reasons the "open-pic" device_type describes a programming
model as well as an OF method interface.  In general, you always need
to look at a node's "compatible" and the binding for that to work out
what it's properties mean, or if it's an interrupt controller what the
format of its interrupt specifiers is.

open-pic is the *only* example I can think of where device_type will
tell you this.  In fact, "open-pic" really belongs in compatible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
