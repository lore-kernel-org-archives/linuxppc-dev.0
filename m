Message-ID: <37B207F0.5F5B197A@stny.rr.com>
Date: Wed, 11 Aug 1999 19:32:00 -0400
From: Patrick Berge <pberge@stny.rr.com>
MIME-Version: 1.0
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org, Justin Vallon <vallon@mindspring.com>,
        Keith Jacob <kjacob@chariot.net.au>
Subject: Re: mace:transmit timeout - resetting
References: <37AFA3A3.370B25CB@stny.rr.com> <199908100606.QAA23344@tango.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Patrick Berge <pberge@stny.rr.com> wrote:
>
> >  I have am receiving "mace:transmit timeout - resetting" sporadically.
>
> But do you see any problems with the network apart from the message?
>
> The reason for the message is that there are some bugs in the mace
> chip which cause it to lock up very occasionally.  When the driver
> detects this condition, it prints this message and tries to reset the
> chip.  If your network keeps working, then it means that the driver
> successfully got the mace chip going again.
>
> > Any ideas about my problem and/or the meaning of the HZ would be
> > helpful.
>
> HZ is the number of timer interrupts per second.
>
> Paul.

Thanks for the info.  For the record I have a PowerPC 7200/120 and was
wondering if any other extended ethernet users have this same problem.  The
network works but is incredibly slow do to the resetting every second.   I
really don't think the network ever was completely hung...  just very very
slow ..like 10,100,1000 times slower than all the other non-mace
machines.   I talked to Apple (they just told me the only known problem is
with certain 7200/90 machines (see
http://til.info.apple.com/techinfo.nsf/artnum/n18944) .   I guess this is
the issue Keith mentioned in a previous post.  I ask them to review there
database and search for any ethernet issues for 7200/120 and they claimed
there are no known ethernet problems.

I guess my question to you, Paul, is what do I need to do to the mace.c
file to turn off the resetting of the chip.  I am just guessing that the
reset condition you looked for does not hang the mace chip in the
7200/120.   If so then removing the reset should fix my problem.    I am
again assuming the the mace chip in my 7200/120 hardware does not hang.
If I remove the resetting and it hangs then well I just have to but a PCI
ethernet card.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
