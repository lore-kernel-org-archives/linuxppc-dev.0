Date: Tue, 16 Feb 1999 11:02:59 +1100
Message-Id: <199902160002.LAA11648@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
In-reply-to: <9902151757.AA75924@marc.watson.ibm.com> (message from David
	Edelsohn on Mon, 15 Feb 1999 12:57:34 -0500)
Subject: Re: bootstrap stuffs
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <9902151757.AA75924@marc.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn <dje@watson.ibm.com> wrote:

> 	"isync" is used to discard instruction pre-fetch and ensure that
> all previous instructions have occurred.  isync is not necessary for your
> situation either.
> 
> 	As Gabriel correctly explained, a "sync" instruction may be
> necessary before interrupts are enabled if some off-chip operation, like

Sync and isync turn out to be needed on some revs of some chips
(particularly the 601) around rfi and mtmsr instructions.

(In fact the 601 seems to have another weird bug - in the hash_page
routine in head.S, the location of the rfi instruction w.r.t. cache
lines appears to be critical on the 601; if it's wrong, you get a
machine check on the rfi instruction.  At one stage I found that with
2, 3, 6, or 7 nops added, it would work; with 0, 1, 4 or 5 nops added
it wouldn't. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
