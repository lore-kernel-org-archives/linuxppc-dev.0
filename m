From: flar@allandria.com
Message-Id: <200008312209.PAA17642@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 31 Aug 2000 15:09:09 -0700 (PDT)
Cc: dgatwood@deepspace.mklinux.org (David A. Gatwood), ak@suse.de (Andi Kleen),
        lord@sgi.com (Steve Lord), matthew@wil.cx (Matthew Wilcox),
        khalfmann@libra.de (Halfmann Klaus), roman@augan.com (Roman Zippel),
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10008311519010.3039-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 31, 2000 03:54:33 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alexander Viro wrote:
> See Documentation/filesystems/Locking. You probably want the sections on
> inode_operations and file_operations first. The thing is _not_ a tutorial
> on methods - it's a reference on locking rules. IOW, it had been written
> so that one could easily keep it in sync with the code and check what any
> given method can expect to be locked.
>
> BTW, readdir() prototype looks fishy - we don't really need struct file*
> there, but fixing that is a 2.5 matter.

I'll take a look. Thanks.

> Thanks, I'll look at the patch. In fatfs, keep in mind that you probably
> don't need fake inumbers - if you have some permanent ID, that is.
> Relevant stuff is in fs/fat/inode.c. Comments there are slightly obsolete
> - I didn't update them in the last couple of versions before it went into
> the tree.

Yes, HFS and HFS+ both have a CNID for each file or directory. It just isn't
entirely straightforward to search the catalog by this value, since the key
is a combination of parentCNID and name. The CNID is guaranteed to be unique
across a filesystem and there are a handful that are reserved for system
files/directories such as the root (2) and the "parent of root" (1).

> Hopefully it will be easier than 2.2 - Ingo did a fine work on regular
> files and that killed a lot of complexity. HFS+ doesn't have sparse files,
> right? If so - you'll only need a function that

HFS and HFS+ do not allow sparse files.

> 	a) can take a block number less or equal than the last block in
> file and will set ->b_blocknr (of the buffer_head passed to you) to the
> disk block number.

This is just a table lookup in the file extents record held in the catalog
entry record or a search in the extents overflow tree if the file has
too many non-contiguous blocks to fit in the records held in the catalog.
Each extent contains a start block and a block count, and there is a fixed
amount of space set aside for extents inside the catalog entry. The extents
overflow tree is another btree like the catalog file, but is keyed on
CNID, fork, and file offset.

> 	b) can add a block to the end of file and return its number the
> same way.

This isn't much worse, but in the case of a massively fragmented filesystem,
could involve growing the extents overflow tree.

> Oh, and you'll still need ->truncate() ;-/

I'll keep that in mind.  :)

> 	Everything else is done by library helper functions - see
> the current fatfs, hfs or hpfs for details (address_space_operations
> methods).

I did notice the address space stuff in the short time I looked at
the 2.4 code. It looked like it really cleaned up the helper functions.

> 	Directories are essentially the same as they used to be in 2.2,
> except that handling of rmdir'ed busy directories is handled in VFS, so
> you don't have to worry about them - if rmdir() or rename() over directory
> return 0, directory is marked dead and you can forget about anything
> except the ->lookup() on it - every other method will be stopped.

What exactly is marked dead? The inode? I'm not really sure where this
saves in actual code. Any place in particular to compare between 2.2 and 2.4?

> 	Symlinks are _way_ easier - if you provide a ->readpage() for them
> you are done - just use page_readlink() and page_follow_link(). If you
> have them in-core (as it is in case of fast symlinks on ext2, autofs ones,
> etc.) - pass the contents to vfs_readlink() and vfs_follow_link() (page
> variant does exactly that after reading the page - it just was so common
> that it deserved library functions of its own).
> 	Special files don't need any treatment at all; you simply call
> init_special_inode() when you read or create an inode of such beast (see
> examples in ext2_read_inode() and ext2_mknod(); any filesystem that
> supports specials will go as example - they all do the same thing).

Well, since MacOS 8/9 don't support special files, I'm waiting until I
can get my own copy of MacOS X before I support all the features like
special files and links.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
