Return-Path: <imp@bsdimp.com>
Date: Sun, 27 Jul 2008 22:16:28 -0600 (MDT)
Message-Id: <20080727.221628.-1956307928.imp@bsdimp.com>
To: jonsmirl@gmail.com
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
References: <9e4733910807270721h5777bb80u9f3d25413a62883c@mail.gmail.com>
	<77a246d166f3eafb4d6a5d899ff86945@kernel.crashing.org>
	<9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: <9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
            "Jon Smirl" <jonsmirl@gmail.com> writes:
: On 7/27/08, Segher Boessenkool <segher@kernel.crashing.org> wrote:
: > >
: > > >
: > > > > compatible = "atmel,24c32wp", "24c32", "eeprom";
: > > > >
: > > >
: > >
: >
: >
: > >
: > > > I know this is just an example; but to keep thinks clear, the second
: > > >  and third values in this compatible property are completely bogus (for
: > > >  device trees).  The manufacturer prefix needs to be present and
: > > >  'eeprom' is far to vague.
: > > >
: > >
: > > Isn't 24c32 a generic, cross manufacturer term used for these devices?
: > >
: >
: >  Sure it is.  But "compatible" values are a global namespace so care
: >  needs to be taken not to cause collisions.  One mechanism for that
: >  is to use vendor prefixes (and that just shifts the problem so it
: >  is less global); another is to choose good names that have a lower
: >  chance to collide with the name for another device.  And the most
: >  important way to prevent collisions is to write up a binding, so
: >  everyone knows you have claimed that name.  It still needs to be
: >  a good name, of course.
: >
: >
: > > What if I have a socket and use a different vendor's chip each week?
: > >
: >
: >  You use sockets for your seeproms?  Wow :-)  But yes, it shouldn't
: >  be necessary to put the exact make of the device in the device
: >  tree, for such generic devices.  It certainly doesn't hurt to do
: >  so though (if the exact model is known).
: >
: >  A reasonable "compatible" value would be something like
: > "serial-eeprom-24c32".
: >  You can go a little bit more generic than that, if you write up in
: >  your binding how the driver should figure out the device size and
: >  the protocol used.
: 
: Matching on "serial-eeprom-24c32" requires me to convince the at24
: authors to add that string as an alias binding for their driver. How
: about "serial-eeprom,24c32" or "generic,24x32"?

Many of the serial eeproms have a common way to access them.  There's
a few organizations of eeproms made by a number of different
manufacturers that are actually accessed the same.

Warner
