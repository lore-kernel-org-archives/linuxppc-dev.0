Date: Thu, 8 Nov 2001 01:22:47 +0000 (GMT)
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: Mark Pilon <mpilon@midrivers.com>
Cc: list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405GP interrupts tip and looking for a little console help
In-Reply-To: <3BE9BD14.FD9D9DA8@midrivers.com>
Message-ID: <Pine.LNX.4.21.0111080103110.2930-100000@lougher.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 7 Nov 2001, Mark Pilon wrote:

>
> Hi,
>
> AND I'd appreciate a little help on getting my console to
> talk w/ me -- I boot, mount a remote target filesystem w/ nfs,
> and get console messages right up to:
>
> NET4: Unix domain sockets 1.0/SMP for Linux
> NET4.0.
> Looking up port of RPC 100003/2 on
> 192.168.200.4
> Looking up port of RPC 100005/1 on
> 192.168.200.4
> VFS: Mounted root (nfs
> filesystem).
> Freeing unused kernel memory: 56k
> init
> echo
> *
> ^^^^^^----- I typed this last line and it echo'd,
> I passed in a command init=/sbin/sash, but don't get its prompt,
>
> I debugged it to the point of seeing the exec of /bin/sash,
> and would appreciate any views as to what I've forgotten here.
>

I had this problem a while ago on a Redwood-4 board using an early
revision of the processor (STB3400 a variant of the 405GC).  Like
you I tried sash and debugged it up to the point of seeing the exec, then
nothing else would happen.

In my case, the exec was going ahead, but because of a processor
hardware bug, the process was being killed before any output was
produced.  Hence the apparent console output problem.

I finally identified that exec'ing and console output was working by
writing a very small init process (< 2K text/data) that did nothing
but print a string by calling the write system call directly in assembler.
This was small enough that it executed without causing the hardware bug.

Upgrading to a later revision of the processor cured the problem.

This may be nothing to do with your problem, but it may be worth a try.

Phillip

-----
Phillip Lougher

Zarlink Semiconductor,
Portskewitt, Wales, UK.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
