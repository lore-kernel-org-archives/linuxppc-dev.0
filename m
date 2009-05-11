Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id F0FD0DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:48:04 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1609963ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 10:48:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A085612.9050602@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 May 2009 11:47:43 -0600
Message-ID: <fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
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

On Mon, May 11, 2009 at 10:45 AM, David H. Lynch Jr. <dhlii@dlasys.net> wro=
te:
> Grant Likely wrote:
>>
>>> =A0 =A0We are very actively headed in the opposite direction. It is my/=
our
>>> intention to have a single linux executable that works accross
>>> =A0 =A0everyone of our cards and everyone of our bitfiles.
>>>
>>
>> That is the direction we are already going in. =A0U-Boot supports this.
>> In fact, I can build a single kernel image which will boot on all of
>> my MPC5200 boards, and my MPC83xx boards. =A0Similarly, if I have u-boot
>> running on a Virtex board, I can build a single image which will boot
>> all of them if the correct .dtb is passed to it.
>>
> =A0 =A0I was not aware that u-boot was currently doing that, but I was
> aware that was possible.
> =A0 =A0It is the most useful alternative to simple image.
> =A0 =A0I was not specifically trying to criticize simple image.
> =A0 =A0My problem is not with specific means of handling device trees.
> =A0 =A0It is that it is a one size fits all solution, and it is not
> sufficiently flexible for that.

What do you mean by "one size fits all solution?"

The kernel doesn't care where the device tree comes from.  All it
cares about is that by the time the kernel is started the device tree
must be fully formed and populated.  It can be completely pre-canned
(like simpleImage), it can be modified by firmware (like u-boot), or
it can be generated from scratch (like with real OpenFirmware).  There
is lots of flexibility on how to handle it.

>> You *could* generate the device tree dynamically, but I think that is
>> a path of diminishing returns considering that generating a .dts at
>> the same time as bitstream creation time is cheap and it is small. =A0At
>> one time Steven Neuendorffer was playing with a scheme to preload a
>> section of BRAM with a gzipped .dtb so that the correct device tree is
>> always present. =A0I really liked the idea, and I'd like to try to
>> pursue it.
>>
> =A0 =A0I would prefer not to waste bram by filling it with a device tree.
> =A0 =A0The best alternative to creating the device tree dynamically would
> be to
> =A0 =A0append the devicetree to the bitimage in a way the boot loader cou=
ld
> always find it.

That sounds like a good solution to me.

As for using up BRAM, a gzipped dtb image is smaller than 2k and it
can be reclaimed for other uses after the kernel has booted.  That may
not help your situation, but for my use cases the tradeoff works.

> =A0 =A0Regardless it still makes my point. =A0The problem with devicetree=
s as
> they are is that they handle probably 98% of all cases well.
> =A0 =A0The remaining 2% are a mess.

No it isn't.  It is expected that firmware will fixup the device tree
data with board specific values.  This is intentional.  The device
tree is simply the bearer.  It makes no determination about where the
data comes from.

> =A0 =A0lots of .dtb files lying arround is only a better solution than
> simpleimage.
> =A0 =A0I will guarantee that unless they are welded together the wrong
> device tree will get used with the wrong bit file.

I agree.

> =A0 =A0Inevitably I will make that mistake myself occasionally and waste
> hours or possibly days trying to debug it.
> =A0 =A0And if I will do it rarely clients will do it frequently.
>
> =A0 =A0In my expereince if you create a situation where confusion can exi=
st
> it will.
>
> =A0 =A0It is also my expereince that time spend coding a solution to a
> common client problem is well spent.
> =A0 =A0If it takes me a week to work out dynamically creating a device
> tree, that ill likely save many weeks of
> =A0 =A0support headaches.

Again, it doesn't sound like you want dynamic *creation* of device
trees.  It sounds like you want a reliable way to make sure the
bitstream is welded together with the correct dtb, preferably within
the Xilinx toolchain.

> =A0 =A0Even if I do not end up creating the device tree dynamically, I am
> likely to end up at a minimum doing some validation on it.
> =A0 =A0i.e. once the bitfile is loaded scanning the device tree and probi=
ng
> to ascertain that the hardware that I am supposed to expect
> =A0 =A0it really present.

If you like.

> =A0 =A0ultimately devicetrees are supposed to be a database not a black b=
ox.

I don't understand what you mean by this statement.

> =A0 =A0Anyway, all I was looking for was a leg up on figuring out how to =
do
> what I want with them. Rather than starting from scratch.
> =A0 =A0I am not looking to be convinced that I am approaching this all wr=
ong.
> =A0 =A0If you are happy with what you have - great. I am not.
> =A0 =A0While I was not looking to restart a great debate over device tree=
s
> - I do not actually think they are a bad idea.

I still don't understand what you're worried about starting an arguing
about.  Pretty much any of the PowerPC maintainers can point at warts
and problems in the current handling of device trees.  I'm not
particularly happy with simpleImage (and I wrote it), but it takes
time and effort to write something more capable.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
