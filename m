Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id D523FDDED8
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 12:15:34 +1100 (EST)
Received: by gxk1 with SMTP id 1so7084009gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 17:15:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
	<3B1D47A2-329E-491E-B3AC-E76C1CE1762D@it-loops.com>
	<fa686aa40903011353t464b1df3obd553132e5bc2570@mail.gmail.com>
	<CD026D29-687D-4078-960E-108CC94C30E4@it-loops.com>
Date: Sun, 1 Mar 2009 18:15:32 -0700
Message-ID: <fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Guntsche <mike@it-loops.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[moving this conversation back to the mailing list.  Don't forget to
use 'reply-all' on mailing list conversations.]

On Sun, Mar 1, 2009 at 4:49 PM, Michael Guntsche <mike@it-loops.com> wrote:
>
> On Mar 1, 2009, at 22:53, Grant Likely wrote:
>
>> On Sun, Mar 1, 2009 at 1:04 PM, Michael Guntsche <mike@it-loops.com>
>> wrote:
>>>
>>> On Feb 28, 2009, at 16:03, Grant Likely wrote:
>>>
>>>> Hey Michael,
>>>>
>>>> I just wanted to let you know that I'm reading your questions, and I'm
>>>> crafting a reply, but it's not trivial and I'm also swamped under at
>>>> the moment. =A0I should have something for you in the next few days. =
=A0I
>>>> just didn't want you to think you were being ignored.
>>>>
>>>> g.
>>>>
>>>
>>> Hi Grant,
>>>
>>> thanks for the help. As you might have already read, I can now boot wit=
h
>>> a
>>> self-written DTS file based of the device-tree.
>>> My three questions still remain.
>>>
>>> * Why not more than 4MB during boot
>>
>> First, are you building a cuImage, or a uImage? =A0It sounds like you're
>> building a cuImage to work with an older version of U-Boot. =A0With a
>> newer version of u-boot you can pass u-boot a kernel image and a
>> device tree blob (.dtb) which doesn't have this limitation.
>>
>
> Ok, I am building a simpleImage right now, since the routerboard (RB600A)
> does not seem to have uboot in the nand.
> Reading through the documentation again it clearly states that the
> simpleimage just uses the provided DTS file and nothing else.

Ah, okay.  Yeah, simpleImage gets you going, but ultimately it isn't
what you need.  I wrote simpleimage when I was working with Xilinx
Virtex platforms when booting a kernel with absolutely no firmware
support.

> The bootloader is called RouterBoot.
> So what the Board does (according to the docs).
>
> * During start it searches for a partition of type 0x27 in one CF slot. I=
f
> it finds the partition it expects a kernel in there and just boots it add=
ing
> a few parameters.

So, what you need is a new adapter which parses the data passed in by
routerboot (maybe call it routerImage?) and modifies the .dtb blob to
match.  You can use simpleImage as a starting point.

>> There is no reason for the 4MB limit in a cuImage other than that is
>> what is specified by default in arch/powerpc/boot/wrapper. =A0You can
>> change it. =A0It is not ideal, and the wrapper could be made more
>> robust, but it is what we have for the moment.
>>
>
> If you are talking about link_address=3D'0x400000'.
> I can increase this somewhat, if I Increase this too much I get a "Kernel
> region out of range" error from the boards bootloader apparently.
>
> To cut this short. I do need uboot on the board for either cuImage or uIm=
age
> support, right?

Yes, uImage and cuImage.* are u-boot specific.  You need a routerboard
specific image.

> Since the routerboard does have its own bootloader and I have not tried i=
f
> it is able to use a cuImage right now, is there another way to add the TB=
I
> entries?

TBI?

> Can't I just add them in the rbppc.c specific init stuff programmatically
> withouth a DTS file?

You need a device tree.  You could theoretically generate the entire
tree programmatically, but that is the long way around.  What you want
is a base .dts file and a new bootwrapper to fill in the missing bits
at boot time.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
