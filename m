Message-ID: <3C35BA5F.B15DC07@chinook.com>
Date: Fri, 04 Jan 2002 09:21:20 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Liu HongXun-a16975 <a16975@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on the pcmcia module for ppc
References: <01139FC052A0D411900B00508B9535FC048B108F@ZCH07EXM04.corp.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Liu HongXun-a16975 wrote:
>
> When I inserted ds.o, the driver tells me that "cs: socket 0 timed out during reset"
> I looked through the source code and the debug info.
> I found that a lot of the same messages as follows:
> GetStatus(0) = 0x190
> ...
> Such info come from m8xx_pcmcia.c/m8xx_get_status. It seems that someone
> is not satisfied with the above return value and " get status " again and again.
> Then it quit.

To look at it a different way - the driver was unhappy with the value of
the first inb() on an address in the card's I/O space.

My first guess (been there myself) is that inb() and outb() aren't
working to your card's I/O space.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
