Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id A9D8167FF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 15:51:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Wed, 10 Aug 2005 13:50:45 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86505D@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: ??: Some version different 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Denk:
  First I many thanks for your quick reply for my every silly question.  =
The freeze "transferring control to linux" question is sloved.
  It is the "r3" register data wrong transfer from ppcboot  to kernel. I =
don't know why. very strange. !!!
  The CONFIG_HD860 cannot be compiled in kernel. I don't know either.  =
There is no error or warring during config and make.
   I add the init code of bdinfo struct in arch/ppc/kernel/m8xx_setup.c =
platform_init() function. I filled the stuct  __as list by "bdi" =
command.
   Then the console can work now.=20
   But there is another question:
   It always print the "ttyS0 at 0x0280 is on SMC1 using BRGSerial =
driver version 5.05c (2001-07-08) with no serial options enabled"
                                    or "Serial driver version 5.05c =
(2001-07-08) with no serial options enabled"
 =20
   Then "Oops: kernel access of bad area, sig: 11" and stopped.
=20
  How is the "with no serial options enabled" ? is it need any config =
with "make menuconfig" ?
 =20


-----????-----
???: wd@denx.de [mailto:wd@denx.de]
????: 2005?8?10? 13:25
???: FCG WANG Baohua
??: linuxppc-embedded@ozlabs.org
??: Re: Some version different=20


In message <A9DE2BAF233E444FA9C5E77A5825A01E86505B@ydmail.sbell.com.cn> =
you wrote:
> >
>  I want to ask some questions about the different version:
>   1. The linuxppc_2_4_devel   and   the linux-2.4.25.tar.bz2 in ELDK
> 3.1.1 package

THe traball is a snapshot from the linuxppc_2_4_devel CVS  tree  (for
ELDK  3.1.1  the  date  of  the  snapshot  is  2005-03-06  or CVS tag
LABEL_2005_03_06_0100).

>   2.  The ppcboot 0.9.2 compiled with mvstia devrock   and    the
> U-Boot 1.1.2 compiled  with ELDK

PPCBoot 0.9.2 and U-Boot 1.1.2 are about 4 years apart. This is  like
comparing Linux kernel versions 2.0 with 2.6 ....

>   Does the kernel freeze at "transferring control to linux" could be
> these different versions?=20

Both versions were perfectly  capable  of  booting  a  working  Linux
kernel. I don't know the MV toolchain, but I guess it's working fine,
too.  So my guess is that it's your port of the Linux kernel which is
broken.

>   1 why I configed the kernel with CONFIG_HD860 in "make menuconfig" =
but
> the code in CONFIG_HD860=20
>      isn't compiled at all ! What's the perhaps reasons? I checked the

Your port of the Linux kernel is broken.  Probably  you  made  errors
when changing the configure scripts and/or Makefiles.

>    2  How to get board info "struct bd_info" in init/main.c ? I want =
to
> use printf of bd_t->bi_mon_fnc->printf() to=20

You cannot do that. It does not work.

>        print some string on console. Does it possible? But the code is
> only in head_8xx.S, How to get the bd* data in=20

The _res pointer can be used for that; see the existing driver sources.

>        main.c ? Some board use get_board_info(). But how can I use it? =


This depends on how your hardware and your port of Linux support such
a feature. I cannot answer such a question.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The POP3 server service depends on the SMTP  server  service,  which
failed to start because of the following error: The operation comple-
ted successfully."                         -- Windows NT Server v3.51
