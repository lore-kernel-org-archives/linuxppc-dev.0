Date: Mon, 15 Sep 2003 15:30:29 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <3F6591E2.5070205@siemens.com>
To: Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEEOFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,

Hi Steffen.

>
> I have seen a similar problem for the 2.4.20.
>
> When I force a lot of console output via the following command:
>
>    while true; do cd /; ls -R; done
>
> and type-in some letters in parallel, the console
> becomes crazy.

My custom mpc860 also becomes crazy or just locks up when I do this. The
drivers are pretty the same, so this is no surprise.

>
> I have added some instrumentation in order to dump the
> TX Buffer Descriptor Table. I have found that the
> hardware pointer (TBPTR) and the software pointer (tx_cur)
> are not more synchronized together:
> Inside uart.c, there are the following output routines:
[SNIP]
>
>    rs_8xx_put_char()
>    rs_8xx_write()
>    rs_8xx_send_xchar()
>    my_console_write()
>
> I think there must be a synchronization accessing the
> TX BD table. I suggest the patch attached.

Hmm, don't you turn off irq's for a long time with this patch?

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
