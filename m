From: flar@allandria.com
Message-Id: <200009010352.UAA22371@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 31 Aug 2000 20:52:49 -0700 (PDT)
Cc: dgatwood@deepspace.mklinux.org (David A. Gatwood), ak@suse.de (Andi Kleen),
        lord@sgi.com (Steve Lord), matthew@wil.cx (Matthew Wilcox),
        khalfmann@libra.de (Halfmann Klaus), roman@augan.com (Roman Zippel),
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10008311902200.4074-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 31, 2000 10:40:30 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alexander Viro wrote:
> On Thu, 31 Aug 2000 flar@allandria.com wrote:
>
> > Yes, HFS and HFS+ both have a CNID for each file or directory. It just isn't
> > entirely straightforward to search the catalog by this value, since the key
> > is a combination of parentCNID and name. The CNID is guaranteed to be unique
> > across a filesystem and there are a handful that are reserved for system
> > files/directories such as the root (2) and the "parent of root" (1).
>
> OK. Are they preserved by rename()?

There isn't anything preventing it. A rename() is messy enough because of the
headache of moving around entries in the btree and updating all the implicit
usage of the catalog key which depends on the filename. I don't think the
MacOS actually preserves the CNID on a rename, tho. It's something that I
think would be about the same complexity either way. The only thing you
save by keeping the same CNID is changes to the extents overflow tree,
which is usually empty anyway. (My code doesn't do rename() yet...)

> You don't have to check that directory is not busy in rmdir()/rename().
> Back in 2.2 filesystems either had to do that, or they had to detect
> attempts to read/create in/etc. dead directories. Not much of a save,
> but...

Well, I don't think every filesystem did it properly in 2.2, then. I'm
not entirely sure, but I think HFS wasn't quite as careful as it should
have been about such things. As I recall, the HFS code has wandered around
between different maintainers and is a little messy as a result.

I did finally get a recent source tree for 2.4, and I have to say that the
documenation looks a lot better these days.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
