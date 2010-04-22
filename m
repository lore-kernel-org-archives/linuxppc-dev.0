Return-Path: <Sylvain.Lamontagne@novariant.com>
Received: from sm1.novariant.com (sm1.novariant.com [76.238.142.74])
	by ozlabs.org (Postfix) with ESMTP id BEE32B7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 06:23:04 +1000 (EST)
Subject: Re: Boot hang when setting console=none with MPC5200B custom board
From: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
To: Albrecht =?ISO-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
In-Reply-To: <1271964357.1672.1@antares>
References: <1271964357.1672.1@antares>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Apr 2010 16:23:01 -0400
Message-ID: <1271967781.12334.41.camel@slamon-laptop.novariant.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Albrecht,

> > 1. Is it possible ?
>=20
> Yes!  I tried this with several kernel versions (currently 2.6.33), using=
 the option 'console=3Dtty0'.  Works just fine...
>=20
Happy to know that it can be done !

> > 2. Do you have any idea how it can be achieve ?
>=20
> Hmmm, iirc, I also saw the effect you have.  I *think* the solution was t=
o ensure that all /dev/* files were created manually in the jffs image, not=
 by running mdev (if you use busybox).  But I might be wrong here, sorry.  =
Being at home, I don't have access to the device, but I can re-check tomorr=
ow.
>=20
Humm I see, here is the node I'm creating in the initial ramdisk, so
they are there before mdev is launched in one of my init scripts.
--------------------------------
console       c   5   1
null          c   1   3
zero          c   1   5
ptmx          c   5   2
tty           c   5   0
random        c   1   8
urandom       c   1   9
initrd        b   1   250
ram0          b   1   0
ram1          b   1   1
ram2          b   1   2
ram3          b   1   3
ramdisk -> ram0
ram -> ram0
loop0         b   7   0
loop1         b   7   1
--------------------------------

I think I have all the necessary device for boot, but if you could
double check with yours I would appreciated it.

> > 3. Do you know a bug in 2.6.29.2 that could prevent this to work ?
>=20
> Not sure if I used *exactly* that version w/o serial console, but (iirc) =
2.6.28.something, and then many different up to .33 - they all work!

Ok

>=20
> Best, Albrecht.

Thank you=20

Sylvain
