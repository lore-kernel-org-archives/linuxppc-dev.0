From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15595.13374.704999.529737@argo.ozlabs.ibm.com>
Date: Wed, 22 May 2002 16:01:34 +1000 (EST)
To: <acurtis@onz.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: eieio rule-of-thumb?
In-Reply-To: <NCBBIINEHIPFGJPLBEIFMEGJDHAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFMEGJDHAA.acurtis@onz.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis writes:

> I was wondering if anyone had a rule for the use of eieio or sync
> instructions? After reviewing some of the newer code, it appears that eieio
> is used fairly often (at least in some code), sync is hardly ever used. Is a
> consideration for use whether data is being manipulated on different buses?
> (that would be my assumption) I would assume that operations on the same bus
> would occur in the proper sequence.

Nope.  Loads can (and sometimes do) go ahead of stores.  Stores can go
ahead of loads as well in some circumstances, for example if the load
is non-cacheable and the store hits in the cache.  In principle loads
can get reordered too.  Reordering can happen in the processor's
load/store unit and/or in the PCI host bridge.

I assume you are mostly concerned with loads and stores to
noncacheable addresses (i.e. I/O devices).  Non-cacheable stores don't
get reordered, and eieio acts as a barrier to make sure that all
noncacheable accesses before the eieio are done before any of the
noncacheable accesses after the eieio.

If you are concerned with cacheable accesses as well you start needing
to use sync - it orders all accesses.  Unfortunately it is quite an
expensive operation since it synchronizes the execution pipeline as
well.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
