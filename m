Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7BDA4DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 12:59:16 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l852xHCW006256
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 12:59:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8532nVm185544
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 13:02:49 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l853xERI008238
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 13:59:14 +1000
Date: Wed, 5 Sep 2007 12:59:07 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding
Message-ID: <20070905025907.GG17189@localhost.localdomain>
References: <20070829061300.GF3206@localhost.localdomain>
	<143067874eed1b4ee9c75d5272bb5958@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <143067874eed1b4ee9c75d5272bb5958@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2007 at 12:23:34PM +0200, Segher Boessenkool wrote:
> >+   j) CFI or JEDEC memory-mapped NOR flash
> >
> >     Flash chips (Memory Technology Devices) are often used for solid 
> >state
> >     file systems on embedded devices.
> 
> Well, almost everything has a NOR flash on it, not just
> embedded boards ;-)

Well, true.

> >+     - bank-width : Width (in bytes) of the flash bank.  Equal to the
> >+       device width times the number of interleaved chips.
> >+     - device-width : (optional) Width of a single flash chip.  If
> >+       omitted, assumed to be equal to 'bank-width'.
> 
> Let's have bank-width optional instead, it's more natural
> that way for the common case of just one chip.  Or, you can
> say that either is optional.

No, I'm disinclined to do that since bank-width is the primary bit of
information that the driver needs.

> >+	flash@ff000000 {
> >+		compatible = "amd,am29lv128ml", "cfi-flash";
> >+		reg = <ff000000 01000000>;
> >+		bank-width = <4>;
> 
> This is an 8/16-bit part, you need a device-width ;-)

Oops - that comes from grabbing a random flash name, combining it with
other example fragments without checking the details.  Added a
device-width.

> Need #address-cells here for the child nodes:

Oops.  Added #a and #s.

> >+		fs@0 {
> >+			reg = <0 f80000>;
> >+		};
> 
> [big snip]
> 
> >+					OpenBIOS@0 {
> 
> This show immediately why node name = partition name won't
> work out.  You're not supposed to start a node name with a
> capital like this.

According to which?

Nonetheless, I've added a label property, and used it for the ebony
tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
