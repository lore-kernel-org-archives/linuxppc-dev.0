Message-ID: <3C2C8CC1.E2A99B19@chinook.com>
Date: Fri, 28 Dec 2001 10:16:17 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Oops when receiving a lot of UDP packets while booting
References: <3C2C84A2.51B8D952@c-s.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You're using HHL2.0?  There's a bug in fec.c where it will pass packets
up the stack too early in initialization.  The tcp stack doesn't take
too kindly to this, as a number of data structures which are assumed to
exist by the code are actually null pointers at this point in time...

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
