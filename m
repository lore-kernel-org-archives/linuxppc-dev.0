Date: Wed, 30 Aug 2000 17:49:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.LNX.3.96.1000830142224.10035F-100000@deepspace.mklinux.org>
Message-ID: <Pine.GSO.4.10.10008301742190.28976-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, David A. Gatwood wrote:

> Also, race protection in the VFS layer doesn't make sense either, because
> how can the VFS possibly assume anything about the structure to know what
> it can and can't allow to happen concurrently?  And the sticky directory
> thing... that's the filesystem's responsibility to implement that, not the
> VFS layer.

Oh, really? How about rename()/rename() ones? I mean, those that were
_totally_ fucked up in 4.4BSD all over the friggin' place. How about
rename()/rmdir()? (ditto) Why should _that_ be duplicated into every fs,
with its own set of bugs in each of them?

> The VFS layer shouldn't even care if the underlying filesystem supports
> ownership, much less sticky directories.  It should simply pass
> information about the operation and who wants to do it to the filesystem
> and the filesystem should decide if that's a legal operation or not.
> Anything more depends on an inode-structured filesystem, or at least
> faking an inode structure for the VFS layer, which is a waste of system
> overhead with little or no obvious benefit.

Again, BS. You have ->permission() for that.

> > VFS does not rely on inode numbers and it does not pass them around. Even
>
> But it does, at least in 2.2.14.  I'm looking at the code right now.  The
> word inode appears 40 times in the dcache.c file alone.  The inode
> number is stored in the dentry as dentry->d_inode, and is used for several

Number? Look into dcache.h and fs.h. BTW, fs-independent part of struct
inode in Linux _is_ vnode. Normal, sane BSD/SunOS vnode.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
