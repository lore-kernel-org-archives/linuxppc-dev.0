Date: Thu, 31 Aug 2000 22:40:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: flar@allandria.com
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <200008312209.PAA17642@marcus.allandria.com>
Message-ID: <Pine.GSO.4.10.10008311902200.4074-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000 flar@allandria.com wrote:

> Yes, HFS and HFS+ both have a CNID for each file or directory. It just isn't
> entirely straightforward to search the catalog by this value, since the key
> is a combination of parentCNID and name. The CNID is guaranteed to be unique
> across a filesystem and there are a handful that are reserved for system
> files/directories such as the root (2) and the "parent of root" (1).

OK. Are they preserved by rename()?

> > 	Directories are essentially the same as they used to be in 2.2,
> > except that handling of rmdir'ed busy directories is handled in VFS, so
> > you don't have to worry about them - if rmdir() or rename() over directory
> > return 0, directory is marked dead and you can forget about anything
> > except the ->lookup() on it - every other method will be stopped.
>
> What exactly is marked dead? The inode? I'm not really sure where this
> saves in actual code. Any place in particular to compare between 2.2 and 2.4?

You don't have to check that directory is not busy in rmdir()/rename().
Back in 2.2 filesystems either had to do that, or they had to detect
attempts to read/create in/etc. dead directories. Not much of a save,
but...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
