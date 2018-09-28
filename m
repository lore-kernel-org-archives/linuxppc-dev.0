From: nbasker@india.tejasnetworks.com
Message-ID: <1057151840.3f02db609eb1d@pop-mail.india.tejasnetworks.com>
Date: Wed, Wed 02 Jul 2003 06:47:20 PM IST, Jul 2003 18:47:20 +0530
To: Paul Ruhland <pruhland@rochester.rr.com>, mgreer@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems in SCC-UART in mpc860
References: <1057070760.3f019ea838280@pop-mail.india.tejasnetworks.com> <200307012248.13130.pruhland@rochester.rr.com>
In-Reply-To: <200307012248.13130.pruhland@rochester.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

The PVR of my mpc860 says 0x00500000.  I tried to
rearrange the BRGs assigned to SMCs and SCCs that I am using from

SMC1 - BRG2 (console)
SCC1 - BRG1 (hdlc)
SCC2 - BRG4 (uart)

to

SMC1 - BRG1 (console)
SCC1 - BRG1 (hdlc)
SCC2 - BRG3 (uart)

This kind of got me further ahead. Now I am able to ping (inconsistently)
via the connection, still my CTS/RTS/CD are disabled. After working for
sometime, modem hangsup and I have to reconnect to get it working again.

I am not able to explain why it was not working in the previous configuration
and why it works (though not completely) with the change. Any hints would be
helpful. Thanks.

Nicholas.

Quoting Paul Ruhland <pruhland@rochester.rr.com>:

>
> You stated you have the SCC UART CD enabled so this may be your initial
> problem.
>
> With CD enabled, SCC UART will not receive unless CD is asserted.
> Typically,
> a modem will not assert CD until it is connected and gets an aswer tone.
> Therefore, you will not be able to communicate with the modem to configure
> it
> and tell it to dial.
>
> Try enabling RTS and CTS but not CD.  This may get you farther along.
>
>
> On Tuesday 01 July 2003 10:46 am, nbasker@india.tejasnetworks.com wrote:
> > Hi:
> >
> > I am trying to use a SCC configured in UART to communicate with a intel
> > pc via modem. The configuration is simple and shown below
> >
> > target --- modem -------phoneline---- modem----i386pc
> >
> > target configuration:
> > 1. mpc860T custom board
> > 2. scc2 configured in uart
> > 3. linux-2-2-14 from montavista
> > 4. patched 8xx_io/uart.c from 2.2.4 kernel from Denks
> > 5. using mgetty/pppd to program modem and start pppd.
> >
> > host configuration:
> > 1. i368pc running 2.2.14-12 redhat kernel
> > 2. using pppd/chat to dialup to target modem.
> >
> > In this setup if use PCSO to enable RTS, CTS and CD along with
> > crtscts option in pppd nothing works. If I disable PCSO and use
> > nocrtscts option in pppd, LCP connection goes through but IPCP
> > exchange at target fails (it never sends ConfigAck packet towards host).
> >
> > I am able to get the setup working using null modem cable enabling
> > RTS/CTS/CD via PCSO register as well as pppd options.
> >
> > Since I am able to get SCC2/UART working with nullmodem, but not
> > with actual modem, should I suspect hardware signal connectivity as
> > a problem source?. I suspected the uart driver and went through
> > all the register settings described in Section 23.21 of 860T user
> > manual and everything seems to be fine.
> >
> > Any hint or help on this issue will be greatly appreciated.
> >
> > Thanks for your time,
> > Nicholas.
> >
> > -------------------------------------------------
> > This mail sent through Tejasnetworks Webclient
> >
> >
>
>
>
>




-------------------------------------------------
This mail sent through Tejasnetworks Webclient


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
