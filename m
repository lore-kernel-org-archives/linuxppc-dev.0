Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C0CE281.2E0F451C@seranoa.com>
Date: Tue, 04 Dec 2001 09:49:37 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice
References: <3C0BD4F1.DB6591F3@seranoa.com>
	 <3C0BDBB4.68EB3E72@chinook.com> <5.1.0.14.2.20011203165059.01c83e20@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:
>
> Your PPCBoot image is linked at 0x40000000 and your convert defaults are
> converting from 0xfe000000..0xfe020000 (this is where EST puts the boot
> memory unless you've changed the HRCW to ORG it at 0x00000000 -- glossing
> over quite a few details here).  Anyway, there ain't no data in that range,
> which is exactly what the error message is telling you.
>
> The EST convert utility doesn't allow you to relocate the code, only to set
> the lower and upper boundaries of the conversion.  You can use an elf tool
> (objcopy) to re-org the code or change your link mechanism to re-org your
> code.  You can also leave it at 0x40000000 and change your visionICE setup
> to map the ROM into that memory area (hmm, isn't that the secondary
> flash?  Maybe you just need to program it and switch your CS0/CS6 jumper).

Yes that is the start of Flash.  For our final product we want our
bootloader to live in Flash but I'm rethinking that for the EST board.
>From what I've read on the list is sounds like PPCBoot wants to live in
ROM on the sbc8260 right?

Is the above documented anywhere?  I don't feel the need to reinvent the
wheel for this board and I'd rather start off the right way.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
