Date: Wed, 13 Jan 1999 10:40:26 +0100
From: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to NuBus PowerMacs
Message-ID: <19990113104026.C1056@dirkpitt.solsoft.fr>
References: <19990112162631.B29622@dirkpitt.solsoft.fr> <19990112202948.028828@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990112202948.028828@mail.mipsys.com>; from Benjamin Herrenschmidt on Tue, Jan 12, 1999 at 08:29:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Benjamin Herrenschmidt <bh40@calva.net>:

> >-we have the source of the Mach MicroKernel, hence we have enough
> > to rewrite the specification to rewrite drivers for LinuxPPC.
> > Some components and drivers may directly come from Linux Mac68k.
> 
> We have also a lot of potentially useful things in the mac68k and APUS ports.
> 
> >Note that I don't have a NuBus PowerMac. Only a 6200 (and my
> >PowerCenter Pro, already supported).
> 
> ;-)

I'm investigating the possibilities to support 5200/6200 (and its
little brother 5300/6300) just because this machine is:

a) not supported by either MkLinux or LinuxPPC
b) I have one (in fact my fiancee has it).

There are several custom chips inside (like on any other Mac).
First the big problem is that 6200 is a PowerPC inside a 68040
machine. It uses a "CAPELLA" custom chip as a bus translation
unit. This may be a problem since I don't think it is used in any
supported PowerMac.

RAM: 2 simm slot on a 68040 data bus.

Video: It is a "Valkyrie" Chip using a DRAM frame buffer. If I
remember, Valkyrie is available in several PowerMacs and is
already supported.

Memory Controller: it is a "F108" as in the LC 630 (ses Linux 68k
port) that also handles IDE, SCSI and SCC serial ports. SCSI in
this chip is a NCR 53C96. SCC is like the 8530 SCC (that we find
in several Macs too).

ADB: "CUDA" chip similar to several 68k Mac. Accessed thru the
"PrimeTime II". It is the 68HC05 and also handles PRAM, RTC,
power supply control.

Sound: a "DFAC II" chip.

Other: "PRIMETIME II" chip manages SWIM II, VIA1, VIA2, sound
controller and I/O bus adpater. Manages ADB sounds, CommSlot, PDS.

You can find the technote here:

http://developer.apple.com/techpubs/hardware/hardware2.html

Note that I have no porting experience. :-)


Hub
-- 
> Je souhaiterais essayer Internet Explorer 4.0 sous Linux.
> Il existe 2 versions: une sous HP/UX et une sous Solaris
> Laquelle dois je utiliser?
-+- MJM in Guide du linuxien pervers : "Choisir son environnement" -+-

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
