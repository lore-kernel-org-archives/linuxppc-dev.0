Date: Fri, 19 Mar 1999 00:16:14 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Thoughts about DBDMA and cache coherency
Message-Id: <19990319001614.001351@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all !

I'm sure I'm wrong but I would like someone to point me to my error:

It appears that Apple's Darwin drivers use to flushe the cache of the
memory occupied by a DBDMA descriptor bloc before using it. This would
mean that the memory is not cache coherent when seen from the PCI bus,
and when you think about it, it looks logical: Writes issued from the PCI
to memory are coherent since snooped by the CPU and will force it to
reload the cache (I'm thinking about the 750 with backside cache, but
this may apply to other implementations depending on the bridge), but
when a device reads a piece of memory, i don't see the bridge asking the
CPU to flush this cache range before the read completes. I didn't see any
setting in Grackle to force this and in the case of the G3, the cache is
not handled by the bridge anyway but by the CPU itself...

That would mean that we need to flush the range occupied by DBDMA
descriptors, but also any buffers used by DBDMA when outputing via a
DBDMA channel.

Under MacOS, we use an OS function called PrepareMemoryForIO that will
take care of making pages resident, do appropriate cache flushing and
returns physical page tables for ranges of system memory. We can also,
for small buffers, use LockMemoryContiguous which will ... disable
caching for the selected pages.

Either I missed something big, either linux fails to do so and may have
unreliable writes to DBDMA devices all the time (looks like it would
crash a lot more often than it does, I must be wrong somewhere).

Someone has the solution ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
