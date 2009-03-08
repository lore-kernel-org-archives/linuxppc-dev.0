Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 086A9DDF6B
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 18:35:10 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so505054ywb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Mar 2009 23:35:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <62692.70.162.219.205.1236443872.squirrel@oz.embeddedx86.com>
References: <62692.70.162.219.205.1236443872.squirrel@oz.embeddedx86.com>
Date: Sun, 8 Mar 2009 00:35:08 -0700
Message-ID: <fa686aa40903072335o5874369by279aa3526fb8621d@mail.gmail.com>
Subject: Re: [PATCH, RFC]
From: Grant Likely <grant.likely@secretlab.ca>
To: eddie@embeddedarm.com
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

On Sat, Mar 7, 2009 at 9:37 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrot=
e:
> Hello,
>
>>> So if you have any suggestions on
>>> this approach using the simpleImage please let me know.
>>
>> Before I answer this, what bootloader are you using?
>
> We are using a custom bootloader we developed ourselves. The bootloader i=
s
> very minimal as one of our primary design goals is a fast boot time. We d=
o
> some basic initialization of the AMCC 440EP, then load the simpleImage
> into RAM at address 0 and jump into it. In my mind I had considered our
> code as more of a bootrom and the simpleboot.c as a bootloader ;)
>
>>> On another note, can you tell me/point me to some documentation on how
>>> to get a unique machine ID for a new board?
>>
>> What do you mean? =A0Are you referring to the top level compatible and
>> model properties?
>
> I think I might be getting ahead of myself, as I'm not yet up to speed on
> how the powerpc code base identifies unique machines. For instance the AR=
M
> codebase required that each new machine have a unique machine ID. When
> bringing up a new platform one had to request a new unique machine ID. Th=
e
> bootloader was required to pass this unique machine id to the kernel.
> We're still using quite a bit of the Yosemite code base and so I had
> assumed we are probably using the Yosemite boards "unique machine id" for
> our custom hardware. Although based on your response it sounds like
> powerpc =A0uses a different approach.

The powerpc kernel completely trusts the device tree blob that is
passed to it at boot time.  Most of the platform support code simply
reads the top level 'compatible' property to decide whether or not it
can support the board.  For example,
arch/powerpc/platforms/44x/ppc4xx_simple.c supports a bunch of boards,
including yosemite, and arch/powerpc/platforms/44x/ebony.c only
supports the ebony board.  ppc4xx_simple.c, ebony.c, and other
platform support files can selected at the same time to build a kernel
which supports multiple boards (multi-platform).

Since there is no common boot mechanism shared between all powerpc
platforms, the bootwrapper is the adapter layer from whatever data is
provided by firmware to the form required by the kernel.  As long as
the kernel-proper (vmlinux) receives a fully formed device tree at the
end, it is happy.  Both firmware and the boot wrapper have the option
of modifying the device tree before passing it on to the next step.
One of the boot methods (uImage) even bypasses the bootwrapper step
entirely since U-Boot is able to pass a fully formed device tree
directly to the kernel.

One of the advantages of the device tree scheme is that the kernel
image format no longer needs to be board dependent.  There is no need
to encode a board specific format anymore.  Sure, you *can* use
simpleImage or dtbImage to build an image with an embedded dtb, but
those images are really just compatibility layers for existing
firmware, and using them throws away the advantage of splitting the
hardware description from the kernel image.  Not to mention that the
building of board specific images is a maze of special cases and
barely documented heuristics in arch/powerpc/boot/wrapper.

If you've got control over your boot firmware, and you don't want to
use U-Boot, then I strongly recommend that at the very least you keep
the .dtb separate from the kernel image and don't write any board
specific code in the boot wrapper.  Keep your board specific code in
arch/powerpc/platforms/44x/* where it is easy for mere mortals to
comprehend.  Get the firmware to copy both the dtb and kernel into RAM
and pass the dtb pointer to the kernel.  Ideally, you should use the
existing uImage format so you don't need to define something new (and
incompatible with anything else).  However, parsing uImage requires
your firmware to include gunzip code.

Failing that, create a new zImage target (perhaps 'zImage.fdt') that
accepts a pointer to the .dtb blob in memory.  Use the calling
convention described in Documentation/powerpc/booting-without-of.txt
for direct flattened device tree booting.  At least that way your code
has a fighting chance of being useful to someone else.  Code to do
this should be pretty trivial.  In fact the simpleImage platform_init
could be refactored to provide a large chunk of common code.  Only
difference really being the source pointer to the dtb.

Heck, you could even eliminate the boot wrapper entirely and use the
vmlinux image directly; but the kernel image can be quite large and
then you'd probably want it gzipped (which means our firmware must be
able to gunzip it).

One last think.  It's not a good idea to link the .dtb image into the
firmware either.  Many people have learned the hard way that device
trees often need to be tweaked after the firmware is deployed.  Make
the dtb a separate image that can be updated in the same way that the
kernel image can be updated.

Have fun,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
