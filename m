Date: Wed, 30 Aug 2000 13:49:49 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: flar@allandria.com
cc: Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <200008301607.JAA24693@marcus.allandria.com>
Message-ID: <Pine.LNX.3.96.1000830133511.10035C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000 flar@allandria.com wrote:

> Yes, that's the main problem with HFS/HFS+. All catalog entries are keyed
> on a combination of parent directory ID and filename, because this is the
> data MacOS asks for when a file is opened. These entries have to be sorted
> inside the tree, and the sort rules are a little messy, since the string
> compares are supposed to be case-insensitive. If you are opening a file,
> or doing a lookup() it's very convenient. If you are doing readdir() it's
> a massive headache. Basically you have to find the first entry with a
> parent ID that matches the directory being read, and then read every
> entry in order until you find one with a different parent. Because of
> the sorting issue, it's not just a problem with shrinking the directory,
> because growing the directory could cause the same problem. In fact,
> growing or shrinking ANY directory on the filesystem could theoretically
> change the entire tree by forcing the tree to add a new layer of index
> nodes and rebalancing the tree. It gets very messy. There's a reason the
> HFS filesystem code in the kernel has always had a habit of destroying
> disks any time it has to do anything too complex.

In my mind, this really screams the need for a pure vnode API in addition
to keeping the current API for more traditional filesystems.  You could
then keep track of these complex keys with either a table or hashing
method into slots/buckets with 32 bit identifiers, then provide these to
the vnode layer.  Sounds much easier than trying to make this look like a
more traditional fs.

Maybe someone could create a filesystem of type vnodefs that simply
provides, through the current VFS, a pure vnode API that could be used by
sub-filesystems (which would then absolutely be required to definitively
probe for fs type automatically...).  Thoughts?

Also, let me see if I understand this... HFS+ basically needs a
hierarchial lock scheme with three states (shared, exclusive, unlocked) at
each level, right?  And I'm assuming that the tree balancing is for speed
reasons, and that an unbalanced tree doesn't rise to the level of
"corruption", right?


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
