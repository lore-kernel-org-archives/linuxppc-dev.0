Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 57E34B7CB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 06:24:22 +1100 (EST)
Received: by pwj7 with SMTP id 7so6157273pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 12:24:21 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <b268a2e41003171430m4e6b9178odd005273df6eb5c8@mail.gmail.com>
References: <b268a2e41003171430m4e6b9178odd005273df6eb5c8@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 13:24:01 -0600
Message-ID: <fa686aa41003261224s2549e752i6003d7534a5e661d@mail.gmail.com>
Subject: Re: Getting MPC5200 up and running - Media5200 and 2.6.33.1
To: Mark Schaefer <mark@markschaefer.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc'ing linuxppc-dev@lists.ozlabs.org]

On Wed, Mar 17, 2010 at 3:30 PM, Mark Schaefer <mark@markschaefer.org> wrot=
e:
> Hi Grant,
>
> =A0=A0=A0=A0 I was able to get kernel 2.6.16 running on a Media5200 using=
 ltib, but
> what I would really like to do is build a current kernel with SocketCAN.
> I've read and read the various groups and I know that I have to do
> cuImage.media5200 to get around the ancient u-boot, but I still get nothi=
ng
> after the kernel is uncompressed.

There are probably some properties that you need to add to the device
tree so that the kernel can find the console.  I can't remember off
the top of my head exactly what you need to do here.  But even then
the cuImage was very unstable on the media5200.  I ended up having to
upgrade U-Boot on the media5200 because it just couldn't reliably boot
the kernel.

Unfortunately I lost the source to the u-boot port, so I'd have to do it ov=
er.

>=A0 The Media5200 runs u-boot 1.1.5, so my
> options are limited.=A0 What I'm really trying to do, however, is get it =
up on
> a custom 5200 board that has u-boot 1.3 running on it.=A0 My thought was =
that
> if I could get the kernel up on a well-known board I would have a much
> better time getting it on a custom board.
>
> Questions:
> 1) is there a "board startup" guide for powerpc?

Not really.  I kind of did a presentation on this for ELC last year.
Here's are the links:

http://www.embeddedlinuxconference.com/elc_2009/sessions.html#Likely
http://free-electrons.com/blog/elc-2009-videos/

> 2) What is the best recent kernel to work from?=A0 I definitely like the
> additional low-level 5200 drivers, but what are they being tested against=
?

Use Linus' mainline.

> 3) How far am I going to be able to get without a BDI3000 / JTAG emulator=
?

Not very far.  You need to get firmware on the board and without JTAG
you're either by doing nasty tricks with the bus on reset (which you
need to build custom hardware to do) or popping flash chips off the
board for reprogramming.

> P.S.=A0 I would be happy to put this on a mailing list if you think other=
s
> will benefit.=A0 Just wasn't sure which list is best.

linuxppc-dev@lists.ozlabs.org

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
