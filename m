From: Steve Lord <lord@sgi.com>
Message-Id: <200008301206.HAA24978@jen.americas.sgi.com>
To: "Andi Kleen" <ak@suse.de>
cc: flar@allandria.com, matthew@wil.cx (Matthew Wilcox),
        khalfmann@libra.de (Halfmann Klaus), roman@augan.com (Roman Zippel),
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support) 
In-reply-to: Your message of "Wed, 30 Aug 2000 10:35:41 +0200
Date: Wed, 30 Aug 2000 07:06:36 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> In theory you could put as much state as you want into a private field
> of the file structure of the directory. This just ignores two ugly things:
> NFS and telldir. Both basically require you to generate stateless 32bit
> cookies that safely walk your directory.

Can't we at least pass the cookie generation and intepretation down to
the filesystem layer, since at least NFS V3 allows bigger handles.

> The only good solution I know is a stable namespace that never shrinks unless
> the last entry is removed (basically what ext2 directories do). Then you can
> just have an offset into that namespace. Namespace could be hash + collision
> counter.
>
> [XFS uses some trick of assuming that buffer sizes are big enough for one
> of their hash buckets, but it'll surely break in a lot of cases]

Not strictly true - the version 1 format of directories in XFS will have
problems with this - they return a 64 bit hash value, it can survive
with half of it - unless a single hash bucket gets too big. This problem
also shows up if you NFS mount an XFS filesystem from Irix onto Linux as
most existing Irix filesystems use V1 directories.

For this reason version 2 directories were introduced, the directory offset
returned here is actually a real offset - into an address space which is
the leaf blocks of the directory btree. In this case we only get into
problems with directories bigger than 2 Tbytes.... I cannot remember how
holes in the leaf blocks are handled, but it does do some tricks there too.

Steve

> Without stable name space probably your only option is to add dummy entries
> into the btree holes instead of rebalancing the tree, and removing all holes
> when the last entry goes away.
>
> -Andi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
