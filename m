Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 2405CDDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 09:09:52 +1000 (EST)
Received: by gxk20 with SMTP id 20so6310104gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 16:09:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A089AC8.9080704@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 May 2009 17:09:27 -0600
Message-ID: <fa686aa40905111609l3feaf555taadf048714030a1@mail.gmail.com>
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

On Mon, May 11, 2009 at 3:38 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrot=
e:
> Grant Likely wrote:
>>
>> What do you mean by "one size fits all solution?"
>>
>> The kernel doesn't care where the device tree comes from. =A0All it
>> cares about is that by the time the kernel is started the device tree
>> must be fully formed and populated. =A0It can be completely pre-canned
>> (like simpleImage), it can be modified by firmware (like u-boot), or
>> it can be generated from scratch (like with real OpenFirmware). =A0There
>> is lots of flexibility on how to handle it.
>>
>>
> First device trees are now the ONLY means of =A0passing information to th=
e
> kernel.
> By definition that means it is a one size fits all solution.
> While there is nothing inherently wrong with that, solutions intended to
> meet all circumstances need to be
> simple, powerful, and flexible. They need to work well 100% of the time
> not 98%.
>
> Not only is the device tree expected to pass static hardware
> configuration information, but it is the sole means of passing anything.
> As an example Command lines are to be in the device tree.
> Everything is supposed to be in the device tree, whether that
> information is static or dynamic, whether it is hardware information,
> or user choices.

It is the sole means of passing anything *to the kernel*.  You can
pass whatever you like to the bootwrapper.  :-)

> =A0 =A0That means that whether you are in a Sun or Apple Desktop or a
> system with the no flash and barely enough resources to run Linux,
> you still may have to manipulate the device tree.

...or if you really are constrained, then define a format for the data
you want to pass, pass it to the bootwrapper along with the device
tree, and use the bootwrapper (which already has libfdt) to update the
device tree.  cuImage targets do this to support older u-boots which
don't understand device trees.  You are not forced to put device tree
support in your firmware.

In other words; having your bootloader support FDT is preferred, but
not required.

Word of warning; if you do define your own format, be very very very
careful.  Otherwise you end up with something subtly broken and not
future proof.  This is one of the reasons adding FDT support to your
firmware is preferred; these issues have already been thought about.

> =A0 =A0Though I still have an issue. One of the problem with 98% solution=
s,
> is that they result in a chain of work arrounds for
> =A0 =A0the other 2%. Instead of one case or two cases, you end up with a
> dozen cases each handling increasingly tiny slivers.
> =A0 =A0And it becomes increasingly easy to claim that the problem is with
> the slivers not the broad solution.

No, it's not.  Everything you need to do can be done within the
bootwrapper if you so desire, passing data in whatever format you
like.

> =A0 =A0I am not sure what you are saying here ?
> =A0 =A0By firmware do you mean bootloader ? Or do you mean bitfiles ?

Yes, I'm using the terms "firmware" and "bootloader" interchangeably.

>> I still don't understand what you're worried about starting an arguing
>> about. =A0Pretty much any of the PowerPC maintainers can point at warts
>> and problems in the current handling of device trees. =A0I'm not
>> particularly happy with simpleImage (and I wrote it), but it takes
>> time and effort to write something more capable.
>>
> =A0 =A0I was not trying to start an argument, my initial question was
>
> =A0 "Is there an example somewhere that shows building a device tree on t=
he fly ?"
>
> =A0 The responses have questioned why I want to do that rather than how c=
an I do that.
> =A0 I was not actually seeking a debate over the merit of device trees, o=
r u-boot, or libdft, or ....

... but the questions were necessary to understand your problem set.
I cannot give good advice without understanding.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
