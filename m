Message-Id: <199908092023.WAA00328@piglet.cpu.lu>
Date: Mon, 9 Aug 1999 22:23:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: Paul.Mackerras@cs.anu.edu.au
cc: paulus@cs.anu.edu.au, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199908090513.PAA09905@tango.anu.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   9 Aug, this message from Paul Mackerras echoed through cyberspace:
>> This fact was already catered for with the definition of outb/inb and
>> friends, which get an offset added to the port. Unfortunately, the
>> PowerMac IDE code undoes this and replaces it with a different
>> mechanism, which in essence removes the offset. Grrr..
> 
> Not any more.  I took that stuff out a few weeks ago so that the
> CMD646 on the blue&white G3s could work.

Is that change in vger only? Submitted for 2.2.11?

> Basically the problem is that the IDE driver assumes that you access
> all IDE controllers via I/O ports.

Not a problem in itself, I guess: it's just that on the PPC, I/O ports
are not necessarily below 64k in processor-view..

> When you have a controller that
> has memory-mapped registers, there is a problem.  When you have a
> system where one IDE controller has I/O ports and another has memory-
> mapped registers, you have a bigger problem.  The current approach to
> solving this problem is to map the addresses of the memory-mapped
> registers into pseudo I/O port numbers (by subtracting _IO_BASE).  If
> there is a better way, somebody let me know. :-)

I'd vote for making I/O ports a memory addresss like any other, and
making sure drivers get this address right. See my other post for
details..

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
