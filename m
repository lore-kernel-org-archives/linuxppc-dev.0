Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: eieio rule-of-thumb?
Date: Wed, 22 May 2002 19:25:56 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEHMDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <15595.13374.704999.529737@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Nope.  Loads can (and sometimes do) go ahead of stores.  Stores can go
>ahead of loads as well in some circumstances, for example if the load
>is non-cacheable and the store hits in the cache.  In principle loads
>can get reordered too.  Reordering can happen in the processor's
>load/store unit and/or in the PCI host bridge.
>
>I assume you are mostly concerned with loads and stores to
>noncacheable addresses (i.e. I/O devices).  Non-cacheable stores don't
>get reordered, and eieio acts as a barrier to make sure that all
>noncacheable accesses before the eieio are done before any of the
>noncacheable accesses after the eieio.

Could you provide an example of when you should insert this instruction into
your code. From you description it is a wonder that "var += 2;" works if I
am accessing dual-port on an 8260.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
