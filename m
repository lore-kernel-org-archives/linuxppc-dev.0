To: Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting linux on MPC custom Board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 22 Jun 2003 13:32:17 EDT."
             <3439AB3A99ECD5409F3A52ACF814744D158D36@norcom2.norcom.net>
Date: Sun, 22 Jun 2003 20:14:49 +0200
Message-Id: <20030622181454.C14E9C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3439AB3A99ECD5409F3A52ACF814744D158D36@norcom2.norcom.net> you wrote:
>
> I have a custom board with a custom bootloader. The board is based on
> MPC855T, with 8MB flash and 32MB RAM.
>
> I have to boot linux on this board. The issue I have is this - I have to use
> the custom bootloader (to be able to boot older app as well). I think I have
> two ways to go -
>
> 1. Custom bootloader enhanced to be able to load Linux. I do not think it is
> faster approach given the time required.

Maybe, maybe not. If you don't need any  nice-to-have  things  it  is
very simple to boot Linux on any bootloader.

> 2. Tell custom bootloader to load another bootloader like PPCBOOT (U-BOOT)
> and then let it load Linux. Now, to go this route, I will have to run
> PPCBOOT from RAM. Reading documentation of PPCBOOT, it says that it runs
> from FLASH and relocates itself to RAM.
> 	How can run PPCBOOT from RAM directly and then tell it to load
> Linux?? Any HELP would be appreciated.

Such  a  question  will  receive  much  better   responses   on   the
u-boot-users mailing list. In short: configure U-Boot to be linked at
a specific RAM address, disable the RAM initialization code and other
parts  that have already been done by your bootloader, load it to the
chosen address in RAM, and start it at offset 0x100.


But there is probably a 3rd option: install U-Boot, and let  it  boot
your "older apps". U-Boot supports more than just Linux.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"In Christianity neither morality nor religion come into contact with
reality at any point."                          - Friedrich Nietzsche

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
