Message-ID: <3AFB009A.6B1C8F76@mvista.com>
Date: Thu, 10 May 2001 16:56:58 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: frowand@mvista.com, Brian Kuschak <brian.kuschak@skystream.com>,
	Eli Chen <eli@routefree.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105102042500.29518-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel Paubert wrote:

> Why not ? I'd like to find an explanation of a possible failure mode.

Because the 4xx sucks........unlike other PowerPC processors, it
doesn't appear to use any of the reservation address to break or
match a lwarx.

> All PPC systems have always used a simple store for atomic_set. If it does
> not work, there is something seriously wrong, perhaps even a hardware bug.

Yeah, it does sound kind of broken, but then the 4xx isn't any
shining example of something that follows the PowerPC architecture.
Other PowerPCs have a reservation granularity, so _any_ store operation
within this will cause the reservation to be broken.  The 4xx seems
to have no granularity, and further has inverted the logic.  Without
granularity _any_ store operation anywhere should break the reservation,
but in this case no store operation will break it.....very bad.

What can happen is a lwarx to an address, in some other context a
simple store to that address (no reservation broken) then a subsequent
stwcx. to the address will appear successful.  Hmmmm.....several
ways to fix it, I wonder what will work best.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
