To: "Flavio Pereira" <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on 8260 using ELDK..Help?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Sep 2002 09:37:18 +0200."
             <1E354700654661418593A0D6B5A9D41008943B@mail.azisa.co.za>
Date: Wed, 04 Sep 2002 15:41:19 +0200
Message-Id: <20020904134124.0F2AE11835@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear flavio,

in message <1E354700654661418593A0D6B5A9D41008943B@mail.azisa.co.za> you wrote:
>
> I'm a _newbie_ to Linux and am busy porting Linux to a MPC8260ADS
> board. PPCBoot is working fine and the Linux kernel seems to boot up
> okay up and till the point where it begins to load init, it then
> crashes. The trace is shown below. I've also tried forcing sh and

Did you fix the IMMR mapping in PPCBoot? The  CFG_DEFAULT_IMMR  defi-
nition  will  NOT  work with LInux; see the Linux memory map require-
ments - You _must_ map the IMMR at 0xF0000000 or above.

> bash as the start-up but these also fail with similar errors. I'm
> using the binaries provided by the ELDK development package. Also my
> changes to the base kernel code (2.4.4) are minimal and are limited
> to uart.c (force SCC1 as serial port) and tty_io.c (don't call
> rs_8xx_init). Can anyone please point me in the right direction...?

Are you sure this was done well?

> If the information above is not sufficient please let me know what
> more I could provide. Something tries to restart the system and then
> it crashes on trying to reboot. Someone please tell me what I should
> be looking at?

...
> Freeing unused kernel memory: 52k init

Looks good so far.

> Warning: unable to open an initial console.

Did you run the ELDK_MAKEDEV and ELDK_FIXPERM scripts as documented?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
