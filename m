Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CA0483C.E89E7716@ftel.co.uk>
Date: Tue, 26 Mar 2002 10:06:52 +0000
From: Yonghao Wang <Y.Wang@ftel.co.uk>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel message missing characters!
References: <20020322152103.044F8109F3@denx.denx.de>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you very much, Wolfgang.  You are right. We need to modify both
arch/ppc/boot/mbx/m8260_tty.c and rch/ppc/8260_io/uart.c to enable linux
support SMC2 as console for MPC8260. Ppcboot1.0.4 support it, but latest
linux kernel hasn't made SMC2 easy to configuration, although the uart.c
seems already has most code there.

Now I am finished my degree project as porting linux to custom MPC8260 board!
Thank you for your help during this period.

Wang Yonghao

Wolfgang Denk wrote:

> In message <3C9B393E.4958C98E@ftel.co.uk> you wrote:
> >
> > ppcboot as boot loader and kernel 2.4.7. The console is set up on serial
> >
> > SMC2. I've changed little bit code on arch/ppc/boot/mbx/m8260_tty.c to
> > enable it supports SMC2. But when I boot kernel,  the console output
>
> Seems you didn't do this right, then.
>
> > seems missing characters like below:
> ...
> > Ttlmmr  2M;uig0Bfrhs al a 0000
> > Lnxvrin247 wn@ihmr.tlc.k gcvrin30 1FiMr1 53:7GT20
> > oe0:378pgs:378
> > oe2:0pgs.
> > Kre omn ie ot/e/f wnsot121..4:epr/p-f-oti=7.61.1:7.6213121..1:5.5..:iuAM
>
> Well known problem, every second character is missing.
>
> > Does anybody can give me some clue how to fix it?
>
> Make sure to enable SMC1 as serial port, too. If the  console  is  on
> SMC2,  _both_ SMC1 and SMC2 must be enabled as a serial ports, or you
> have to adjust the uart driver a bit.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Nobody trips over mountains. It is the small pebble that  causes  you
> to  stumble.  Pass all the pebbles in your path and you will find you
> have crossed the mountain.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
