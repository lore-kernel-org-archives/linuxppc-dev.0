Return-Path: <scop@digitel.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id 8CD6E67DA9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 09:45:52 +1100 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Vitaly Bordug <vbordug@ru.mvista.com>,
	Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM2 SCC/SMC break handling broken
Date: Mon, 30 Oct 2006 19:52:00 -0200
References: <200610261002.44688.laurent.pinchart@tbox.biz>
	<200610301623.51537.laurent.pinchart@tbox.biz>
	<20061030184002.35611755@vitb.ru.mvista.com>
In-Reply-To: <20061030184002.35611755@vitb.ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200610301952.00031.scop@digitel.com.br>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Laurent,

On Monday 30 October 2006 13:40, Vitaly Bordug wrote:
> On Mon, 30 Oct 2006 16:23:51 +0100
>
> Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:
> > Hi Ricardo,
> >
> > > > > > I need to generate a break on a CPM2 SMC serial port (same is=
sue
> > > > > > with SCC serial ports).
> > > > > >
> > > > > > The tcsendbreak() man page states that the function should
> > > > > > generate a break between 250ms and 500ms, but testing showed =
that
> > > > > > the break is one character long (10 bits in 8N1 mode).
> > > > >
> > > > > [snip]
> > > > >
> > > > > > CPM_CR_STOP_TX is documented to generate a break of BRKCR
> > > > > > characters. The BRKCR register is initialized to 1, so only 1
> > > > > > break character is sent, which won't last between 250ms and
> > > > > > 500ms.
> > > > >
> > > > > [snip]
> > > > >
> > > > > > Could anyone think of a proper solution which would not distu=
rb
> > > > > > the other drivers too much ?
> > > > >
> > > > > Well, one could always set the BRKCR parameter to the maximum
> > > > > number of break characters permitted by it's size, since the br=
eak
> > > > > condition will anyway end as soon as the RESTART TX command is
> > > > > issued as a consequence of the tty->driver->break_ctl(tty, 0) c=
all.
> > > > > But I did not test this.
> > > >
> > > > That's a very good idea, but the documentation is a bit misleadin=
g
> > > > here. I tested the CPM2 behaviour, and found out that the break w=
ill
> > > > last BRKCR characters, even if a RESTART TX command is sent soone=
r.
> > > >
> > > > The user manual states
> > > >
> > > > "The SMC sends a programmable number of break characters accordin=
g to
> > > > BRKCR and reverts to idle or sends data if a RESTART TRANSMIT is
> > > > issued before completion."
> > > >
> > > > I suppose they meant that, if a RESTART TX command is issued befo=
re
> > > > completion of the break sequence, the SMC will send data at the e=
nd
> > > > of the break sequence. This is at least the behaviour I noticed a=
fter
> > > > trying your idea.
> > >
> > > Too bad.... :( One more good idea to the junk bin.
> > >
> > > Hmm, just a wild shot you can try, while you're at that: what about
> > > setting BRKCR to zero and issuing another STOP TRANSMIT, just befor=
e
> > > the RESTART TRANSMIT?
> >
> > Wow, congratulations. I wouldn't have thought about that.
Thanks.

BTW, thank you for trying that out. My fingers are much lazier than my br=
ain.

Cheers,

--=20
Ricardo Scop.
