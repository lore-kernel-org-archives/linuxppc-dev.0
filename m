Return-Path: <scop@digitel.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id 25B2E67E4F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 05:15:03 +1000 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM2 SCC/SMC break handling broken
Date: Fri, 27 Oct 2006 16:20:22 -0200
References: <200610261002.44688.laurent.pinchart@tbox.biz>
	<200610261918.37769.scop@digitel.com.br>
	<200610271101.38911.laurent.pinchart@tbox.biz>
In-Reply-To: <200610271101.38911.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Message-Id: <200610271620.23046.scop@digitel.com.br>
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

Hi Laurent,

On Friday 27 October 2006 07:01, Laurent Pinchart wrote:
> Hi Ricardo,
>
> > > Hi everybody,
> > >
> > > I need to generate a break on a CPM2 SMC serial port (same issue wi=
th
> > > SCC serial ports).
> > >
> > > The tcsendbreak() man page states that the function should generate=
 a
> > > break between 250ms and 500ms, but testing showed that the break is=
 one
> > > character long (10 bits in 8N1 mode).
> >
> > [snip]
> >
> > > CPM_CR_STOP_TX is documented to generate a break of BRKCR character=
s.
> > > The BRKCR register is initialized to 1, so only 1 break character i=
s
> > > sent, which won't last between 250ms and 500ms.
> >
> > [snip]
> >
> > > Could anyone think of a proper solution which would not disturb the
> > > other drivers too much ?
> >
> > Well, one could always set the BRKCR parameter to the maximum number =
of
> > break characters permitted by it's size, since the break condition wi=
ll
> > anyway end as soon as the RESTART TX command is issued as a consequen=
ce
> > of the tty->driver->break_ctl(tty, 0) call. But I did not test this.
>
> That's a very good idea, but the documentation is a bit misleading here=
=2E I
> tested the CPM2 behaviour, and found out that the break will last BRKCR
> characters, even if a RESTART TX command is sent sooner.
>
> The user manual states
>
> "The SMC sends a programmable number of break characters according to B=
RKCR
> and reverts to idle or sends data if a RESTART TRANSMIT is issued befor=
e
> completion."
>
> I suppose they meant that, if a RESTART TX command is issued before
> completion of the break sequence, the SMC will send data at the end of =
the
> break sequence. This is at least the behaviour I noticed after trying y=
our
> idea.
Too bad.... :( One more good idea to the junk bin.

Hmm, just a wild shot you can try, while you're at that: what about setti=
ng=20
BRKCR to zero and issuing another STOP TRANSMIT, just before the RESTART=20
TRANSMIT?=20

Another reasonable shot would be to disable and reenable the transmitter =
in an=20
attempt to stop the break sequence; though I don't know what happens to t=
he=20
SMC state machine in this case.

Too wild guesses? Well, maybe someone at Freescale can have a better idea=
=2E :)

Best regards,

Ricardo Scop.
