Date: Wed, 7 Apr 1999 11:52:04 -0700 (PDT)
Message-Id: <199904071852.LAA06663@saul1.u.washington.edu>
From: a sun <asun@saul1.u.washington.edu>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990407122435.017707@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Wed, 7 Apr 1999 12:24:35 +0200)
Subject: Re: Resurrecting mkLinux
References: <19990407122435.017707@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Just a question: Where should I place the kernel ? Current BootX copies
   the kernel pages at 0 (physical). Should I do the same with a hole in the
   kernel, should I do the same without a hole (overriding video memory: the
   screen will display garbage during boot), or should I put the kernel in
   the first large enough physically contiguous piece of memory I find and
   let it relocate itself ?

hmm. i think we're going to have to know about relocations anyway and
where the start of the kernel really is. so, i would go for the last
option. the first option would essentially duplicate some of the code
that's in head.S already. we still need the kernel start address
though. assuming that there are enough registers lying around, we
could always do a -ffixed-# and store it there to make things
easier. the apus code would benefit from that as well. if not, we can
do the apus thing and choose a memory location.

so, how about just sticking the kernel somewhere contiguous and
passing in the start of the kernel as part of the boot info struct?
that way, the decision on how to handle things can be left to head.S.

back to the question of registers, how do people feel about allocating
a fixed register in the kernel for the nubus powermacs and apus
machines to store the phystovirt mapping? having things in a register
would simplify things a bit.
  

-a
although, the second option would be humourous.




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
