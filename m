Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B664267BF0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 00:30:11 +1000 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6KETwFD024453
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Jul 2006 16:29:58 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
Subject: Re: MPC8260 SCC UART hardware flow control
Date: Thu, 20 Jul 2006 16:32:12 +0200
References: <200607191718.00328.laurent.pinchart@tbox.biz>
	<200607201018.13445.mathieu.deschamps@com2gether.net>
In-Reply-To: <200607201018.13445.mathieu.deschamps@com2gether.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607201632.12233.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mathieu,

> > Hi everybody,
> >
> > I was wondering if anyone had implemented hardware flow control support
> > in the cpm_uart driver. If not, I would appreciate pointers regarding how
> > to do so.
> >
> > Best regards,
> >
> > Laurent Pinchart
>
> I had. PQ2 CPM is a dedicated part which handles this aspect for you via
> its microcode. This also means you can't play with it the old way and
> making your own HHS with a CD/DSR :). Back to seriousness, rather this
> means you needn't adding modem signal handling in cpm_uart driver. So don't
> define modem_something that's an ancient reliq from the times, I guess, no
> CPM was put auxillary.
>
> So how to tell CPM to cope with HHS ? Simple, you "just" have to put SCC's
> Dedicated pins the right way which depends on your board type. Remember you
> can't do any HHS with SMC. Refer to Dedicated Pins chapter in the
> litterature [41.4.2]. Also take a look at SCC GSMR register [20.8] and to
> SCC UART mode PSMR register [21-14] to maybe use protocol specificities.

Thanks.

> When you'll have your kernel ready, you would do probably something like :
> 	stty -F $port crtscts $SPEED

I suppose I also have to add support for the CRTSCTS flag in set_termios.

> As Wolfgang said HHS works for DTE-DCE only (roughly but visually you must
> have plugs opposite gender on both ends), trying DTE-DTE HHS dialog is
> bound to failure despite time spend on it.

I'll disable hardware flow control if I need DTE-DTE communication.

Thanks for your help.

Laurent Pinchart
