Subject: RE: Kernel Oops when receiving a lot of UDP packets while booting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 7 Jan 2002 12:30:57 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459414@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Peter Desnoyers" <pdesnoyers@chinook.com>,
	"LEROY Christophe" <christophe.leroy@c-s.fr>
Cc: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have verified that I am getting packets over the ethernet
before the scc_enet_open() is called, I somehow suspect that
this might be causing my random crashes.

I inserted the following in enet.c

static int opened = 0

and in scc_enet_open() I put

opened = 1;

and in scc_enet_interrupt() I put

if(opened == 0)
	printk("ETHO IRQ before open\n");

How do you propose to that the initialization is done to prevent this?

I have tried simply to move

sccp->scc_gmrl |= (SCC_GSMRL_ENR | SCC_GSMRL_ENT);

from scc_enet_init() to scc_enet_open() both before and after the
netif_start_queue()
call. But it only makes thing worse.

Thanks,

K.D.

> -----Original Message-----
> From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
> Sent: 28. desember 2001 16:10
> To: LEROY Christophe
> Cc: linuxppc
> Subject: Re: Kernel Oops when receiving a lot of UDP packets while
> booting
>
>
>
> LEROY Christophe wrote:
> >
> > What is HHL2.0 ?
>
> Montevista hardhat linux 2.0.  A couple of days ago someone had an
> ethernet question about that, and I was confused.
>
> > I'm using the official 2.4.16 kernel from kernel.org with
> the ppc ports
> > patch for 2.4.15.
> > I'm not using FEC but MC68160A (that is enet.c). But that's
> probably the
> > same problem.
> > Any idea how to solve the problem ?
>
> Check to make sure that ethernet packet reception is disabled when you
> leave the init() function, and doesn't get enabled until the _open()
> function is called.  You might have to actually do work to
> disable it if
> the bootloader already enabled things...
>
> First you could use some flags and printks to see whether the crash is
> really due to early packets, as I suspect.
>
> --
> .....................................................................
>  Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
>  Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
>  100 Hayden Ave, Lexington MA 02421
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
