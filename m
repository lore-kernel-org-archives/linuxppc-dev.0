Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FA583B6.5040409@iti.fi>
Date: Mon, 03 Nov 2003 00:22:46 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_mpc5200 / 5200lite first day conclusions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have spent a long day hacking and got it
running with by brand new lite5200 EVB

Just for others there is little summary of my experiencies

- Macraigor Wiggler/ocd_cmdr does not yet support mpc5200
  so there is no low cost ocd tool ( or least i have not found one )
  The COP tools are not compatoble between processors
  when there seems to be relativelly good compatibility between BDM tools
  based least on experience with MPC8xx and MPC555 series

---> continue searching low cost tool or just wait ...... or hack one
       without motorola specs


- It looks like that it is not so easy any more compile non u-boot
  version of kernel. Make zImage gives one compilation error
  mentioned and does not even work after it.

---> Easiest way is to move to u-boot

- With u-boot Wolfgang Denk give advice to make ram
   loadable version. I just did not find easy instructions
   to make it.

--> Find out to change TEXT_BASE from board/icecube/config.mk
  Notice also that there is in icecube.c CFG_RAMBOOT
  that needs to be defined in icecube.h that it works in RAM
 with these modifications it work in RAM

-- Compile u-boot flashable version. Even it
  is vompiled for 0xff800000 base address it looks a like
  that it needs still CFG_RAMBOOT if it is
  started from dbug with go ff800100

-- Now you can get kernel booting from uboot with
   tftpboot 200000 uImage
   bootm 200000

- Try to meke your own ramdisk image. There is still
  in uboot manual pages just mentioned "old wau" , read
  kernel Documentation/initrd.txt . The way i used
  to do it does not work any more. uboot just saus
  invalid magic number. Try found out what is wrong

-- > Find out that it needs new utility to make u-boot
  compatible header
./u-boot-1.0.0/tools/mkimage -n 'Kates ramdisk'  -A ppc -O linux -T
ramdisk -C gzip -d initrd.gz initrd.image

- Got kernel died with "cant fork init",
-->find out that your old linux kernel utilities, busybox, init
 jne are no longer copmpatible with libraries, make or find new set

Looks a like that it is doable but it needs lot of time and
once again "reverse documentation read" that is that found
first a solution and then you find documentation ......

May be good step by step instructions are needed someones that
won't spend all day long hacking

-- After midnight you are hungry, tired and five cats and dog are asking
food
--> feed them and go to sauna ... ;)


Kate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
