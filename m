MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16172.61621.985947.378822@cargo.ozlabs.ibm.com>
Date: Sun, 3 Aug 2003 21:23:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243: error: invalid lvalue in asm statement
In-Reply-To: <200308021823.30382.miles.lane@comcast.net>
References: <200308021823.30382.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Miles Lane writes:
>
>   CC      drivers/input/evdev.o
> drivers/input/evdev.c: In function `evdev_ioctl':
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement
> drivers/input/evdev.c:243: error: invalid lvalue in asm statement

These errors are a consequence of the change I made to make get_user
work on 64-bit quantities.  I can't actually see a way to have
get_user work when it's used the way it is here and also work on
64-bit quantities, without giving spurious warnings when used on
pointers.

Who was it that wanted 64-bit get_user?  I think we are going to have
to make a separate get_user64().

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
