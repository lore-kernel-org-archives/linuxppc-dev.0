Subject: Re: cache coherence problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Juergen Kienhoefer <juergen@kienhoefer.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3FB972E8.5090701@kienhoefer.com>
References: <3FB972E8.5090701@kienhoefer.com>
Content-Type: text/plain
Message-Id: <1069122238.7168.63.camel@gaston>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 14:02:28 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-11-18 at 12:16, Juergen Kienhoefer wrote:
> Guys,
> Look at the folloging test program. It mmaps memory, puts some
> instructions in it and executes it.
> Sometimes it works, sometimes it crashes with illegal instruction.
> This smells like cache problems.
> Should the kernel clean the instruction cache for these addresses
> in mmap system call?
> Thanks for any thoughts!
> Juergen

It's your duty to ensure cache coherency. Actually, the kernel
will eventually clean the icache for newly mapped in blank pages,
but it will certainly not enforce flush of your writes to memory.

You need to first flush the data cache to memory using dcbf or
dcbst, then sync for this to complete, then invalidate the
instruction cache, sync and isync.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
