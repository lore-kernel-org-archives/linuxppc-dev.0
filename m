Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 34E74DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 02:08:03 +1100 (EST)
Received: by gxk1 with SMTP id 1so7770654gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Mar 2009 07:08:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c19541729a7d99548faadbabe5c7646c@localhost>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
	<3B1D47A2-329E-491E-B3AC-E76C1CE1762D@it-loops.com>
	<fa686aa40903011353t464b1df3obd553132e5bc2570@mail.gmail.com>
	<CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
Date: Mon, 2 Mar 2009 08:08:02 -0700
Message-ID: <fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Guntsche <mike@it-loops.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 2, 2009 at 4:58 AM, Michael Guntsche <mike@it-loops.com> wrote:
> On Sun, 1 Mar 2009 18:15:32 -0700, Grant Likely <grant.likely@secretlab.c=
a>
> wrote:
>>
>> So, what you need is a new adapter which parses the data passed in by
>> routerboot (maybe call it routerImage?) and modifies the .dtb blob to
>> match. =A0You can use simpleImage as a starting point.
> I had a look at that. And this is what I understood so-far.
> SimpleImage just takes the dtb from the segment and parses it as the new
> device tree.
>
> =A0_dtb_start =3D .;
> =A0.kernel:dtb : { *(.kernel:dtb) }
> =A0_dtb_end =3D .;
>
> No I do understand that dtb_start points to this device tree. I also know
> that the standard kernel boot-process
> is able to read he device tree out of the firmware/bootloader (it works i=
f
> I just put with a standard kernel image)

Only if the firmware supports passing in a device tree.  Many embedded
firmwares do not, in which case the .dtb must be linked into the
bootwrapper statically.

> but I cannot figure out, where
> exactly (in the code) it is doing that.

Every bootwrapper image (simpleBoot, zImage, cuImage, etc.  uImage is
the exception; it doesn't use the bootwarpper) has a function called
platform_init() with the arguments r3, r4, r5, r6, and r7 which hold
the values of those registers when the bootwrapper is called.
platform_init() is called by crt0.S before calling the 'start()' entry
point in main.c and one purpose of it is to adapt the information
available about the board into the device tree.

platform_init is different for each kind of bootwrapper image.  In
simpleboot.c, r3-r7 are simply ignored.  In a cuImage, a pointer to
the bd_info structure is retrieved from r3 (cuboot.h).

> My problem is now that I have zero
> documentation of the existing bootloader. All I know is that the prom cod=
e
> is able to find and parse it.
> So now my question, is there a way to get to the device tree at this stag=
e
> of the boot process?

You mean like loading it of the CF or something?  Yeah, I suppose so
if you wrote a minimal CF driver, but that seems the hard way around
also.  You're far better off to statically link in a .dtb image and
modify it.  If the bootloader doesn't provide you with any useful
information, you can read the SoC registers to detect memory size and
clock rate.  If you're lucky, the bootloader will have already
assigned the correct MAC addresses for you and you can read those out
also.

You can also try inspecting the memory pointed to by r3-r7 and seeing
if any of them point to something interesting.

>>> Can't I just add them in the rbppc.c specific init stuff
> programmatically
>>> withouth a DTS file?
>>
>> You need a device tree. =A0You could theoretically generate the entire
>> tree programmatically, but that is the long way around. =A0What you want
>> is a base .dts file and a new bootwrapper to fill in the missing bits
>> at boot time.
>
> Well the board already provides a device tree so all I would need is the
> missing entries so the PHYs are detected correctly. So I would modify an
> existing tree.

Oh.  So routerboot does understand dtb blobs?  Okay, I didn't
understand that.  Yes, you can call the libfdt functions in your
platform_init() to add the missing nodes.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
