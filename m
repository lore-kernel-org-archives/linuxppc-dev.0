Message-Id: <5.2.1.1.2.20030804104557.01f0fe00@mail.lauterbach.com>
Date: Mon, 04 Aug 2003 10:49:47 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243:
  error: invalid lvalue in asm statement
Cc: Paul Mackerras <paulus@samba.org>,
	Miles Lane <miles.lane@comcast.net>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1059910283.3519.121.camel@gaston>
References: <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
 <200308021823.30382.miles.lane@comcast.net>
 <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 13:31 03.08.2003, Benjamin Herrenschmidt wrote:

>On Sun, 2003-08-03 at 13:23, Paul Mackerras wrote:
> > Miles Lane writes:
> > >
> > >   CC      drivers/input/evdev.o
> > > drivers/input/evdev.c: In function `evdev_ioctl':
> > > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> > > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> > > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> > > drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> >
> > These errors are a consequence of the change I made to make get_user
> > work on 64-bit quantities.  I can't actually see a way to have
> > get_user work when it's used the way it is here and also work on
> > 64-bit quantities, without giving spurious warnings when used on
> > pointers.
> >
> > Who was it that wanted 64-bit get_user?  I think we are going to have
> > to make a separate get_user64().
>
>No Paul, it's not your fault, if you look closely at evdev, that code
>can't really work properly anyway.

Well, his patch to get_user exposed it, but the bug is really in the very
questionable use of the gcc extension to accept ?: expressions as lvalue,
see <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=11564>

>I talked to Vojtech at OLS and he'll be fixing that to always pass
>either an u32 or an int to userspace.

I've sent him a patch too as a result of the above GCC PR.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
