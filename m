Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 80857DDDA9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 23:51:53 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1538179ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 06:51:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A07C664.6040609@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 May 2009 07:51:31 -0600
Message-ID: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
Subject: Re: device trees.
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 12:32 AM, David H. Lynch Jr. <dhlii@dlasys.net> wro=
te:
> =A0 =A0But partial reconfiguration is not the only way to encounter a
> dynamic environment.
> =A0 =A0A typical pico system has multiple bit files and multiple
> executables stored in its flash file system.
> =A0 =A0Power up and soft resets might each run through a different sequen=
ce
> of bit files and executables.
>
> =A0 =A0My issue is that post 2.6.26 unless I can dynamically create the
> device tree inside our monitor/bootloader
> =A0 =A0we must at minimum have a different device tree for each bitfile,

This is true

> or worse if we wrap the device tree into the executable,
>    a different linux executable for each bit file.

As you say, this is undesirable.  simpleImage does this, but it it
intended for the least common denominator case where there is no
firmware support at all available and the kernel needs to be
completely contained.  simpleImage is not intended to be the ideal.

> =A0 =A0We are very actively headed in the opposite direction. It is my/ou=
r
> intention to have a single linux executable that works accross
> =A0 =A0everyone of our cards and everyone of our bitfiles.

That is the direction we are already going in.  U-Boot supports this.
In fact, I can build a single kernel image which will boot on all of
my MPC5200 boards, and my MPC83xx boards.  Similarly, if I have u-boot
running on a Virtex board, I can build a single image which will boot
all of them if the correct .dtb is passed to it.

You *could* generate the device tree dynamically, but I think that is
a path of diminishing returns considering that generating a .dts at
the same time as bitstream creation time is cheap and it is small.  At
one time Steven Neuendorffer was playing with a scheme to preload a
section of BRAM with a gzipped .dtb so that the correct device tree is
always present.  I really liked the idea, and I'd like to try to
pursue it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
