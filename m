Date: Fri, 31 May 2002 17:27:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CONFIG_PIN_TLB and telnet problems
Message-ID: <20020531072756.GG16537@zax>
References: <20020531071550.GF16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020531071550.GF16537@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 31, 2002 at 05:15:50PM +1000, David Gibson wrote:
>
> Ok, I think I've managed to reproduce the telnet problems with
> CONFIG_PIN_TLB that Tom Rini and others have reported.  I encountered
> problems telnetting to localhost on a 16MB EP405 (PVR 40110145) and on
> a 32MB Walnut (PVR 401100C4).  I was unable to reproduce the problem
> on any of the other 405GP machines I have, each of which as at least
> 64MB of RAM.
>
> Interestingly, if I alter the CONFIG_PIN_TLB code so that it only pins
> one entry (i.e. maps 16MB of RAM instead of 32MB) I can still
> reproduce the problem on the EP405, but not on the Walnut.  It would
> seem the problem only bites if the pinned allocation is as large or
> larger than physical memory.
>
> It's vaguely understandable that with two pinned entries it would
> break on the 16MB machine: creating a mapping for more RAM than exists
> is certainly a bug.  I don't yet know why there is a problem when the
> mapping is exactly as large as RAM though.

Update:  I've now also reproduced the problem on a 64MB EP405PC board,
by using mem=16M or mem=32M

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
