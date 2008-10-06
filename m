Return-Path: <neko@genesi-usa.com>
Message-ID: <48EA7DDE.7070805@genesi-usa.com>
Date: Mon, 06 Oct 2008 16:06:38 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: USB support on mpc5200 broken
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>	
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>	
	<1222307447.8277.147.camel@pasglop>
	<48E02FD0.8000809@genesi-usa.com>	
	<20080929034329.GB8694@yookeroo.seuss>	
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>	
	<48E243C5.7000100@genesi-usa.com>
	<1222831901.12264.8.camel@pasglop>
In-Reply-To: <1222831901.12264.8.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> This is what we were recommended to use at the time. There is a patch
>> on www.powerdeveloper.org which tweaks the tree to make it ultra-compliant
>> with the Linux version of things, which implements every variation. It
>> also implements a suggested patch which added a "big-endian" property
>> (not built in to the compatible property, but another property).
>>
>> I don't see why THAT patch got reverted as it was a great idea that we
>> all agreed was a great idea.
> 
> I agree. Something needs to be fixed on the OHCI OF stuff, it should
> definitely cope with the "big-endian" property (which is a practice
> borrowed from Apple that I recommended I think back then) and I don't
> see any problem with having ohci-be in the "compatible" property, its
> trivial enough to cope in the driver and being anal about it on the
> kernel side doesn't really bring any benefit.

I see a problem with having ohci-be being in there to the exclusion of
fixed properties on existing hardware that are not easy to realise what
changed (i.e. you upgrade your kernel, and not being an avid follower
of linux-usb or linuxppc-dev, wonder why USB stopped working).

It's not that easy for a lot of people who are not kernel developers to
find out WHY it broke let alone HOW to fix it (edit the USB compatibility
names list to re-add it, use efika.forth, edit a custom snippet in nvramrc
or a forth boot script, hack chrp_fixups some more - in order of increasing
brain death :)

> Care to send a patch ?

I don't really have time to go into it right now but I will look into
it. At some point I have to get my act together and release the latest
version of efika.forth as some things did change between that and the
latest Linux version...

>> Linux development around here is getting really schizophrenic. Nobody
>> is writing these decisions down even as comments in the source code..
> 
> That isn't entirely true. There's the ePAPR effort on power.org that is
> codifying a lot of that, and there are binding documents dropped in
> Documentation/powerpc.

You know I don't believe in Power.org any more than I believe in the
tooth fairy. Codifying ePAPR is just reverse engineering decisions made
a year ago with the booting-without-of.txt and the existing code, and
putting it into a document.

It didn't solve this situation and it won't - ePAPR can't help codifying
a board's device tree that was engineered, produced and will probably
be discontinued before a decent version of ePAPR will be released. Just
like ePAPR doesn't expect anyone conform to Apple device trees, ePAPR
will not make Efika device trees suddenly work without "help" (which is
why I wrote that forth script..)

>> No; you can have little endian OHCI controllers on big endian machines.
>> It's a property of the host controller, not the system architecture, just
>> like PCI is always little endian (except when you have magic in hardware
>> like Amiga PowerUP cards which endianswap for you :)
> 
> In fact, you can have both kinds on the same machine.

And all kinds of USB controllers at once. I have seen a Pegasos with a
little endian UHCI, big endian OHCI, little endian OHCI in the same
box. Very confusing for drivers. Don't get me started on the FireWire
OHCI, which I think above "ohci-be" really conflicts with in terms
of namespace.

What I thought we all agreed on before was this;

compatible = "usb-ohci, usb-ohci-be"
big-endian

Would be canonical. That way you can tell it's OHCI USB, it's big
endian for compatibility and big-endian property just in case the
driver forgot or was misled somehow (at least it should match on
usb-ohci, usb-ohci-be, then check if usb-ohci-be is present, and
then check for big-endian, and it will have a comprehensive
knowledge..)

There stands to be some discussion over whether mpc5200-usb-ohci
or mpc5200-ohci or mpc5200-usb is valid or required or not. You
still need to check for quirks (I am sure there ARE some) after
all.

I really wish it would be codified somewhere so that we could once
and for all put in exactly what it should be, and not just change
it at the whim of the latest patch (the reason we do not release
firmware this often is because the burden of releasing firmware does
not match the expectations of a 3-month-long kernel release where
the decisions are overturned, reverted and having 15 firmware
versions since release makes our life and your lives much harder
when fixing these things down. Efika stayed as it was, so it can
be consistently supported :)

I think the thing to do somewhere is note that while ePAPR is the
recommended practise, it's based on Open Firmware standards which
already exist, and there are still Open Firmware standard firmwares
which still exist, which may not be so easily updated as to just
run the device tree compiler and attach it to a kernel, so when
making decisions about naming or submitting patches about naming,
check out the users of that peripheral and make sure you're not
just submitting a patch assuming that everyone can update their
device tree WITH their kernel :D

> Note about the Amiga stuff: it's a bad idea :-) Every attempt at
> "magically" fixing endian in HW is a recipe for tears and disasters.
> Approximately ... always. The only cases that I know that have a remote
> chance of being useful are specifically programmable swappers on a given
> device or per-page endian configuration in the processor (like BooKE).

I do like that system. But as you said, there are uses for it; and
the APUS swap implementation did allow raw access, 16-bit and 32-bit
swaps through "mirrored" memory regions - you could write any way
you wanted if you so pleased, or just handle the difference yourself,
or do both if you were a masochist :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
