Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Flash Driver 
Date: Tue, 14 Aug 2001 14:15:36 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B506341C@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Wolfgang Denk" <wd@denx.de>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Coool!! Now I have the flash driver registering itself and telling me
all about the number of partitions on my flash etc. etc. I have the
flash device in the /dev directory. Now, how do I use them? I remember
using them before using the dd command.

Thank you,
Navin.

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Monday, August 13, 2001 5:29 PM
To: Navin Boppuri
Cc: Linuxppc-Embedded (E-mail)
Subject: Re: Flash Driver


In message <3A494DE356A49A40B37442E1E0D9F3B5063418@ptah.ad.newisys.com>
you wrote:
>
> Can someone tell me how to set up and use the flash driver in the
2.4.x
> Linux kernel. I see a CFI and non-CFI support for the AMD flash chips.
I

You mean the driver we maintain?

> am using an AMD flash chip on my board. Which one of the drivers do I
> load? How are these initialized?

For AMD chips, configure:

	CONFIG_FLASH=y
	CONFIG_AMD_FLASH=y

Add a "partition" scheme for your board to
"drivers/char/flash_config.c";
see the comment in this file.

There is no more configuration needed (assuming you are booting  from
PPCBoot, which will pass the necessary parameters to the Linux kernel
[physical start address and size of the flash memory]).

> I have not been able to find any documentation on this. Any help is
very
> appreciated.

Just ask :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Q: How do you spell "onomatopoeia"?
A: The way it sounds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
