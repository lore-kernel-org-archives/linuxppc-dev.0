Date: Tue, 22 Feb 2000 12:13:16 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch for optimize context switch
In-Reply-To: <20000222115001.027256@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002221206360.4957-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 22 Feb 2000, Benjamin Herrenschmidt wrote:

> BTW. There's an idea that have been idling in my mind for some time:
>
> Do you think there would be any interest into adding code to some drivers
> for invalidating the data cache of buffers before doing DMA-read i/os to
> them ? (For example invalidating the block buffers before or just after
> having started a DMA read in the IDE driver).

I'd rather leave the hardware invalidate the caches. Now most bridges
gather stores from the PCI until they reach one full cache line of data
which they burst with "write-with-kill" transaction on the bus, which
means that the data is invalidated in the cache if necessary but the snoop
does not cause a data cast-out. In the end you would end up doing twice
the work and increase bus traffic, especially on processors designed for
SMP since the cache invalidation (even if done with dcbi which will
not push data) will also cause bus broadcasts.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
