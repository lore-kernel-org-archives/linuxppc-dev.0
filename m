From: Alan Cox <alan@cymru.net>
Message-Id: <199901160109.BAA28416@snowcrash.cymru.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map()
To: dvdoug@tiac.net (Douglas Godfrey)
Date: Sat, 16 Jan 1999 01:09:04 +0000 (GMT)
Cc: alan@cymru.net, jskov@cygnus.co.uk, cort@persephone.cs.nmt.edu,
        linuxppc-dev@lists.linuxppc.org, Jes.Sorensen@cern.ch,
        linux-apus@sunsite.auc.dk, Paul.Mackerras@cs.anu.edu.au
In-Reply-To: <v04003a00b2c59005ee3f@[205.161.35.44]> from "Douglas Godfrey" at Jan 15, 99 08:00:18 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >	wmb() 	Do not re-order writes across this point (CPU or compiler)
> >	mb()	Do not re-order reads or write across this point
> >
> >
> A simple way to force any good C compiler to not save any intermediate values
> or pointers in registers and still allow full compiler optimization is as
> follows:

gcc has a whole set of facilities for this.

> 3) any compiler that generates proper code will recognize that a branch based
>    on a volatile variable prohibits keeping any values in registers at the
>    target label(s) that are branched to.

and also stop other optimisations if not careful. With gcc you can mark
areas of memory (or all memory) as a side effect. That is done anyway for
several things. What is the issue for instruction stuff is write gathering
and store reordering by the processor itself.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
