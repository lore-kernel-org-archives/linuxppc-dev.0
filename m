From: benh@kernel.crashing.org
To: Paul Mackerras <paulus@samba.org>,
	Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CONFIG_PIN_TLB and telnet problems
Date: Tue, 4 Jun 2002 14:20:46 +0200
Message-Id: <20020604122046.29082@mailhost.mipsys.com>
In-Reply-To: <15612.5934.333737.934644@argo.ozlabs.ibm.com>
References: <15612.5934.333737.934644@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> As I mentioned in the first message, I suspect the problem is with the
>> multiple mapping/access of data in the pinned and remapped areas.  Linux
>> tends to allocate memory from the high end down, so if you
>consistent_alloc()
>> some space on large memory systems, you are just remapping the attributes
>> of a page.  If you do this on memory that is also covered by a large page,
>> sometimes you will get the access through this large page, and others
>through
>> an alternate mapping, which I believe confuses the MMU/cache with different
>> attributes (which I was assured wouldn't cause problems on 4xx).
>
>We have reproduced the problem using a ramdisk root and loopback, with
>the ethernet disabled, so the only I/O device that is active is the
>serial port, which doesn't use DMA.  So it doesn't look like it is
>anything to do with DMA or with consistent_alloc.

To add to these comments, I can reproduce the problem as well on a
unix socket shared either between two processes, or read & written
by a single process.

After doing various tests, the problem appears rarely and randomly
with half the RAM mapped with fixed TLBs, and very reproduceably
with all the RAM mapped this way. So it seems that reducing the
kernel pressure on TLBs, thus allowing userland TLBs to live much
longer, exhibit the problem.

I tried adding a call to _tlbia (not the instruction but our tlbwe
based implementation) in set_context to make sure I only ever have
one userland context loaded in the TLB and this appear to kill the
problem (I'm currently running 2 offending test programs simultaneously
on the box and none failed yet after a few Gb transferred).

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
