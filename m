Message-Id: <200008241758.SAA30244@hyperion.valhalla.net>
Date: Thu, 24 Aug 2000 18:58:47 +0100
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>,
        "Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
        "Linux/PPC on APUS" <linux-apus-devel@lists.sourceforge.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Geert,

On Thu, Aug 24, 2000, Geert Uytterhoeven wrote:
> On Mon, 7 Aug 2000, Iain Sandoe wrote:
[...]
>>
>> 1. the look-up tables have been moved to the lower levels.
>
> Their definitions have to be static, else you get duplicate symbols when
> compiling a generic kernel that includes more than one low-level driver.
> Perhaps we better compile the needed tables separately and link them (to each
> low-level modules for a modular kernel, else to dmasound.o)?

OK. I think this (static issue) was a slip up (but I'm in favour of separate
files anyway).  As it stands, if we had all the options compiled in with
static tables the code size would grow again.

>> 2. The conditionalisation on HAS_RECORD has been made a run-time decision
>
> You don't need `MACHINE.can_record', just check the `MACHINE.record' function
> pointer.

OK, this saves a few bytes.

>> This means, AFAICT that it will no longer be necessary to have different
>> versions of dmasound_core.o for different machines (in the same arch).
>
> But you can no longer disable the code for recording for a machine that
> doesn't need it...

Well, this is a choice.  It was done in response to the comment that a
distro might wish to include all machine options.  This could not be done if
dmasound.o needs to be re-compiled.  Perhaps we need a vote :-)

>   - `MACHINE.can_byteswap' is never used, so remove it.

Sorry, this is work in progress - and doesn't have a purpose in the released
patch.

>   - Is it OK to use `AFMT_S16_LE' as startup mode for /dev/dsp? WAV-files can
>     be 8-bit as well, and always have a header so you can't just cat them to
>     /dev/dsp without static in the beginning anyway.

well, I don't know what's best here.  Most (if not all) of the files have
headers and/or chunks so there's no real 'right' way - apart from using a
proper sound playing app.

The idea was that .wav is now the most common format and that this does at
least play without wrecking your speakers if you are daft enough to do cat
>/dev/dsp

>   - What's the purpose of `dmasound.catch_rad'?

Sorry, more work in progress...

> And finally, my patch :-) DISCLAIMER: I don't claim that it works, not even
> that it compiles...

Thanks, I'll be back on this over the weekend (with luck :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
