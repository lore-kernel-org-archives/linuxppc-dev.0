To: Bastos Fernandez Alexandre <ALEBAS@televes.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK & MPC8272ADS. Machine check 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Jul 2004 11:28:48 +0200."
             <51DB8827D393D411BB69003048003F46FDCE83@TVESNTR>
Date: Fri, 02 Jul 2004 12:10:00 +0200
Message-Id: <20040702101005.8790FC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <51DB8827D393D411BB69003048003F46FDCE83@TVESNTR> you wrote:
>
> I am trying to boot the Linux kernel from ELDK 3.0 on my MPC8272ADS board.
> I have u-boot 1.1.1 in the board running ok. So I had supposed that the ELDK
> would have been also ported to this board. Was I wrong?

As you write it you are wrong. The ELDK is a tool kit. It provides  a
development  enviuronment  to  develop  softare  for  embedded  Linux
systems. The ELDK itself does not get ported to any specific board.

> Well, what i did, was building the kernel and a ramdisk, downloading it to RAM
> and booting with "bootm" command from U-boot. The result was a Machine Check.
> (see at the end of the mail)

You will need a version of  the  Linux  kernel  tree  which  includes
support  for  the MPC8272ADS board. The kernel tree inlucded with the
ELDK does not contain such support. You will probably be able to  use
the "ads8260" configuration to some extend, though.

Also you must make sure that your boot loader (U-Boot in  this  case)
and Linux use the same memory map.

> I've been seeking through ELDK and through uboot 1.1.1 and I have found that
> the configuration for BCSR is not the same for 8260 boards:
>
>  - uboot:  CFG_BCSR 0xF4500000
>  - kernel: BCSR_ADDR 0xF8000000

This will not work.

> Could be this the reason for the Machine Check? Is there any ELDK port to
> MPC8272ADS board, or any other tree I could use?

Yes, this can be the reason.

There are no "ELDK ports" for any board at all (see above). There are
certain boards that are suupported by DENX, and  for  those  we  make
sure everything works fine. The MPC82xxADS is not among boards.

You will have to adjust the memory maps yourself.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Far back in the mists of ancient time, in the great and glorious days
of the former Galactic Empire, life was wild, rich  and  largely  tax
free.         - Douglas Adams, _The Hitchhiker's Guide to the Galaxy_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
