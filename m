Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 09C5CDE5E1
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 05:40:40 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 68963F490A4
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 21:40:39 +0200 (CEST)
Subject: Re: powerpc port for sbc8260-based board problem
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48220428.6020207@freescale.com>
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>
	<20080507182209.GA2710@loki.buserror.net>
	<1210185652.3519.18.camel@p60365-ste> <4821FBA0.9080203@freescale.com>
	<1210188413.3519.36.camel@p60365-ste> <48220428.6020207@freescale.com>
Date: Wed, 07 May 2008 21:40:39 +0200
Message-Id: <1210189239.6362.3.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Mittwoch, den 07.05.2008, 14:34 -0500 schrieb Scott Wood:
> Sergej Stepanov wrote:
> > Am Mittwoch, den 07.05.2008, 13:57 -0500 schrieb Scott Wood:
> >> I'm not sure how it would make a difference -- the BRG should have 
> >> already been set through the set_termios callback, which is called from 
> >> uart_set_options.
> >>
> >> -Scott
> > Yes, i thought it also, but i traced it for us for the uart console.
> > The cpm_uart_set_termios(..) was not called.
> > At which place should it be called?
> > Is it uart_set_options(..)?
> 
> Yes, uart_set_options() calls port->ops->set_termios().
> 
> -Scott

Hm... it looks like the default uart_set_termios from

static const struct tty_operations uart_ops in serial_core.c

and not cpm_uart_set_termios(..)?..

Is not it? but why?...

Ok, i have to look at my code again...
Regards.
