To: Kate Alhola <kate@iti.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite first day conclusions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Nov 2003 00:22:46 +0200."
             <3FA583B6.5040409@iti.fi>
Date: Mon, 03 Nov 2003 00:30:48 +0100
Message-Id: <20031102233053.62048C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FA583B6.5040409@iti.fi> you wrote:
>
> - It looks like that it is not so easy any more compile non u-boot
>   version of kernel. Make zImage gives one compilation error
>   mentioned and does not even work after it.

zImage  requires  a  Linux  bootstap  loader;  this  has   not   been
implemented (yet). We use U-Boot so we don't need it.

> ---> Easiest way is to move to u-boot

Right :-)

> - With u-boot Wolfgang Denk give advice to make ram
>    loadable version. I just did not find easy instructions
>    to make it.

We do NOT recommend to use a U-Boot version booting from RAM; you can
do this if you really want and if you know what you're doing; what we
recommend is to use the standard version and install  it  instead  of
the original bootloader.

> -- Compile u-boot flashable version. Even it
>   is vompiled for 0xff800000 base address it looks a like
>   that it needs still CFG_RAMBOOT if it is
>   started from dbug with go ff800100

Building a low-boot configuration requires more than  just  modifying
the flash base address.

> - Try to meke your own ramdisk image. There is still
>   in uboot manual pages just mentioned "old wau" , read
>   kernel Documentation/initrd.txt . The way i used
>   to do it does not work any more. uboot just saus
>   invalid magic number. Try found out what is wrong

Start reading the U-Boot manual at
http://www.denx.de/twiki/bin/view/DULG/Manual

You   can   find   pre-built   ramdisk   images   for   testing    at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ (use the ppc_82xx
version for the MPC5200).

> - Got kernel died with "cant fork init",
> -->find out that your old linux kernel utilities, busybox, init
>  jne are no longer copmpatible with libraries, make or find new set

You must have done something wrong when building the  ramdisk  image.
This works fine for me.

> Looks a like that it is doable but it needs lot of time and
> once again "reverse documentation read" that is that found
> first a solution and then you find documentation ......

Please feel free to contribute to the DULG
(http://www.denx.de/twiki/bin/view/DULG/Manual).

This is a wiki, so everybody can help improving it.

> May be good step by step instructions are needed someones that
> won't spend all day long hacking

Maybe you can point out what is mussing in the DULG, and we add it?

> -- After midnight you are hungry, tired and five cats and dog are asking
> food
> --> feed them and go to sauna ... ;)

I guess I know how that feels (even without cats or dogs).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
On the subject of C program indentation: "In My Egotistical  Opinion,
most  people's  C  programs  should be indented six feet downward and
covered with dirt."                               - Blair P. Houghton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
