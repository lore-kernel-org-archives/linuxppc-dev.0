Message-Id: <200008302045.PAA01483@jen.americas.sgi.com>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support) 
In-Reply-To: Message from "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
   of "Wed, 30 Aug 2000 13:49:49 PDT." <Pine.LNX.3.96.1000830133511.10035C-100000@deepspace.mklinux.org>
Date: Wed, 30 Aug 2000 15:45:07 -0500
From: Steve Lord <lord@sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> In my mind, this really screams the need for a pure vnode API in addition
> to keeping the current API for more traditional filesystems.  You could
> then keep track of these complex keys with either a table or hashing
> method into slots/buckets with 32 bit identifiers, then provide these to
> the vnode layer.  Sounds much easier than trying to make this look like a
> more traditional fs.
>
> Maybe someone could create a filesystem of type vnodefs that simply
> provides, through the current VFS, a pure vnode API that could be used by
> sub-filesystems (which would then absolutely be required to definitively
> probe for fs type automatically...).  Thoughts?
>

It is not that clean at the moment, but we already have a vnode based system
hiding inside XFS, the linux inode has a vnode in the fs specific portion,
the linux inode ops call the VOPs. We still have as a work item to go back and
clean up this layer - it knows too much about XFS right now.

Not really sure if it maps onto what you are suggesting, but it is out there.

Steve


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
