Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: EST sbc8260 boot debug
Date: Fri, 7 Nov 2003 15:11:29 -0700
Message-ID: <8039970AF146314597457D3B51A68B382E042D@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "li" <slowforce@21cn.com>, <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang is sleeping right now so I'll try to recreate his standard response...

1) ppcboot is a dead project.  It has been replaced by u-boot.  Please switch to u-boot:
      http://sourceforge.net/projects/u-boot/

2) There is a u-boot email list that you can send questions to.  Please use that for u-boot questions.
    http://lists.sourceforge.net/lists/listinfo/u-boot-users

2) Running out of RAM is strongly discouraged.  u-boot (ppcboot) is intended to run out of flash as a boot program.  Running out of RAM is an unsupported option.  While you can run it out of RAM, you will have to understand your hardware and implications of hardware initialization that is performed by default by u-boot (ppcboot).  The fact that you are asking these questions indicates you have not considered the hardware problems.

Please use your bdi2000 to program a standard unmodified sbc8260 build into flash and THEN ask questions on the u-boot list if it doesn't work.

gvb

P.S. IIRC, the standard sbc8260 configuration jumper is set to "boot low" (0000_0100).  The standard sbc8260 u-boot build is set to "boot high" (FFF0_0100).  You will want to change that jumper.


> -----Original Message-----
> From: li [mailto:slowforce@21cn.com]
> Sent: Friday, November 07, 2003 11:49 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: EST sbc8260 boot debug
>
>
>
> Hello all,
> I have an EST sbc8260 board to boot. After connecting the BDI2000
> with the board, and power on, everything seems ok. In the config file
> for sbc8260, BR0 is set to 0xFE000801. Then, i modified ppcboot-1.1.6
> for mpc8260, change the textbase from 0x40000000(flash address) to
> 0x200000(sdram address) and also the FLASH base addr is set
> to 0x200000.
> At last, using "load 0x200000 ppcboot BIN" command, i download the
> ppcboot image to sdram, and set pc to 0x200100 using "ti 0x200100"
> command. when i using "ti" command, i can see that the pc is
> increasing,
> but when i get into the "board_init_r" function, there should be
> something appears in the console, in fact nothing appeared.
> Is there any problem with my procdure?
>
> PS: there is much switchs and JPs on the board, can anyone give an
> proper setting for them under ppcboot environment?
>
> Thanks in advance
> slowforce
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
