From: flar@allandria.com
Message-Id: <200008310549.WAA03911@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: dgatwood@deepspace.mklinux.org (David A. Gatwood)
Date: Wed, 30 Aug 2000 22:49:20 -0700 (PDT)
Cc: ak@suse.de (Andi Kleen), lord@sgi.com (Steve Lord),
        matthew@wil.cx (Matthew Wilcox), khalfmann@libra.de (Halfmann Klaus),
        roman@augan.com (Roman Zippel), linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1000830133511.10035C-100000@deepspace.mklinux.org> from "David A. Gatwood" at Aug 30, 2000 01:49:49 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood wrote:
> On Wed, 30 Aug 2000 flar@allandria.com wrote:
> > Yes, that's the main problem with HFS/HFS+. All catalog entries are keyed
> > on a combination of parent directory ID and filename, because this is the
> > data MacOS asks for when a file is opened. These entries have to be sorted
> > inside the tree, and the sort rules are a little messy, since the string
> > compares are supposed to be case-insensitive. If you are opening a file,
> > or doing a lookup() it's very convenient. If you are doing readdir() it's
> > a massive headache. Basically you have to find the first entry with a
> > parent ID that matches the directory being read, and then read every
> > entry in order until you find one with a different parent. Because of
> > the sorting issue, it's not just a problem with shrinking the directory,
> > because growing the directory could cause the same problem. In fact,
> > growing or shrinking ANY directory on the filesystem could theoretically
> > change the entire tree by forcing the tree to add a new layer of index
> > nodes and rebalancing the tree. It gets very messy. There's a reason the
> > HFS filesystem code in the kernel has always had a habit of destroying
> > disks any time it has to do anything too complex.
>
> In my mind, this really screams the need for a pure vnode API in addition
> to keeping the current API for more traditional filesystems.  You could
> then keep track of these complex keys with either a table or hashing
> method into slots/buckets with 32 bit identifiers, then provide these to
> the vnode layer.  Sounds much easier than trying to make this look like a
> more traditional fs.

Actually, one of the main points of HFS+ is that it's more like a traditional
UNIX filesystem than HFS was.

> Maybe someone could create a filesystem of type vnodefs that simply
> provides, through the current VFS, a pure vnode API that could be used by
> sub-filesystems (which would then absolutely be required to definitively
> probe for fs type automatically...).  Thoughts?

Doesn't sound any cleaner, and it certainly sounds less efficient.

> Also, let me see if I understand this... HFS+ basically needs a
> hierarchial lock scheme with three states (shared, exclusive, unlocked) at
> each level, right?  And I'm assuming that the tree balancing is for speed
> reasons, and that an unbalanced tree doesn't rise to the level of
> "corruption", right?

Well, I'll try to explain. The tree doesn't have to be perfectly balanced,
but there are some rules to follow. The first rule is that all keys have
to be sorted at all times, although there can be empty space in the catalog
between two keys for adding in new ones. The other thing is that all leaf
nodes in the tree have to have the same height. This causes some interesting
problems when you fill up the currently allocated space, since you have to
restructure the tree pretty considerably in order to create more possible
entries.

Deleting in many cases is cleaner and simpler than adding. In most
cases, when you delete an entry, you only have to shuffle around a
few entries in order to make the tree consistent. Basically, the disk
space for the tree is divided into nodes, and each node can have as
many entries as can fit, but it can only have a single contiguous block
of free space. When the free space is all allocated in a node, you can
rebalance the tree using existing nodes if the tree has become heavily
unbalanced. However, if there is very little free space in the tree,
you have to basically rebuild the thing from scratch with an extra
layer of indexing which makes the tree deeper and thus slower to
search. When a new filesystem is created, it only has the root of
the tree, which is also the only leaf node. When that fills up, you
create a new root which is an index node and split the single leaf
nodes into multiple leaf nodes, with each having a key in the index
node. This continues as long as you need more room for entries in
the tree. It's hard to summarize, but the documentation from Apple
has some great diagrams.

http://developer.apple.com/technotes/tn/tn1150.html

Most things in HFS+ can be mapped easily into VFS, and readdir() is
the only thing that is giving me any real problems. From what I could
tell, readdir() is somewhat messy for every filesystem anyway. I've
been doing my coding on 2.2.x mostly, but I've looked at the 2.4.x
interfaces. I personally think it looks a lot cleaner than the 2.2.x
for many things, particularly for read/write of files. I will in the
near future try to find all the 2.4 documentation that wasn't finished
the last time I looked and see what I can figure out of the stuff that
wasn't obvious from the code.

I'm not really sure I answered your questions, but I hope this explains
some of the strange situations with HFS+ and HFS (which mostly fits the
above description as well)

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
