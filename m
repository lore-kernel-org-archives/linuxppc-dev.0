Date: Wed, 30 Aug 2000 10:35:41 +0200
From: "Andi Kleen" <ak@suse.de>
To: flar@allandria.com
Cc: matthew@wil.cx (Matthew Wilcox), khalfmann@libra.de (Halfmann Klaus),
        roman@augan.com (Roman Zippel), linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
Message-ID: <20000830103541.A10787@gruyere.muc.suse.de>
References: <20000829181851.D6395@parcelfarce.linux.theplanet.co.uk> <200008300222.TAA13173@marcus.allandria.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200008300222.TAA13173@marcus.allandria.com>; from flar@allandria.com on Tue, Aug 29, 2000 at 07:22:05PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 29, 2000 at 07:22:05PM -0700, flar@allandria.com wrote:
> Matthew Wilcox wrote:
> > You can lock while you're in a call, but eventually, you fill up the
> > user's buffer and return.  At that point, you have to drop the lock
> > because they might never call you again.  So you have to consider
> > the case of a file being added or removed between calls to getdents.
> > Current HFS doesn't even pretend to try.  It just stores an index (0
> > .. n-1) and you pick up from there.  So sometimes you get files twice,
> > sometimes files don't show up at all.
> >
> > I suspect you need to store the key of the item you just found, and
> > then continue filling in the buffer from there on subsequent calls.
> > The trouble is that there frequently isn't enough space available to
> > do that.  The proposed ext2 btree extensins needed 64 bits of space and
> > there was only 32 bits available.  What size keys does HFS+ have?
>
> Catalog keys in HFS+ can be anywhere from 8 bytes all the way up to
> 518 bytes. I actually do save the key and do a search in the btree
> in my HFS+ module. (It doesn't seem to work however. And yes, I'm
> helping out Klaus with his code as well as working on a kernel
> module with completely separate code.)

You're sharing a problem with JFS then (and reiserfs to a certain
extent).

In theory you could put as much state as you want into a private field
of the file structure of the directory. This just ignores two ugly things:
NFS and telldir. Both basically require you to generate stateless 32bit
cookies that safely walk your directory.

The only good solution I know is a stable namespace that never shrinks unless
the last entry is removed (basically what ext2 directories do). Then you can
just have an offset into that namespace. Namespace could be hash + collision
counter.

[XFS uses some trick of assuming that buffer sizes are big enough for one
of their hash buckets, but it'll surely break in a lot of cases]

Without stable name space probably your only option is to add dummy entries
into the btree holes instead of rebalancing the tree, and removing all holes
when the last entry goes away.

-Andi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
