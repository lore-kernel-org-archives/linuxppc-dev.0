Message-ID: <3A42057C.6449819F@nexus-tech.net>
Date: Thu, 21 Dec 2000 08:28:28 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: Jerry Van Baren <vanbaren_gerald@si.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation error
References: <4.3.2.20001221073632.00bb81f0@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:
>
> Scrogged memory, bad code.  You are trying to execute a floating point
> instruction and your processor doesn't support floating point (or it is
> disabled).  Memories like to go to 0xFFs and that is a floating point
> instruction.  Most floating point instructions are 0xFE and the 'D'
> field supplies the remaining '1' bit.  I don't see any valid
> instructions for 0xFFFFFFDA (they all have a reserved field of '0's in
> them), but the op-code causes a floating point trap if you don't have
> floating point available/enabled.
>
> I assume memcp/44 is line 44 in memcp.  I would check the parameters to
> the memcp() call to make sure you aren't copying garbage over
> yourself.  If you can look at the assembly code and registers, make
> sure the destination wasn't 0x398c8d84 (next instruction pointer - 4).
>
> How was my guess?  Did I win $1,000,000 :-)?  It would be easier if you
> tell us the processor and more about your system.

Sorry, I guess more detailed info would be helpful. I'm running a 2.2.13
kernel on a TQM823 board. I have seen this error when using dd to write
to flash. But it's not consistent (sometimes dd works, sometimes it
doesn't). Then I wrote a program using the times() function and it
always fails. I went back and tried this with the original kernel and it
works! I recompiled with and without MATH_EMULATION, but essentially get
the same error. I've tried rebuilding the kernel to what I think are
default settings, but still no luck. What other kernel configs are
relevant?

I'll put your name in the drawing for the $1M. :)

Thanks, Kyle.

> At 09:20 PM 12/20/00 -0500, Kyle Harris wrote:
>
> >Hi,
> >
> >I've encountered the following error several times while running various
> >programs. This one comes from a process attempting to call the times()
> >function.
> >
> >Software Emulation memcp/44 NIP: 18424a0 *NIP: 0x398c8d88 code: ffffffda
> >Illegal Instruction
> >
> >Can anyone give me a clue as to why this happens?
> >
> >Thanks, Kyle.
> >
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
