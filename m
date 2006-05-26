Return-Path: <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060526064341.GA6183@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
	<1148624357.8089.88.camel@localhost.localdomain>
	<20060526064341.GA6183@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 26 May 2006 17:33:51 +1000
Message-Id: <1148628831.8089.107.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, Steve Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I think a new feature bit is the way to go but we need to start now
> > about how to extend our feature bit facility, maybe by defining an
> > AT_HWCAP2 ? Steve, what is your position there ?
> 
> And what happens when that gets full? Or can we make that one dynamic in
> size?

You can't make AT_* entries dynamic, though we can be ugly and have them
contain an offset to some space on the stack with a blob, though that
would require serious hacks in the kernel's binfmt_elf I suppose. Even
if it's a bit ugly, there is no fundamental problem with adding
AT_HWCAP2 and maybe later 3 etc... A given bit is defined to be in a
given one of these, thus apps who know about a bit that is in AT_HWCAP-N
(and are looking for it) will also know about AT_HWCAP-N. Still ugly
tho.

> > Thus should we add a feature bit documenting the existence of those
> > instructions or should we use an errata bit (provided we define
> > something for passing them as suggested above) ?
> 
> Only if there's truly uses for it. Do we really want to allocate global
> bits for every errata that every vendor introduces?

If they affect userland, yes.

> Do we see this likely to be used in "global userspace", or more likely
> in the processor-specific glibc sections? If it's in the
> processor-specific ones, maybe we should have a per-processor bitfield
> with erratas/features instead of a global one. That'd make allocation
> easier too.

Do we have to deal with that many errata that affect userland ? It's
generally an area where processors are fairly well validated... I don't
think we need to scale up that much on this one.

> I.e. a main feature bitmask like we have now (architecture base
> version), and a sub-bitmask with the optional features. That also avoids
> the issue of allocating a global bit for something that is a feature in
> version X but non-optional in X+1, you can never "get that bit back".

Could be. Steve, what do you think ?

> > Yes, I think a new CPU feature bit for that too is needed. Not much of
> > these left...
> 
> Well, are these instructions architected in some later version past
> 2.02? If so, the bit is only needed on the older processors -- yet again
> a case for sub-feature/errata bitmasks.

I have to check but I suspect it's still optional.

> [rest is good discussion but I don't have much input on it at this time.
> Something gestalt-like could be good, it'd help remove some of the
> current limits on bitmap sizes, etc]

Ben.
