Date: Fri, 16 Jul 1999 15:12:10 +1000
Message-Id: <199907160512.PAA24235@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: prasadr@duettech.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <378DE082.B1679C71@duettech.com> (message from Rajendra Prasad on
	Thu, 15 Jul 1999 18:52:10 +0530)
Subject: Re: help on lost interrupt
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <378DE082.B1679C71@duettech.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rajendra Prasad <prasadr@duettech.com> wrote:

> I was looking the source code of linux for ppc. In the interrupt
> handling
> there is a concept of lost_interrupt and do_lost_interrupt. I could not
> understand why this is required and how it is managed on linux.

With the interrupt controller on powermacs, if you disable an
interrupt in the interrupt controller, then the device requests an
interrupt, then you enable that interrupt in the interrupt controller,
the interrupt controller doesn't then request an interrupt from the
CPU.  So in that situation we set the corresponding bit in
lost_interrupts, and when interrupts get reenabled, we check if there
are any such interrupts that need to be serviced.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
