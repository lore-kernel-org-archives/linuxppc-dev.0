Date: Wed, 30 Aug 2000 20:10:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.LNX.3.96.1000830154528.10035H-100000@deepspace.mklinux.org>
Message-ID: <Pine.GSO.4.10.10008301919580.28976-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, David A. Gatwood wrote:

> But it's not a race that the VFS should care about, if the filesystem does
> its job properly.  The first one should take an exclusive lock on the
> inode of the directory and its old and new parents (simultaneously or in
> an ordered fashion so as to prevent deadlock), since it's writing to them.
> When a second thread tries to move something higher in the tree, it must
> make sure it is not moving a parent into one of its descendants.  Assuming
> a hierarchial locking scheme, it will be unable to obtain the appropriate
> locks to verify this, so it will sit there until the previous operation
> completes.

Eww... So that check has to read all directories on the path from target
to the root? You are kidding. That, BTW, is one more place when having a
consistent view of namespace is a big win.

> Once the first move operation complete and release its exclusive lock, the
> second operation will get its shared lock on the (now grandparent) inode
> and see that it is about to do an illegal link loop and fail.  This should
> all occur in the filesystem, transparent to the VFS, which should simply
> be told that the directory to be moved no longer exists in that location
> or that it is illegal to move a parent into its child.

Several problems with that:
	* I don't think that a lot of fs writers are smarter than Kirk. He
missed that one.
	* Duplicating the generic code is evil. It _will_ be screwed, one
way or another. Heck, s/or/and/, actually ;-/
	* More complex code in filesystems.

4.4BSD is, as much as I love that kernel, badly screwed in VFS-related
parts (which, incidentially, was the reason why I'm dealing with Linux and
not *BSD, BSD bigot as I am).

	I'm yet to see clear benefits of vnode API as in 4.4 over the
vnodes-under-dcache as in Linux. Notice that filesystems do not care much
- in the directory part they are simply relieved from doing tons of
braindead checks that are duplicated all over the place in 4.4. If they
want to do extra checks - more power to them. Most of them doesn't,
though.

> As far as the VFS is concerned, a filesystem operation should look like an
> atomic operation that either succeeds or fails.  It shouldn't care about
> the address hierarchy at all.  Concurrency should be protected in the
> filesystem, because that's the only place that really understands when
> locks need to be used.
>
> The VFS layer shouldn't have to check if an operation is legal before it
> executes, because even if it were legal, that legality might change
> between the check and the operation unless you lock the whole filesystem
> in-between -- horrible for concurrency.  You only want to lock things
> during the inode modifications, which could be much less than the time
> needed for the entire operation.

Not really. First of all, we have enough state to not care about the
legality changes (in the cases we do check in VFS, that is). Internal data
structures are entirely on the responsibility of filesystems, as are
additional checks, etc. As for locking the things only when inode
changes... Fine, indeed, but that's _not_ the vnode model - check flags
for namei(9), especially LOCK_PARENT. The bottom line: there are things
that can be easily done in generic layer transparently for filesystems.
It turns out that maintaining the consistent namespace view is not only
possible, but quite simple. It frees filesystem from a lot of cruft that
is very easy to get wrong and it makes life actually much easier. There's
a lot of subtle crap that simply doesn't happen to fs on Linux (2.2/2.4)
and fixing it in every fs is _pain_.

> And besides... in some filesystems, weird loops may be okay.  ;-)  No, I

Detached ones? ;-)

Oh, well... Wait until I'll be done with documentation, will you? Yes,
large piece on translation from/to BSD terms will be there. And yes,
dcache+vnode design makes sense and is not more restrictive than pure
vnode one - it actually addresses some of the problems of the latter.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
