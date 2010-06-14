Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id F02211007D2
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 15:37:18 +1000 (EST)
Received: by gyf2 with SMTP id 2so2248988gyf.15
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 22:37:17 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276417792.1962.731.camel@pasglop>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com> <1276408773.1962.574.camel@pasglop>
	<4C147EA5.3060500@firmworks.com> <1276417792.1962.731.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Jun 2010 23:36:57 -0600
Message-ID: <AANLkTimc12G-YYTd4yQiviY-ijvJ9TzVEmxxaoF43xVR@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>, Dan Malek <ppc6dev@digitaldans.com>,
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

On Sun, Jun 13, 2010 at 2:29 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-06-12 at 20:45 -1000, Mitch Bradley wrote:
>
>> Either fought or embraced. =A0To the extent that it is possible to focus
>> solely on Linux and ARM, one could image doing a good HAL.
>
> That will come with a huge amount of comunity resistance sadly, but I
> can imagine distros liking it.
>
> In general, I much prefer having all the necessary native drivers in the
> kernel, and the device-tree to provide the right representation, and
> avoid trying to abstract "methods" via a HAL. It's the Linux philosophy
> as much as possible (even when defeated by ACPI).
>
> But if we're going to be forced by vendors into HALs, we can also make
> sure that whatever they come up with is half reasonable :-)

I think there is more to be concerned about regarding binary blobs
than HALs.  Many of the new SoCs require closed binaries to use all
the hardware right now (graphics cores in particular).

Board vendors seem to be taking the plunge and modifying the kernel
rather than trying to create a HAL for driving board specific
features.

>> (The reason I say ARM-only is =A0because the
>> only other non-x86 architecture that has any "legs" left is PowerPC, and
>> PPC already has a coherent story.)
>
> Well, ppc story isn't that coherent as far as this goes :-) We don't
> keep OF alive, we have RTAS which is a pile of poo... etc...
>
> But yeah, we are fine without a HAL, so if we stick to OF as a
> bootloader and provider of the device-tree, we are fine.
>
>> > To some extent, in fact, doing that sort of stuff in OF or even in RTA=
S
>> > like we do on power is even worse than ACPI-like tables. At least with
>> > those tables, the interpreter is in the operating system, thus can run
>> > with interrupts on, scheduling on, etc...
>>
>> I have an FCode interpreter that can live inside the OS. =A0It's
>> considerably simpler than the ACPI interpreter.
>
> That's the one thing I purposefully avoided mentioning :-)
>
> It's an interesting idea, I've though about it. If course, there's all
> sort of things to be careful about, such as who provides the f-code with
> virtual->physical mappings to devices, how they are represented, how
> much of the OF "forth" environment is accessible to such f-code, locking
> between f-code and kernel use of shared resources (especially true when
> dealing with things like i2c devices, plls, etc...).
>
> IE. THe base idea is simple. The implementation can be a huge can of
> worms.
>
> Cheers,
> Ben.
>
>> > =A0With RTAS, or client interface
>> > calls, you'll end up with potentially huge slumps of CPU time "lost"
>> > into the bowels of the firmware.
>> >
>> >
>> > Cheers,
>> > Ben.
>> >
>> >
>> >
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
