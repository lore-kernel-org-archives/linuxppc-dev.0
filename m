Message-ID: <3946C981.A1271A3E@embeddededge.com>
Date: Tue, 13 Jun 2000 19:53:37 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: guinan@bluebutton.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX hang (tlbia)
References: <Pine.LNX.4.21.0006131300470.24794-100000@gemini.home.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jamie Guinan wrote:

> ..... Anyway, by simply
> commenting out the parts of their 8xx init stuff which sets up
> the MMU and TLBs,

You need to enter Linux with MMUs disabled.  I think this is true
of all architectures.  The tlbia is needed to invalidate everything
because a few lines later Linux sets up its own virtual environment.

Running with caches enabled is OK, because anything Linux ensures
cache coherency among the operations it performs during boot.  You
can't arbitrarily disable the MMU, because you need some knowledge of
the physical environment you came from so you know what will happen
when the MMU is disabled.

Good job.  Have fun!


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
