Date: Wed, 17 Sep 2003 17:22:32 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <3F68769C.1010000@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I am taking a stab at my_console_write() as well. I have something that works well
> > for me, but i am unsure if I have broken KGDB/XMON support.
>
> You better check it.  The reason for all of the complexity in there is to
> support that.  Lots of time was spent making kgdb/xmon work correctly, and
> to break it or toss it away would kinda piss me off.

Yes, so much I already figured :). I am trying to get it right. Care to test KGDB/XMON
when i am done?
>
> > ....In my new my_console_write()
> > I must know the length of the TX buffer in the TXBD.
>
> Why?

I don't want to disable interrupts for every char transmitted. I therefore fill
the TX BD as much as possible and that is why I need to know the length of the TX buffer.

>
> > ...But what is the TX buffer length before serial_console_setup has run(that's
> > when KGB/XMON is active)?
>
> Whatever the boot rom initializes.

OK, then I will assume TX buffer length of 1, until serial_console_setup has run and
initialize it to 4.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
