Date: Wed, 09 Oct 2002 21:29:29 -0600
Subject: Re: [Xpert]Re: Using the "chips" XFree86 driver on a PowerBook
	3400 (almost there.)
From: Michael Stephen Hanni <michael@deviant-behavior.com>
To: <xpert@XFree86.Org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B9CA5038.6E2%michael@deviant-behavior.com>
In-Reply-To: <Pine.BSF.4.44.0210091141170.56214-100000@shell.unixbox.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy.

Well I've got it all to work save for the "WritePixmap" acceleration as it
makes use of some fun MoveDataFromCPU/MoveDWORDS magic. With WritePixmap
active there is a small box of color distortion around the mouse cursor. I'm
sure the MoveDataFromCPU function is assuming little endian data, but I
don't know exactly what I'm looking at.

Oh, I haven't really touched this but XVideo is still fscked. I'm getting
BadAllocs all over the place.

on 10-9-2002 12:49 PM, Ani Joshi at ajoshi@unixbox.com wrote:

> It seems you have changed the address space to use the big endian
> aperture, this is correct.  As for the accel engine, try turning off all
> acceleration (just #if them out in the driver, no need for several XaaNo*
> Options), and leave on SolidFills, this is the easiset to debug.  There is
> a problem with some 65550's and polling of the BR04 register which tends
> to lockup the engine, you may be running into that.  I would grab the old
> source from Xpmac (I believe it had c&t accel) and poke around there to
> see where the engine is initialized and the proper way to BLTWAIT on this
> chip, its been long since I hacked on the c&t65550 so I don't remember
> sorry.

I had to mess around with the aperture, but I think I've got the aperture
and the MMIOBase setup correctly now. By dropping a slightly modified
ct_BltHiQV.h from the last Xpmac tarball into the latest XFree86 source
everything works nicely.

> As for the hardware cursor, you will have to swap the image of the cursor.
> See the hw cursor support for radeon (or r128) and apply similair
> necessary the big endian bits.

Ah, got ya.

I'm going to run some more tests and then I'll upload a patch somewhere for
general consumption. Maybe, just maybe, there are other people that use this
chip on a big endian machine.

Cheers,

Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
