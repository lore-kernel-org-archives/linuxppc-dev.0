Date: Thu, 31 Aug 2000 15:54:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: flar@allandria.com
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <200008311748.KAA13993@marcus.allandria.com>
Message-ID: <Pine.GSO.4.10.10008311519010.3039-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000 flar@allandria.com wrote:

> Alexander Viro wrote:
> > Shrinking/growing the same directory is not going to happen while you
> > are in ->readdir(). You have ->i_zombie on it, so...
>
> That's a bit of a help. The 2.2 docs rarely mentioned what was locked
> when, and finding all the various locks in the code wasn't easy.

See Documentation/filesystems/Locking. You probably want the sections on
inode_operations and file_operations first. The thing is _not_ a tutorial
on methods - it's a reference on locking rules. IOW, it had been written
so that one could easily keep it in sync with the code and check what any
given method can expect to be locked.

BTW, readdir() prototype looks fishy - we don't really need struct file*
there, but fixing that is a 2.5 matter.

> > 	Urgh. Could you show me your code? I think that a variation of the
> > scheme used for fatfs may work here. Basically, you can keep hash of

> You can find some of my code at http://devel.linuxppc.org/pub/users/flar/
> which is in the form of patches to a slightly old 2.2 kernel. However,
> since the patches hardly touch any existing files, it will likely apply
> cleanly to any 2.2 kernel. I have some minor changes that aren't there
> yet, but nothing that changes the basic outline or actually makes it
> work properly. I didn't look much at fatfs because I didn't think it
> would be relevant, but I'll take a look now that I have some idea what
> I should look for there. My code is based on a mix of code stolen from
> ext2 and hfs and a few ideas I thought of on my own.

Thanks, I'll look at the patch. In fatfs, keep in mind that you probably
don't need fake inumbers - if you have some permanent ID, that is.
Relevant stuff is in fs/fat/inode.c. Comments there are slightly obsolete
- I didn't update them in the last couple of versions before it went into
the tree.

> > directory entries and do (find; unhash; copy; rehash) whenever you move
> > one. inodes would keep references to such entries, ditto for readdir
> > having a "cursor" entry. Rebalancing would go under rw-semaphore (writer)
> > and all tree lookups/scans under the same semaphore (reader). That way you
> > can get rid of the tree search in ->write_inode(), BTW.
>
> I'm currently ignoring locking almost entirely, because my support is
> read only, but I did have a few ideas on where I would need locking.
> Hopefully my code isn't completely wrong, but I'd be happy to accept
> any advice on where I really do need to worry about locking. I still
> haven't read the latest documentation that I've been told got put
> into 2.4 but I also haven't started porting my code to 2.4 for lack
> of time.

Hopefully it will be easier than 2.2 - Ingo did a fine work on regular
files and that killed a lot of complexity. HFS+ doesn't have sparse files,
right? If so - you'll only need a function that
	a) can take a block number less or equal than the last block in
file and will set ->b_blocknr (of the buffer_head passed to you) to the
disk block number.
	b) can add a block to the end of file and return its number the
same way.
Oh, and you'll still need ->truncate() ;-/
	Everything else is done by library helper functions - see
the current fatfs, hfs or hpfs for details (address_space_operations
methods).
	Directories are essentially the same as they used to be in 2.2,
except that handling of rmdir'ed busy directories is handled in VFS, so
you don't have to worry about them - if rmdir() or rename() over directory
return 0, directory is marked dead and you can forget about anything
except the ->lookup() on it - every other method will be stopped.
	Symlinks are _way_ easier - if you provide a ->readpage() for them
you are done - just use page_readlink() and page_follow_link(). If you
have them in-core (as it is in case of fast symlinks on ext2, autofs ones,
etc.) - pass the contents to vfs_readlink() and vfs_follow_link() (page
variant does exactly that after reading the page - it just was so common
that it deserved library functions of its own).
	Special files don't need any treatment at all; you simply call
init_special_inode() when you read or create an inode of such beast (see
examples in ext2_read_inode() and ext2_mknod(); any filesystem that
supports specials will go as example - they all do the same thing).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
