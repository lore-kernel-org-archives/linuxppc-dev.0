Date: Mon, 9 Aug 1999 15:13:28 +1000
Message-Id: <199908090513.PAA09905@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: mlan@cpu.lu
CC: hedrick@Astro.Dyer.Vanderbilt.Edu, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
In-reply-to: <199908081954.VAA02923@piglet.cpu.lu> (message from Michel
	Lanners on Sun, 8 Aug 1999 21:54:12 +0200 (CEST))
Subject: Re: Trying a Promise Ultra/66 on powerpc
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199908081954.VAA02923@piglet.cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This fact was already catered for with the definition of outb/inb and
> friends, which get an offset added to the port. Unfortunately, the
> PowerMac IDE code undoes this and replaces it with a different
> mechanism, which in essence removes the offset. Grrr..

Not any more.  I took that stuff out a few weeks ago so that the
CMD646 on the blue&white G3s could work.

Basically the problem is that the IDE driver assumes that you access
all IDE controllers via I/O ports.  When you have a controller that
has memory-mapped registers, there is a problem.  When you have a
system where one IDE controller has I/O ports and another has memory-
mapped registers, you have a bigger problem.  The current approach to
solving this problem is to map the addresses of the memory-mapped
registers into pseudo I/O port numbers (by subtracting _IO_BASE).  If
there is a better way, somebody let me know. :-)

> I've solved the problem by adding the right offset directly to the
> io-port values as found in the kernel's PCI structures. I think this
> needs more serious rework, though. Paul, are you the author of the
> PowerMac IDE stuff? So we can work this out... 

Yep, for my sins. :-) :-)

Also, does anyone know how a quick way to get the best DMA cycle
timing values in a tuneproc?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
