From: "Chris Hallinan" <clh@net1plus.com>
To: "Laurent Mohin" <laurent.mohin@acterna.com>,
	<jwalden@digitalatlantic.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: "Standard" Practice for config of SanDisk compact pci memory for 405gpppc
Date: Tue, 24 Dec 2002 12:10:59 -0500
Message-ID: <NEBBKJPFOLJNBMFNKBIIOEHIDDAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <OF5A07A416.9C613AE7-ONC1256C99.002764D9@eng.eni.wago.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just completed a configuration for the Sandisk CompactFlash in the
"PC Card Memory" mode.  Since our hardware doesn't have an IDE
controller, the "easy" way (true IDE mode) was not available to us.
However, the configuration to get the CompactFlash to work in the PC
Card Memory mode was pretty trivial, requiring virtually no code
changes, only correct hardware configuration and proper config
values in our board-specific header file.

Specifically, we wired CE1 to be the chip select, and for the time
being, we have ignored CE2.  We are using the MPC8245's extended ROM
interface in 8-bit mode using RCS2 as chip select, routed to CE1.
This gives access to the 'ide' register file at our base address.
Note you need slightly more complex chip select logic if you intend
to use it in 16-bit mode since the data port and error register
overlap in the memory space in 16-bit mode.  In that case, you must
use CE2 to select between the error register and data port in 16-bit
mode.  Since our application did not need the performace, we opted
for the cheap and easy way out: just use it in 8-bit mode.

This required a very slight modification in the input_data() and
input_swap() data routines, but the changes were trivial.

I'm not at work this week, but if anyone is interested, next week
I'll forward my config from my board-specific header and more
details on the h/w hookup for anyone interested, as well as a patch
to the above mentioned routines.

-Chris Hallinan
DS4.COM, Inc.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Laurent
> Mohin
> Sent: Tuesday, December 24, 2002 2:15 AM
> To: jwalden@digitalatlantic.com
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: "Standard" Practice for config of SanDisk compact pci
> memory for 405gpppc
>
>
>
> Hello Jerry,
>
> I think the easiest way to control a Sandisk compact
> flash card is in true
> IDE mode.
> We developed our own custom board based around a 405GP
> (or 405GPr) chip and
> an intel 82371 Southbridge. The southbridge provides 2
> IDE interfaces on
> which you can attach the Compact flash socket.
> You will then find all you need in U-boot to load the
> kernel and file
> system from the compact flash.
>
> Laurent
>
>
>
>
> "Jerry Walden" <jwalden@digitalatlantic.com> on
> 24/12/2002 02:27:00
>
> Please respond to jwalden@digitalatlantic.com
>
> To:    linuxppc-embedded@lists.linuxppc.org
> cc:
> Subject:    "Standard" Practice for config of SanDisk
> compact pci memory
>        for 405gp ppc
>
>
>
>
> Our hardware guy is tells me that the SanDisk can be placed
> in one of three modes:
>
> 1) PC Card Memory Mode
> 2) PC Card I/O Mode
> 3) True IDE Mode
>
> The device is going on a custom ppc 405GPr board.
>
> He is also asking me how the device will be accessed
>
> 1) on bytes
> 2) on words
> 3) or both
>
> I am not much of a hardware person, so I am not even
> certain if the
> question I am asking makes sense.
>
> The main goal is to use u-boot to bootstrap and
> initialize the board,
> and to load the linux kernel/file system from the compact flash.
>
> Does anyone have a reference design for a ppc based SBC with a
> san-disc like part on it that runs Linux?
>
> If not, is there a "standard" configuration the the compact flash
> is placed on the bus?
>
> Kindest Regards,
>
> Jerry
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> PPCBoot-users mailing list
> PPCBoot-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ppcboot-users
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
