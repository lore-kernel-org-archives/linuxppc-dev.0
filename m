Message-ID: <619D608DD3F0D311882C009027732E1A353231@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Matt Porter'" <mporter@mvista.com>,
	Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "'Matt Porter'" <mmporter@home.com>,
	"PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 2.4.6 kernel on MCP750 board
Date: Wed, 25 Jul 2001 09:48:24 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

>
> On Mon, Jul 23, 2001 at 11:03:12AM +1000, Rudolf Ladyzhenskii wrote:
> >
> > Thanks, Matt
> >
> > Your patch did make things a bit better. Now it tries to
> initialize the
> > tulip, but I do not think it is very happy.
> > Kernel tries to send BOOTP requests, but they never reach
> the server.
> > And tulip driver complains about missing EEPROM. Old kernel
> was finding the
> > EEPROM OK. Also, MAC address is changing between two
> kernels somehow. I
> > assume it is due to the detection of an EEPROM.
> >
> > I've included updated start up dump.
>
> Are you running linuxppc_2_4_devel or a kernel.org 2.4.6?
> What rev. of
> mcp750?
>

We are running 2.4.6 kernel from kernel.org.
The latest kernel opn Monta Vista side did not work at all on MCP750 and on
our custom 8260 based board. Kernel woud start, but none of rhe external
interfaces would work (console, Ethernet). Eventually (by flashing LEDs on
our board) I traced it down to the transmit section of console code. It will
sit in the endless loop waiting for Tx buffer go empty. Looks like
interrupts were disabled by some reason.

Anyway, we downloaded latest 2.4.6 from kernel.org This works fine on our
8260 board.
We use MCP750 REV.A board

Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
