Message-ID: <3C2C9957.FB2886D0@chinook.com>
Date: Fri, 28 Dec 2001 11:09:59 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Oops when receiving a lot of UDP packets while booting
References: <3C2C84A2.51B8D952@c-s.fr> <3C2C8CC1.E2A99B19@chinook.com> <3C2C9215.65A76EB@c-s.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


LEROY Christophe wrote:
>
> What is HHL2.0 ?

Montevista hardhat linux 2.0.  A couple of days ago someone had an
ethernet question about that, and I was confused.

> I'm using the official 2.4.16 kernel from kernel.org with the ppc ports
> patch for 2.4.15.
> I'm not using FEC but MC68160A (that is enet.c). But that's probably the
> same problem.
> Any idea how to solve the problem ?

Check to make sure that ethernet packet reception is disabled when you
leave the init() function, and doesn't get enabled until the _open()
function is called.  You might have to actually do work to disable it if
the bootloader already enabled things...

First you could use some flags and printks to see whether the crash is
really due to early packets, as I suspect.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
