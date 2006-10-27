Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD21567C94
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 18:58:12 +1000 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9R8w4KC022123
	for <linuxppc-embedded@ozlabs.org>; Fri, 27 Oct 2006 10:58:04 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Ricardo Scop <scop@digitel.com.br>
Subject: Re: CPM2 SCC/SMC break handling broken
Date: Fri, 27 Oct 2006 11:01:38 +0200
References: <200610261002.44688.laurent.pinchart@tbox.biz>
	<200610261918.37769.scop@digitel.com.br>
In-Reply-To: <200610261918.37769.scop@digitel.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610271101.38911.laurent.pinchart@tbox.biz>
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

Hi Ricardo,

> > Hi everybody,
> >
> > I need to generate a break on a CPM2 SMC serial port (same issue with SCC
> > serial ports).
> >
> > The tcsendbreak() man page states that the function should generate a
> > break between 250ms and 500ms, but testing showed that the break is one
> > character long (10 bits in 8N1 mode).
>
> [snip]
>
> > CPM_CR_STOP_TX is documented to generate a break of BRKCR characters. The
> > BRKCR register is initialized to 1, so only 1 break character is sent,
> > which won't last between 250ms and 500ms.
>
> [snip]
>
> > Could anyone think of a proper solution which would not disturb the other
> > drivers too much ?
>
> Well, one could always set the BRKCR parameter to the maximum number of
> break characters permitted by it's size, since the break condition will
> anyway end as soon as the RESTART TX command is issued as a consequence of
> the tty->driver->break_ctl(tty, 0) call. But I did not test this.

That's a very good idea, but the documentation is a bit misleading here. I 
tested the CPM2 behaviour, and found out that the break will last BRKCR 
characters, even if a RESTART TX command is sent sooner.

The user manual states

"The SMC sends a programmable number of break characters according to BRKCR 
and reverts to idle or sends data if a RESTART TRANSMIT is issued before 
completion."

I suppose they meant that, if a RESTART TX command is issued before completion 
of the break sequence, the SMC will send data at the end of the break 
sequence. This is at least the behaviour I noticed after trying your idea.

Laurent Pinchart
