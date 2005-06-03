Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id EAD4267B1F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 00:53:46 +1000 (EST)
To: wd@denx.de
Message-ID: <OFF1C6B550.9120AF42-ONC1257015.004EFCD3@brime.fr>
From: scarayol@assystembrime.com
Date: Fri, 3 Jun 2005 16:55:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Cc: ctrichet@assystembrime.com, linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_starting_RAM_adress_for_linux_?=
	=?iso-8859-1?q?kernel?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear Wolfgang,

we need to have the start of Ram at 0x0300 0000 because we use the comm=
and
mem=3D40M (for uboot) to force Linux
in the low part of memory and to reserve the high part of memory (218M
exactly ) for ioremap (for our application) but we keep
the same flash mapping (to avoid more problems).
So how can we do that ? The boot seems OK but there is some problems in=

Kernel after uncompressing the kernel image.
Is the only solution is to inverse the mapping with Ram from 0 to 258M =
and
the flash above ?

Finally, will Busybox work with Ram starting at 0x03000000 ?

Thank you really for your help.

Sophie CARAYOL.




                                                                       =
                                                                       =

                    Wolfgang Denk                                      =
                                                                       =

                    <wd@denx.de>         Pour :  scarayol@assystembrime=
.com                                                                   =

                    Envoy=E9 par :         cc :    linuxppc-embedded@oz=
labs.org, ctrichet@assystembrime.com                                   =
 =20
                    wd@denx.de           Objet :      Re: starting RAM =
adress for linux kernel                                                =

                                                                       =
                                                                       =

                                                                       =
                                                                       =

                    03/06/05                                           =
                                                                       =

                    16:14                                              =
                                                                       =

                                                                       =
                                                                       =

                                                                       =
                                                                       =




Dear Sophie,

in message <OFED9D0639.75930571-ONC1257015.0031274C@brime.fr> you wrote=
:
>
> We have a platform similar to MPC885ADS (xith Kernel version 2.4.26)
except
> that :
> - the RAM is at 0x0300 0000 (size 0x10000000)
> - the flash is at 0x0280 0000 (size  0x00200000)
> - IMMR =3D 0x0220 0000

Ummm - just to avoid any misunderstandings:  there  is  no  technical
reason for such a memory map, and no other good reason either as such
a configuration will not be able to run Linux.

> After u-boot on MPC885ADS, we get the following platform information =
:
> - RAM at 0 size 0x0080 0000
> - FLASH at 0xFE00 0000  size 0x00200000
> - IMMR at 0xFF00 0000
>
> This information is different from the documentation of MPC885ADS :
> - FLASH at 0x0280 0000  size 0x00800000
> - IMMR at 0x0220 0000

So what is your problem? The memory map ist just something you define
as it fits your project. The values in the MPC885ADS are  not  really
useful  for  any  practical  purposes,  so  U-Boot  choses  to define
different, more useful values. This is perfectly fine.

> 1) in fads.h of u-boot, it is specified that RAM __must_ start at 0 :=
 it
> isn't true on our board :

This applies for your board, too.

> - can linux work with RAM not beginning at 0 on this board ?

You can make it work, but there is no good reason to  do  this.  Juts
change your memory map to use a more sensible configuration.

> - what modifications should we make in the kernel to accept RAM at
0x03000000 ?

Please forget this idea.

> 2) is brd_info the only structure given to kernel by u-boot ?
> That is to say is it the only way for the kernel to have information
about
> the boad  ?

It also gets passed the kernel commandline and  some  other  data  in
registers.

> 4) are the following values important if  CONFIG_HIGHMEM is not defin=
ed

You don't want to play with these data unless you know  exactly  what
you are doing.

> (they are automatically generated by our Metrowerks PCS tool in
autoconf.h ) ?

Then please ask Metrowerks support who provided such a tool which  is
unknown to me.

> 5) is the base value of IMMR very important (real value in u-boot
different
> from documentation) ?

Yes, it is very important. Your current memory map cannot  work  with
Linux.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Fascinating is a word I use for the unexpected.
           -- Spock, "The Squire of Gothos", stardate 2124.5


=
