Message-ID: <3C39B87E.3A2E399B@chinook.com>
Date: Mon, 07 Jan 2002 10:02:22 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: =?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Oops when receiving a lot of UDP packets while booting
References: <EADB10BAC266A14A85ECBF8686A73E31459414@kolkrabbi.flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have verified that I am getting packets over the ethernet
> before the scc_enet_open() is called, I somehow suspect that
> this might be causing my random crashes.

You just kludge it by looking at your 'opened' flag and dropping the
packet in scc_enet_rx if it's false.  If it stops the crashes, you'll be
OK until you find a version of the driver that doesn't have this
problem.

The version of the driver I use does all the hardware initialization in
scc_enet_init, and then all that scc_enet_open does is call
netif_start_queue.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
