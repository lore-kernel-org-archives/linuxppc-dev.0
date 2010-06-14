Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 8431DB7D82
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 15:24:09 +1000 (EST)
Received: by gwb15 with SMTP id 15so241320gwb.15
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 22:24:07 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276408773.1962.574.camel@pasglop>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com> <1276408773.1962.574.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Jun 2010 23:23:45 -0600
Message-ID: <AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
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

[cc'ing linux-arm-kernel]

On Sat, Jun 12, 2010 at 11:59 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-06-12 at 19:39 -1000, Mitch Bradley wrote:
>
>> Minimally, OFW needs to own some memory that the kernel won't steal.
>> OFW on ARM is position-independent, so it can be tucked up at the top of=
 memory
>> fairly easily.
>
> Amen :-)
>
>> To call back into OFW, the virtual mapping for that memory needs to be
>> reestablished.
>
> That's a nasty part unless ARM provides a usable "real mode" which
> allows MMIO accesses, which I -think- it does. I don't remember the
> details that much.
>
> Maybe we could define a binding tho where we could somewhat standardize
> the portion of the virtual address space used by OF. IE. from the top of
> the address space down to the max size it requires. It might require
> some games to play with the fixmap on ARM side tho...
>
> Another option would be something more RTAS-like where a specific call
> can be done by the OS itself to 'relocate' (not physically but virtually
> in this case) OF into the OS preferred location. Be prepared to have
> multiple of these called though as kernels kexec into one another.

This sounds reasonable to me.

>> Or perhaps the MMU and caches can be turned off for the duration of the
>> callback.
>> I don't have the details of ARM MMUs and caches reloaded into my head
>> yet. =A0Maybe next week...
>
> Forgot most of it too. Looks like it's about time I read the ARM
> architecture again, this sounds like fun :-)
>
> BTW. I notice no ARM list is CCed on this discussion ... maybe we should
> fix that ?

cc'ing linux-arm-kernel in all my replies

>> Also, for debugging, OFW typically needs access to a UART. =A0If the OS =
is
>> using the UART, it's often possible for OFW to use it just by turning of=
f interrupts and
>> polling the UART.
>
> That might not be a big deal unless the OS plays with the clocks which
> it -does- tend to do. It might be worth defining some kind of property
> OF puts in the UART node to inform the OS not to play games and keep
> that one enabled, though that could affect power management, so might
> need to be conditional on some nvram option (debug-enabled?)
>
>> The use case for a dynamic device tree is not compelling.
>
> Right, generally not, except in virtualized environments (see my other
> response).
>
> Now, the -one- thing that WILL happen if we have something like OF that
> remains alive is of course vendors will try to use it as a HAL. You know
> as well as I do that it -will- happen :-)
>
> There's two reasons that typically happen. The misguided "good" one
> which is to think it helps keeping a single/more maintainable kernel
> image by stuffing the horrible details of nvram, rtc, etc.. access,
> poweron/off GPIOs, clock control, etc... in there. The "bad" one which
> is to stash code you don't want to show the source code for (codec
> control, etc...).
>
> This is bad for so many reasons that I don't think I need to even start
> listing them :-) So that's something that will have to be strongly kept
> in check and fought I suspect.

With a stout 2x4 if needed.  I'm going to try very hard to dissuade
this.  Yet another reason why I only what one method for passing the
device tree into the kernel.

> To some extent, in fact, doing that sort of stuff in OF or even in RTAS
> like we do on power is even worse than ACPI-like tables. At least with
> those tables, the interpreter is in the operating system, thus can run
> with interrupts on, scheduling on, etc... With RTAS, or client interface
> calls, you'll end up with potentially huge slumps of CPU time "lost"
> into the bowels of the firmware.

Unfortunately, on the newer ARM SoCs, binary blobs are all over the
place anyway.  :-(

g.
