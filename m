Date: Tue, 10 Dec 2002 11:46:38 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: 8xx_io/enet.c
In-reply-to: <EADB10BAC266A14A85ECBF8686A73E31938190@kolkrabbi.flaga.is>
To: =?UNKNOWN?Q?K=E1ri_Dav=ED=F0sson?= <kd@medcare.is>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEKMFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hello,
>
> I am hitting the following code (i.e. the printk() is reached) in the interrupt handler for the ethernet on a custom 823e
> board in arch/ppc/8xx_io/enet.c
>
> 	/* Check for receive busy, i.e. packets coming but no place to
> 	 * put them.  This "can't happen" because the receive interrupt
> 	 * is tossing previous frames.
> 	 */
> 	if (int_events & SCCE_ENET_BSY) {
> 		cep->stats.rx_dropped++;
> 		printk("CPM ENET: BSY can't happen.\n");
> 	}
>
> Clearly this can happen, even though the comment sais otherwise.
> This happens for a "high" datarate sunrpc interface operating over TCP/IP.
>
> Is it safe to ignore this "error" or is it a real bug that should be investigated?

hmm, not sure it's safe to ignore this "error", chances are that receive
gets "stuck" since there won't be any more RX interrupts until at least
one RX BD is freed. Try increasing the number of RX BD's(CONFIG_ENET_BIG_BUFFERS,
will increase TX and RX BD's to 32).

You can also try my patch, see
 http://lists.linuxppc.org/linuxppc-embedded/200210/msg00272.html
or
 http://lists.linuxppc.org/linuxppc-embedded/200210/msg00317.html

Version 2 has a small bug(need to move the invalidate_dcache_range).

It's still under verification so there may be problems with it.

   Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
