From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15597.28411.662551.693706@argo.ozlabs.ibm.com>
Date: Fri, 24 May 2002 08:36:43 +1000 (EST)
To: "Chris Thomson" <cmt@bivio.net>
Cc: "'Dan Malek'" <dan@embeddededge.com>, <acurtis@onz.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: eieio rule-of-thumb?
In-Reply-To: <000001c20281$a98be6b0$9502a8c0@cthomson59>
References: <3CED26BB.2080700@embeddededge.com>
	<000001c20281$a98be6b0$9502a8c0@cthomson59>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Thomson writes:

> Eieio instructions are needed for CPUs based on the 745x core.
> These are the 7445, 7450, 7451 and 7455.
>
> Earlier PPC implementations never reordered guarded, or even
> uncached, accesses.  Motorola made a big deal about this in its
> embedded sales.  All you had to do was set the WIMG bits right.

Not true.  I had an actual example on a 604 processor where I had a
loop for outputting characters to a serial port.  The loop did the
usual thing of polling the status register until it said the transmit
buffer was empty, then poke a character into the transmit buffer, and
loop for the next character.  Without an eieio in there, it would drop
characters because the load to poll the status register would go ahead
of the store to the transmit buffer.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
