Date: Wed, 30 Aug 2000 14:51:33 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Alexander Viro <viro@math.psu.edu>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.GSO.4.10.10008301648450.28976-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1000830142224.10035F-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, Alexander Viro wrote:

> ??? Current API _is_ vnode one with namespace made visible to VFS and some
> race-protection done there, along with generic checks like "thou shalt not
> remove other's file from other's sticky directory even if you have write
> permissions".

I'm looking at it, and it doesn't look very vnode to me.  I see a buttload
of inode-oriented code all through the generic fs layer.  I'm not sure if
it's that way in 2.4, but I'm looking at 2.2.14 right now, and it's not as
simple as it could be, by any means.  You still have to have something
that resembles an inode.  For some filesystems, that makes no sense.

Also, race protection in the VFS layer doesn't make sense either, because
how can the VFS possibly assume anything about the structure to know what
it can and can't allow to happen concurrently?  And the sticky directory
thing... that's the filesystem's responsibility to implement that, not the
VFS layer.

The VFS layer shouldn't even care if the underlying filesystem supports
ownership, much less sticky directories.  It should simply pass
information about the operation and who wants to do it to the filesystem
and the filesystem should decide if that's a legal operation or not.
Anything more depends on an inode-structured filesystem, or at least
faking an inode structure for the VFS layer, which is a waste of system
overhead with little or no obvious benefit.


> WTF is "traditional" filesystem? Inumber-based one? No such thing at the
> VFS level.

Traditional in the unix sense, as in being designed based on inodes, a
superblock, etc. as opposed to, e.g. NFS based on handles, or HFS based
on... I have no idea what....  :-)


> VFS does not rely on inode numbers and it does not pass them around. Even

But it does, at least in 2.2.14.  I'm looking at the code right now.  The
word inode appears 40 times in the dcache.c file alone.  The inode
number is stored in the dentry as dentry->d_inode, and is used for several
checks in the dentry code as to whether it can, e.g., remove a dentry,
etc.  I don't see how you can say it doesn't rely on inodes.  If it
touches anything that even resmbles an inode, it's not pure vnodes,
period.  To make that sort of system work with non-inode-based filesystems
is a hack and will always be a hack.


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
