Date: Wed, 30 Aug 2000 16:11:13 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Alexander Viro <viro@math.psu.edu>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.GSO.4.10.10008301811540.28976-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1000830154528.10035H-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, Alexander Viro wrote:

> BTW, the race in question looks so: get two long branches and do
> simultaneous rename() of the middle of first branch to the top of the
> second and symmetric one. Notice that each of them is OK, but together
> they would create a loop, detached from fs. Completely independent from
> the filesystem type. And completely fscked up in *BSD. Yes, chews
> filesystems.

But it's not a race that the VFS should care about, if the filesystem does
its job properly.  The first one should take an exclusive lock on the
inode of the directory and its old and new parents (simultaneously or in
an ordered fashion so as to prevent deadlock), since it's writing to them.
When a second thread tries to move something higher in the tree, it must
make sure it is not moving a parent into one of its descendants.  Assuming
a hierarchial locking scheme, it will be unable to obtain the appropriate
locks to verify this, so it will sit there until the previous operation
completes.

Once the first move operation complete and release its exclusive lock, the
second operation will get its shared lock on the (now grandparent) inode
and see that it is about to do an illegal link loop and fail.  This should
all occur in the filesystem, transparent to the VFS, which should simply
be told that the directory to be moved no longer exists in that location
or that it is illegal to move a parent into its child.

As far as the VFS is concerned, a filesystem operation should look like an
atomic operation that either succeeds or fails.  It shouldn't care about
the address hierarchy at all.  Concurrency should be protected in the
filesystem, because that's the only place that really understands when
locks need to be used.

The VFS layer shouldn't have to check if an operation is legal before it
executes, because even if it were legal, that legality might change
between the check and the operation unless you lock the whole filesystem
in-between -- horrible for concurrency.  You only want to lock things
during the inode modifications, which could be much less than the time
needed for the entire operation.

And besides... in some filesystems, weird loops may be okay.  ;-)  No, I
can't contrive an example, but you can bet somebody's tried....  :-)


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
