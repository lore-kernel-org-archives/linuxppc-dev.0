Date: Mon, 15 Mar 1999 16:02:43 +1100
Message-Id: <199903150502.QAA16359@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: clepple@mitre.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <36E93596.A055D7BB@mitre.org> (message from Charles Lepple on
	Fri, 12 Mar 1999 10:41:10 -0500)
Subject: Re: sync problem in arch/ppc/kernel/misc.S?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <36E93596.A055D7BB@mitre.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Charles Lepple <clepple@mitre.org> wrote:

> Does anyone have any recollection of writing the comment "some chip revs
> have problems here..." in arch/ppc/kernel/misc.S? It's in the
> enable_interrupts subroutine, and on a DY4 603e board, I do seem to have

IIRC, the code there was cut-and-pasted by me from similar code
elsewhere, which had the comment in it already.  I presume Gary Thomas
wrote that comment, since he did all the early work getting Linux
running on PPC.  I wouldn't have thought that you would be having the
same problems on a 603e chip that Gary (presumably) came across on
some 601s.

> problems :-) It doesn't seem to be getting past this sync instruction,
> and I'm a little confused as to why not. Anyone with insights into this?
> (FWIW, the PVR is 0x60400, implying that it's not the 2.5V core chip...)

If you are getting a machine check apparently on a sync instruction,
it just means that an earlier instruction has access a bogus physical
address.  One of the things that sync does is to wait for any
outstanding memory accesses to complete, so if one of them is bogus,
it will get reported at the sync instruction.  Is it a machine check
you're getting or something else?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
