Subject: RE: Kernel Oops when receiving a lot of UDP packets while booting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 7 Jan 2002 15:16:55 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459415@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Peter Desnoyers" <pdesnoyers@chinook.com>
Cc: "LEROY Christophe" <christophe.leroy@c-s.fr>,
	"linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
> Sent: 7. janúar 2002 15:02
> To: Kári Davíðsson
> Cc: LEROY Christophe; linuxppc
> Subject: Re: Kernel Oops when receiving a lot of UDP packets while
> booting
>
>
> > I have verified that I am getting packets over the ethernet
> > before the scc_enet_open() is called, I somehow suspect that
> > this might be causing my random crashes.
>
> You just kludge it by looking at your 'opened' flag and dropping the
> packet in scc_enet_rx if it's false.  If it stops the

Yes I will try that too.

> crashes, you'll be
> OK until you find a version of the driver that doesn't have this
> problem.
>
> The version of the driver I use does all the hardware
> initialization in
> scc_enet_init, and then all that scc_enet_open does is call
> netif_start_queue.

My enet.c does excactly this. And it is deffinitly not doing the right
thing,
try e.g. to flood ping the board while it is booting you will see all
kinds
of wonderful strange behaviour.

Thanks,

K.D.

>
> --
> .....................................................................
>  Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
>  Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
>  100 Hayden Ave, Lexington MA 02421
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
