Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C026FB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 21:43:10 +1000 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 3DC29DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 21:43:09 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MMhAR-0001w5-3x
	for linuxppc-dev@ozlabs.org; Fri, 03 Jul 2009 11:42:59 +0000
Received: from p4ff0667a.dip.t-dialin.net ([79.240.102.122])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2009 11:42:59 +0000
Received: from dzu by p4ff0667a.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2009 11:42:59 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: mpc52xx_uart.c - Port Overruns
Date: Fri, 03 Jul 2009 13:42:46 +0200
Message-ID: <m2ws6qm1qh.fsf@ohwell.denx.de>
References: <c788c1220907021823y384b78c1x2bb9e0fc3268c0e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Damien,

> I am writing to ask about some particular behaviour we saw with the MPC5121 PSC
> UART, using the 2.6.24 Freescle BSP kernel, although examining the code of the
> linux-2.6-denx tree (git commit 7cb16ec2590815a67e5fb5c8994ead536613d922), the
> behavior is almost identical except for incrementing an overrrun counter.
>
> In particular, yesterday we observed a port overrun (from the overrun flags
> being set when looking with the BDI) on one of our PSC Ports.   When it was
> observed, we saw that every second byte coming from the serial port was 0x00.
>
> Examining the interrupt routine of the mpc52xx_uart.c:
>
> static inline int
> mpc52xx_uart_int_rx_chars(struct uart_port *port)
> {
> <snip>
>         tty_insert_flip_char(tty, ch, flag);
>         if (status & MPC52xx_PSC_SR_OE) {
>             /*
>              * Overrun is special, since it's
>              * reported immediately, and doesn't
>              * affect the current character
>              */
>             tty_insert_flip_char(tty, 0, TTY_OVERRUN);
>             port->icount.overrun++;
>         }
> <snip>
> }
>
> So, from my deduction, it is inserting a 0x00 for every overrun error that
> occurs, however, the overrun flag is never cleared.  Therefore fro every byte
> that is received, the overrup flag is still set and therefore we're observing
> the 0x00 being inserted for every "real" byte coming into the port
>
> Is there a particular reason why the overrun flag is not cleared? That is,
> parity, framing and breaks are acknowledged with:
>
>             /* Clear error condition */
>             out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
>
> But the overrun isn't cleared.   Is there are particular reason why?  Is
> userspace meant to detect this condition and reset the port?  Was it
> automatically cleared on the 5200 when reading the status, but the 5121 is
> exhibiting strange behavior? 

This is likely only forgotten in the driver.  I remember fixing this in
our 2.4 kernel tree a long time ago[1].

Cheers
  Detlev

[1] http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commitdiff;h=00097a16641865b88568b807c9680b50c74bda84

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
