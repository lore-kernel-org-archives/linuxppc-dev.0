Message-ID: <3E6630CC.60809@embeddededge.com>
Date: Wed, 05 Mar 2003 12:15:56 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <3E64DB91.4050508@embeddededge.com> <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se> <20030304233558.GA17093@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:


> .... It's known
> to be horribly broken in some cases, but not admited to by Motorola, and
> distinguishing between 8xx's at runtime is not trivial.

Well, to be fair, Motorola will admit to the errata.  I don't understand
their testing process and it is very difficult to uncover the problem.
I was able to get very early silicon many years ago when this was
discovered.  I would tell them the sequence of events that would cause
it, but when tested in newer silicon it wouldn't always be found, but
there was a different sequence that would uncover similar problems.
Certain combinations of TLB exception, cache line status, and instruction
stream would trigger failures.  The worst failure was the dcbz instruction
didn't really cause the proper effect, or affected the wrong cache line.
These took forever to discover.  So, the easiest solution was to just
not use it.  The kernel may still be littered with some workarounds
that aren't necessary once we decided to stop using the instruction.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
