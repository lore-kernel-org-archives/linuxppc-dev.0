Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D3A@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: "'li'" <slowforce@21cn.com>,
	Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Booting linux on MPC custom Board
Date: Mon, 23 Jun 2003 12:52:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks a lot. I am going to follow your advice and start rolling.

Lokesh

-----Original Message-----
From: li [mailto:slowforce@21cn.com]
Sent: Monday, June 23, 2003 12:45 PM
To: Lokesh Kumar
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting linux on MPC custom Board


Hi Kumar,
1. change the TEXT_BASE definition in the
   board/yourboardname/config.mk to pointer to sdram
   base
2. change the CFG_FLASH_BASE and CFG_MONITOR_BASE
   definition to that address in the
   include/config_yourboardname.h
3. comment the BR0 reset in section in
   cpu/mpc8xx/cpu_init.c
4. comment the sdram init function(initdram), just set
   the ram size manually
now, you can compile the ppcboot, and download the ppcboot.bin to the
address which the TEXT_BASE point to and make it run.
Good Luck!
Li

>
> Hi,
> I have a custom board with a custom bootloader. The board is based on
> MPC855T, with 8MB flash and 32MB RAM.
>
> I have to boot linux on this board. The issue I have is this - I have to
use
> the custom bootloader (to be able to boot older app as well). I think I
have
> two ways to go -
>
> 1. Custom bootloader enhanced to be able to load Linux. I do not think it
is
> faster approach given the time required.
>
> 2. Tell custom bootloader to load another bootloader like PPCBOOT (U-BOOT)
> and then let it load Linux. Now, to go this route, I will have to run
> PPCBOOT from RAM. Reading documentation of PPCBOOT, it says that it runs
> from FLASH and relocates itself to RAM.
> 	How can run PPCBOOT from RAM directly and then tell it to load
> Linux?? Any HELP would be appreciated.
>
>
> Lokesh Kumar
> Wireless Matrix USA Inc.
> 703-262-4032
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
