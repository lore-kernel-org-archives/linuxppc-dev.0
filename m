MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16545.27647.651552.393992@cargo.ozlabs.ibm.com>
Date: Wed, 12 May 2004 10:12:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Amit Shah <amitshah@gmx.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
In-Reply-To: <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
References: <c7nb0l$5e3$1@sea.gmane.org>
	<16544.4592.978105.177882@cargo.ozlabs.ibm.com>
	<3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com>
	<16544.16999.648530.393071@cargo.ozlabs.ibm.com>
	<517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> But, read the following sentence.  "Any bus activity caused by other
> cache instructions results directly from performing the operation on
> the MPC750 cache."  A dcbz has to be broadcast, others do not because
> their operations appear just as standard load/store ops.
>
> The only thing we should have to do in software is the icbi, which is
> no big deal to broadcast.

I don't think you are right, but it would be nice if you can prove me
wrong. ;)

Consider this scenario: an application is modifying some instructions
(for example, ld.so modifying a PLT entry).  It modifies the
instructions, and then just before it does its dcbst; sync; icbi;
isync sequence, it gets scheduled on the other CPU.  It goes ahead and
does the dcbst.  However, the relevant cache lines aren't in the the
cache (they are in the E state in the other CPU's cache), so nothing
gets written out to memory.  After doing the sync; icbi; isync it goes
to execute the instructions and gets the old instructions, not the new
ones.

The dcbst won't cause any stores to memory in this scenario.  It will
cause a dcbst address-only broadcast but that won't (according to my
reading of the manual) cause the other CPU to write back its copy of
the relevant cache line, since the dcbst isn't snooped.

The only workaround I can see for this is to completely flush the D
and I caches of both CPUs whenever we schedule a process on a
different CPU from that on which it last ran.  Triple yuck.

> My experience has been that MPC750s work in a SMP environment
> on a 60x bus.  Maybe I was just lucky?  The way I read the manual,
> they should work with a proper memory controller.

I think that the sorts of problems I am talking about wouldn't show up
very often.  Generally I think that these problems would just cause
the system to be a bit flaky rather than stop it from working at all.
If you didn't have L2 caches that would make the problems show up less
frequently, too.

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
