Date: Wed, 18 Apr 2001 13:44:23 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Tony Mantler <nicoya@apia.dhs.org>,
	martin costabel <costabel@wanadoo.fr>
Cc: "michel   d=?ISO-8859-1?B?5A==?=nzer" <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010418124421.7E7702EFE5@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I guess we could use <CNTL>-power as the SysRq modifier - but it starts to
>>become a little unwieldy - because you need to hold down three keys to get
>>the SysRq action (well, you do now as it happens)...
>>
>>so, perhaps, <CNTL>-<Power>-k etc.
>>
>>thoughts?
>
> On my Apple Adjustable keyboard, control and power are about as far away
> from eachother as you can get and still be on the same keyboard. Not
> exactly 2-of-3-key-combo material. I don't have very small hands, but even
> on my AppleDesign, it's a bit of a stretch.

yeah, on mine too - which is why I was originally attracted to just <power>
as the modifier.

> Also, what happens if someone wants to hook up a PC USB keyboard to their
> mac? Obviously not generating an NMI is a given, but no access to SAK is
> avoidable.

Apparently, some Apple keyboards don't have a <power> key either.

Anyway the SysRq key for USB must be handled somewhere else - I'm looking at
the mac_hid/adb/mac_keyb code which is specific to adb-based machines IIUC.

>(Also can't forget non-mac PPCs)

Which must handle it in their hid section... depending on whether they have
serial or USB (or something special).

Ben just mailed me a much better suggestion:

"Pass the SysRq combination in as a kernel argument".

This would allow those with SysRQ keys (e.g. ISO/ANSI kbds) to use it, power
books could have something that actually exists etc. etc.

It would also mean that users could be supported with a "HOW-to" instead of
"look at the code & rebuild the kernel"...

A bit more wide-reaching than just changing a value somewhere - but probably
worth it - since this discussion comes up every few months ;-)

I'll have a (wider) look at what's needed later on...
ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
