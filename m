In-Reply-To: <199908090513.PAA09905@tango.anu.edu.au>
Date: Mon, 9 Aug 1999 08:50:29 +0200
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Trying a Promise Ultra/66 on powerpc
Message-Id: <19990809085029.001336@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 9, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>Basically the problem is that the IDE driver assumes that you access
>all IDE controllers via I/O ports.  When you have a controller that
>has memory-mapped registers, there is a problem.  When you have a
>system where one IDE controller has I/O ports and another has memory-
>mapped registers, you have a bigger problem.  The current approach to
>solving this problem is to map the addresses of the memory-mapped
>registers into pseudo I/O port numbers (by subtracting _IO_BASE).  If
>there is a better way, somebody let me know. :-)

Looks like the best way would be to store the port base or pointers to
the in/out functions in the HWIF structure.

>> I've solved the problem by adding the right offset directly to the
>> io-port values as found in the kernel's PCI structures. I think this
>> needs more serious rework, though. Paul, are you the author of the
>> PowerMac IDE stuff? So we can work this out... 
>
>Yep, for my sins. :-) :-)
>
>Also, does anyone know how a quick way to get the best DMA cycle
>timing values in a tuneproc?

I looked for this not so long ago, when fixing the sl82c105.c for a board
we are designing. unfortunately, it looks like the Linux kernel expect
the BIOS to have done all the work of setting the DMA mode. This is
especially nasty for removable drives and for controllers like the
winbond using the same register for DMA and PIO timings.
Also, I heard (I didn't check) that the tuneproc is not appropriate for
this since it may be called with using_dma not set to it's definitive value.
I was thinking about doing this in the dma_proc itself, when DMA is
enabled/disabled.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
