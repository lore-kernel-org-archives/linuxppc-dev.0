Date: Tue, 16 Feb 1999 12:24:51 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs
In-Reply-To: <199902160002.LAA11648@tango.anu.edu.au>
Message-ID: <Pine.HPP.3.96.990216112223.1977A-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Feb 1999, Paul Mackerras wrote:

> > 	As Gabriel correctly explained, a "sync" instruction may be
> > necessary before interrupts are enabled if some off-chip operation, like
> 
> Sync and isync turn out to be needed on some revs of some chips
> (particularly the 601) around rfi and mtmsr instructions.

Strange, I thought at least that rfi included a full context
synchronization for obvious reasons, so at least the isync should be
superfluous (for the sync it's different). 

Is there any documentation of these weird bus somewhere ?

I never saw anything like this (and the appendix and errata list for
the 601 from Motorola turns out to only contain the appendices).

Also could we think of implementing config options for people with buggy
processors, especially since the 601 is so weird in many respects
(CONFIG_PPC_NOT601 set to Y would remove a significant amount of
conditional code). I don't want my kernel spread with isync and sync while
I have perfectly valid processors (especially sync should be used
sparingly). 

> (In fact the 601 seems to have another weird bug - in the hash_page
> routine in head.S, the location of the rfi instruction w.r.t. cache
> lines appears to be critical on the 601; if it's wrong, you get a
> machine check on the rfi instruction.  At one stage I found that with
> 2, 3, 6, or 7 nops added, it would work; with 0, 1, 4 or 5 nops added
> it wouldn't. :-)

Weird indeed :-)

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
