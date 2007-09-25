Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 12:11:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070925021144.GF30338@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<b312e03ef67dcd6cdc5f57e90da746ef@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b312e03ef67dcd6cdc5f57e90da746ef@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 11:11:28PM +0200, Segher Boessenkool wrote:
> >>  Scott> #size-cells is zero on i2c, so it should just be reg = <68>.
> >>
> >>  Scott> You'll probably need to add #address-cells and #size-cells to 
> >> the
> >>  Scott> controller node, as well.
> >
> > Uh.. yes.. i2c interfaces should really always have #a and #s.
> 
> More generally, every node that defines a bus needs it (unless the
> defaults of 2 resp. 1 are correct for this bus, but even then you
> might want it because it makes things more explicit).

Yes.  Actually I think we should make explicit #a and #s at least
strongly recommended in the flat tree documentation.

> >>  		i2c@3100 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >>  			device_type = "i2c";
> >
> > Hrm... we probably want an "i2c" device_type class, but I don't think
> > we've actually defined one, which is a problem
> 
> By defining new device_type's, or new semantics for device_type,
> you open the door to (accidentally) becoming incompatible with
> "real" OF.

Hrm... perhaps.  But is it a realistic danger - I'll have to think
more about that.

> And you don't need to: "real" OF has a mechanism for specifying
> the "generic device class" already, if you use the "generic names"
> recommended practice (and you do, for both this node and the rtc
> node): it's the generic name itself!

Hmm, I guess.

> >> +			rtc@68 {
> >> +				device_type = "rtc";
> >> +				compatible = "dallas,ds1339";
> >> +				reg = <68>;
> >> +			};
> >
> > I think we want to think a bit more carefully about how to do bindings
> > for RTC devices.  No "rtc" device_type is defined, but again we might
> > want to.
> 
> Actually, "device_type" = "rtc" _is_ defined (in the "device support
> extensions" recommended practice), and there is no useful way a flat
> device tree can implement it (it merely defines get-time and set-time
> methods).

Ah.. right.  That changes things a bit, in that we might want to
include device_type purely for similarity with real OF tree.

Real OF has a device_type == "nvram" too, doesn't it?  AFAICT the real
OF systems I have (which I think all have ISA-like CMOS RTC/NVRAM
chips) the RTC is labelled as "nvram" rather than "rtc".

> > The fact that NVRAM+RTC chips are so common is a bit of an issue from
> > the point of view of defining a device class binding - a device can't
> > have type "rtc" and "nvram".
> 
> You should match OS drivers on "compatible" only anyway.

Absolutely.  I was only thinking of defining "device classes" where
for some reason it is useful to examine them without needing to pick a
particular driver.

> Those cases where OS drivers don't nicely 1-1 match device nodes are a
> bit of a headache; for RTC/NVRAM devices, these problems are nicely
> side-stepped by handling this from platform code.

Not necessarily.  The new RTC class drivers are just drivers like
anything other and are not especially instantiated from the platform
code.


And drat.  I was only really mentioning stuff about device_type in
passing, but it's the only thing anyone's responded to.  I was also
mostly suggesting changing the format of compatible, for greater
similarity with the existing ds1385 binding.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
