Date: Thu, 31 Aug 2000 06:33:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: flar@allandria.com
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <200008310549.WAA03911@marcus.allandria.com>
Message-ID: <Pine.GSO.4.10.10008310557340.628-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000 flar@allandria.com wrote:

> > > Yes, that's the main problem with HFS/HFS+. All catalog entries are keyed
> > > on a combination of parent directory ID and filename, because this is the
> > > data MacOS asks for when a file is opened. These entries have to be sorted
> > > inside the tree, and the sort rules are a little messy, since the string
> > > compares are supposed to be case-insensitive. If you are opening a file,
> > > or doing a lookup() it's very convenient. If you are doing readdir() it's
> > > a massive headache. Basically you have to find the first entry with a
> > > parent ID that matches the directory being read, and then read every
> > > entry in order until you find one with a different parent. Because of

OK.

> > > the sorting issue, it's not just a problem with shrinking the directory,
> > > because growing the directory could cause the same problem. In fact,

Shrinking/growing the same directory is not going to happen while you
are in ->readdir(). You have ->i_zombie on it, so...

> > > growing or shrinking ANY directory on the filesystem could theoretically
> > > change the entire tree by forcing the tree to add a new layer of index
> > > nodes and rebalancing the tree. It gets very messy. There's a reason the

	Urgh. Could you show me your code? I think that a variation of the
scheme used for fatfs may work here. Basically, you can keep hash of
directory entries and do (find; unhash; copy; rehash) whenever you move
one. inodes would keep references to such entries, ditto for readdir
having a "cursor" entry. Rebalancing would go under rw-semaphore (writer)
and all tree lookups/scans under the same semaphore (reader). That way you
can get rid of the tree search in ->write_inode(), BTW.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
