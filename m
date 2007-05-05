Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40B16DDE41
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 04:17:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45IHacB009898
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 14:17:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45IHa3A186900
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:17:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45IHZHO013295
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:17:35 -0600
Subject: Re: [PATCH v2 6/7] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <e1d22829fe3f12509018791541073706@kernel.crashing.org>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 05 May 2007 13:12:26 -0500
Message-Id: <1178388746.3393.47.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-05 at 19:21 +0200, Segher Boessenkool wrote:
> > +/ {
> > +	model = "ppc750-tsi109";
> 
> "model" should be something really specific; typically
> a (unique!) model number.  This means you can't use the
> same device tree for Holly and Hickory (but there are
> more reasons for that; see below).
> 
> > +	compatible = "ppc750-tsi";
> 
> The needs to be more specific as well; "ibm,holly"
> or something.

Why?  Holly and Hickory share the same memory map and devices.  The only
thing that differs from what I can tell is the actual CPU itself.

> 
> > +		PowerPC,750@0 {
> 
> Needs to be PowerPC,750CL etc.
> 
> > +			name = "PowerPC,750";
> 
> You don't need to specify "name" in modern DTS.

Ok.

> > +  	tsi109@c0000000 {
> > +		device_type = "tsi-bridge";
> 
> Don't put a "device_type" here, it is useless
> (and undefined).  There are more like this, but
> perhaps Linux (wrongly) probes on "device_type"
> for those, so the kernel would need updating
> first.

It's not useless.  The TSI code probes by device_type all over the
place.  Do you have an example of how to probe for something like this
without using device_type?

> > +		bus-frequency = <0>;
> 
> 0?

Can likely go.

> 
> > +		ethernet@6200 {
> > +			model = "TSI-ETH";
> 
> "model" should be an exact model name.  If you don't
> have one, just leave out the "model" property.

OK.

> 
> > +			address = [ 00 0d 60 f4 3f 04 ];
> 
> "local-mac-address" instead.  And you don't want to
> hardcode one specific address like this; just keep
> it open so if the bootloader fails to fill it in you
> notice.  If the bootloader cannot do that, just leave
> out this property completely (not compliant, but neither
> is filling in the wrong value).

Ok.

> 
> > +		serial@7808 {
> > +			reg-shift = <0>;
> 
> This is the default value so you can leave it out.

Ok.

> 
> > +	  	MPIC: pic@7400 {
> > +			built-in;
> 
> Why say this for MPIC only, not for most other nodes?
> What binding defines "built-in", anyway?

http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps

Page 34.

> 
> > +				/*--------------------------------------------+
> > +				| AD19.
> > +				+--------------------------------------------*/
> > +				1800 0 0 1 &RT0 26 0
> > +				1800 0 0 2 &RT0 27 0
> > +				1800 0 0 3 &RT0 24 0
> > +				1800 0 0 4 &RT0 25 0
> > +
> > +				2000 0 0 1 &RT0 27 0
> > +				2000 0 0 2 &RT0 24 0
> > +				2000 0 0 3 &RT0 25 0
> > +				2000 0 0 4 &RT0 26 0
> > +				>;
> 
> You forgot to say "AD20" ;-)

Heh, ok.

> 
> > +	chosen {
> > +		linux,platform = <0>;
> > +		linux,initrd-start = <0>;
> > +		linux,initrd-end = <0>;
> 
> Do you need to set those zero properties?

Perhaps not.  I'll look at that.

josh
