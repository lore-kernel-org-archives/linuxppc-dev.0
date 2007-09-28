Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 12:45:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070928024553.GB18840@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<b312e03ef67dcd6cdc5f57e90da746ef@kernel.crashing.org>
	<20070925021144.GF30338@localhost.localdomain>
	<9c20d018e890250443516b886317ceb9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c20d018e890250443516b886317ceb9@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 10:33:58PM +0200, Segher Boessenkool wrote:
> >>> Hrm... we probably want an "i2c" device_type class, but I don't think
> >>> we've actually defined one, which is a problem
> >>
> >> By defining new device_type's, or new semantics for device_type,
> >> you open the door to (accidentally) becoming incompatible with
> >> "real" OF.
> >
> > Hrm... perhaps.  But is it a realistic danger - I'll have to think
> > more about that.
> 
> It is trivial to avoid these dangers completely by not overloading
> the meaning of "device_type".

Hrm.  Perhaps.

> >>> I think we want to think a bit more carefully about how to do  
> >>> bindings
> >>> for RTC devices.  No "rtc" device_type is defined, but again we might
> >>> want to.
> >>
> >> Actually, "device_type" = "rtc" _is_ defined (in the "device support
> >> extensions" recommended practice), and there is no useful way a flat
> >> device tree can implement it (it merely defines get-time and set-time
> >> methods).
> >
> > Ah.. right.  That changes things a bit, in that we might want to
> > include device_type purely for similarity with real OF tree.
> 
> You should include the device_type only if you implement its binding,
> and a flat device tree does not, and cannot.  (In almost all cases,
> a flat device tree cannot implement device_type's semantics -- this
> means that pretty much the only case where a flat tree should use
> device_type is to have it as a workaround for bad kernel requirements).

I really don't think there's an ambiguity here.  A flat-tree can
clearly never implement runtime binding features.  This is also true
for a flat tree derived from a real OF, and so full of device_type all
over the place.

> > Real OF has a device_type == "nvram" too, doesn't it?
> 
> Yes, same "device support extensions" document.

Erm.. I've lost track amongst our various threads.  Which same
document?

> > AFAICT the real
> > OF systems I have (which I think all have ISA-like CMOS RTC/NVRAM
> > chips) the RTC is labelled as "nvram" rather than "rtc".
> 
> Sounds buggy.

Why?

[snip]
> > I did find one real OF binding for a different Dallas RTC (and NVRAM),
> > see:
> >
> > http://playground.sun.com/1275/proposals/Closed/Remanded/Accepted/346- 
> > it.txt
> >
> > It's a little different from the example above.
> 
> That is a binding for the nvram part only, not for the RTC.

Hrm.  So how do you suggest we do bindings for combined devices?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
