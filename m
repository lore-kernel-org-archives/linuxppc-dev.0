Subject: Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243:
	error: invalid lvalue in asm statement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Miles Lane <miles.lane@comcast.net>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
References: <200308021823.30382.miles.lane@comcast.net>
	 <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1059910283.3519.121.camel@gaston>
Mime-Version: 1.0
Date: 03 Aug 2003 13:31:24 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-03 at 13:23, Paul Mackerras wrote:
> Miles Lane writes:
> >
> >   CC      drivers/input/evdev.o
> > drivers/input/evdev.c: In function `evdev_ioctl':
> > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
>
> These errors are a consequence of the change I made to make get_user
> work on 64-bit quantities.  I can't actually see a way to have
> get_user work when it's used the way it is here and also work on
> 64-bit quantities, without giving spurious warnings when used on
> pointers.
>
> Who was it that wanted 64-bit get_user?  I think we are going to have
> to make a separate get_user64().

No Paul, it's not your fault, if you look closely at evdev, that code
can't really work properly anyway.

I talked to Vojtech at OLS and he'll be fixing that to always pass
either an u32 or an int to userspace.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
