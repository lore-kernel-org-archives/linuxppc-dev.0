Message-ID: <3CED3CB2.1080803@embeddededge.com>
Date: Thu, 23 May 2002 15:02:10 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Chris Thomson <cmt@bivio.net>
Cc: acurtis@onz.com, "'Paul Mackerras'" <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: eieio rule-of-thumb?
References: <000001c20281$a98be6b0$9502a8c0@cthomson59>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Thomson wrote:

> Eieio instructions are needed for CPUs based on the 745x core.
> These are the 7445, 7450, 7451 and 7455.

The eieio is needed on many of the processors, I just got lucky
on some of them :-)

> Earlier PPC implementations never reordered guarded, or even
> uncached, accesses.  Motorola made a big deal about this in its
> embedded sales.  All you had to do was set the WIMG bits right.

The 74xx is a little confusing, but I don't think it really changed
any semantics.  Loads from uncached and guarded spaces are still
performed in order.  Writes to such spaces are not gathered and are
performed in order.  I think there was some fine tuning of pipelines
that may cause writes to hang around in a buffer longer than they
did on previous processors (and there is this funny description of
a cache line load if all of them would be executed).  The only
confusing part is how the cache inhibit or guarded attribute controls
this behavior.  The eieio is still necessary to ensure a load doesn't
cross a pending store.

The eieio further performs a broadcast bus operation which can be
used by external bridges to prevent them from performing a store
gathering (write combining as Ben said :-) if necessary.

I know there is something a little different with the 74xx, because
when I received one of the first 7450s for my Sandpoint the PCI I/O
didn't work exactly correct.  A couple of minor bug fixes suitable to
all processors cured it.

> Evidently Motorola decided that getting the extra performance
> of reordering was needed to keep the Apple account.

You could probably say that of Altivec, but I don't see any difference
with the reordering behavior of the processors.  Anything we see is likely
to be an effect of significantly improving the performance of the normal
superscalar mode of operation.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
