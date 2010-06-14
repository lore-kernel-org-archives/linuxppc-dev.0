Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 173EEB7D5B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 15:02:37 +1000 (EST)
Received: by gyf2 with SMTP id 2so2239472gyf.15
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 22:02:35 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4C146F18.9030008@firmworks.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Jun 2010 23:02:15 -0600
Message-ID: <AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	Olof Johansson <olof@lixom.net>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc'ing linux-arm-kernel because we're discussing ARM issues]

On Sat, Jun 12, 2010 at 11:39 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> Grant Likely wrote:
>>
>> On Sat, Jun 12, 2010 at 4:52 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>
>>>
>>> On Sat, 2010-06-12 at 06:30 -1000, Mitch Bradley wrote:
>>>
>>>
>>>>
>>>> I'm certainly going to try keeping OFW alive. =A0On the x86 OLPC machi=
nes,
>>>> the ability to
>>>> dive into OFW via a SysRq key combo was very helpful for debugging som=
e
>>>> difficult
>>>> problems. =A0The team has asked me to support the feature on ARM.
>>>>
>>>
>>> Oh well, if you can and can convince the ARM kernel folks to do the
>>> necessary changes ... :-)
>>>
>>
>> What is needed to keep OFW alive? =A0I've got no problem with doing so
>> if it isn't invasive, and as long as the same boot entry interface can
>> be used.
>>
>
> Minimally, OFW needs to own some memory that the kernel won't steal. =A0O=
FW on
> ARM
> is position-independent, so it can be tucked up at the top of memory fair=
ly
> easily.
>
> To call back into OFW, the virtual mapping for that memory needs to be
> reestablished.
> Or perhaps the MMU and caches can be turned off for the duration of the
> callback.
> I don't have the details of ARM MMUs and caches reloaded into my head yet=
.
> =A0Maybe next week...

Remapping the MMU could be hairy, but I see no issue with marking
OFW's memory as reserved.  How does OFW currently tell the OS what
memory it should not touch because OFW is using it?  Is it device tree
data or another mechanism?

> Also, for debugging, OFW typically needs access to a UART. =A0If the OS i=
s
> using the UART,
> it's often possible for OFW to use it just by turning off interrupts and
> polling the UART.

This doesn't sound onerous.

>> What is the use-case for having a dynamic device tree?
>
> The use case for a dynamic device tree is not compelling.
>
> In SPARC / Solaris land, Open Boot managed the non-volatile configuration
> variables, which the OS could access and modify dynamically as properties=
 in
> /options. =A0The OS didn't have to know the storage layout nor the hardwa=
re
> details of the storage device. =A0Convenient, but not hugely important.

I think the assumption can be made that this will not be a use case on ARM.

>> =A0I can see
>> keeping OFW alive being useful for some debug facilities, but once the
>> kernel has started, I'm really not interested in relying on firmware
>> to manage the hardware.
>
> That's sort of a self-fulfilling prophecy. =A0If the OS doesn't trust the
> firmware, there is no pressure for the firmware to "get it right".

Firmware will not get it right.  Period.  There will always be
something wrong.  It is never right on PCs.  It will never be right on
the other architectures.  That goes for OSes too, but upgrading an OS
isn't as risky as upgrading firmware.  That isn't to say that it can't
be close, but every firmware feature that the OS depends on is a
feature that could force a risky firmware upgrade when the bug in it
is discovered.

I'm also convinced that the economics are all wrong for "getting it
right" when talking about firmware.  Manufactures don't care about
firmware; they care about selling boxes.  Customers don't care about
firmware, they care about the operating system (well, that's not true
either, they care about applications).  For manufactures, once it can
boot the real operating system, there is little to no incentive to
spend any more money on firmware when the money can be better spent on
either the next product or the adding features to the operating system
of the existing product.  In fact, spending money on firmware is
actually *more risky* one a product ships, because if a firmware
upgrade goes bad, then that means product returned for repair at the
factory.

For me, this leads to two conclusions;
- That the OS should have little to no dependencies on the firmware
after it is booted so that bug fixes remain entirely in the realm of
the operating system.
- That the description of the hardware (ie Device Tree or ACPI) should
be decoupled enough from firmware that bugs in the data do not force a
firmware upgrade.  The data must always be updatabie.  Even if
configuration or data is completely corrupt, it must still be simple
to recover.

Note: I'm not critiquing OFW on either of these points.  These are
just some of my base requirements when I approach system design.

> In PC land, the current status quo is that Windows depends on ACPI so
> heavily that BIOS vendors pretty much have to get that part of the puzzle
> right. =A0Microsoft did a thorough job of creating certification tests an=
d
> enforcing their use. =A0I'm not praising ACPI, just pointing out the dyna=
mics
> that result from assignment of responsibility.

Yet how many boards are shipped with broken ACPI tables?  Just
bringing up ACPI in the presence of a kernel developer seems to bring
about the onset of Tourette's.  Bios provides enough data to be able
to boot the operating system, but in my experience it still requires
extra drivers to be added after installation for everything to work
right.

OTOH, I'm not had to deal with ACPI personally, so I may also be
talking out of my backside on this point.  :-)

> That said, I'm not interested in pushing the issue. =A0It's okay with me =
if
> the device tree is static as far as the kernel is concerned, and callback=
s
> to OFW are only used for debugging purposes.

The current intent is to only accept the flat tree representation when
booting the kernel.  So we'll need to encode the callback pointer into
the tree somewhere.

Cheers,
g.
