From: flar@allandria.com
Message-Id: <200008311748.KAA13993@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 31 Aug 2000 10:48:21 -0700 (PDT)
Cc: dgatwood@deepspace.mklinux.org (David A. Gatwood), ak@suse.de (Andi Kleen),
        lord@sgi.com (Steve Lord), matthew@wil.cx (Matthew Wilcox),
        khalfmann@libra.de (Halfmann Klaus), roman@augan.com (Roman Zippel),
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10008310557340.628-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 31, 2000 06:33:26 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alexander Viro wrote:
> Shrinking/growing the same directory is not going to happen while you
> are in ->readdir(). You have ->i_zombie on it, so...

That's a bit of a help. The 2.2 docs rarely mentioned what was locked
when, and finding all the various locks in the code wasn't easy.

> 	Urgh. Could you show me your code? I think that a variation of the
> scheme used for fatfs may work here. Basically, you can keep hash of

You can find some of my code at http://devel.linuxppc.org/pub/users/flar/
which is in the form of patches to a slightly old 2.2 kernel. However,
since the patches hardly touch any existing files, it will likely apply
cleanly to any 2.2 kernel. I have some minor changes that aren't there
yet, but nothing that changes the basic outline or actually makes it
work properly. I didn't look much at fatfs because I didn't think it
would be relevant, but I'll take a look now that I have some idea what
I should look for there. My code is based on a mix of code stolen from
ext2 and hfs and a few ideas I thought of on my own.

> directory entries and do (find; unhash; copy; rehash) whenever you move
> one. inodes would keep references to such entries, ditto for readdir
> having a "cursor" entry. Rebalancing would go under rw-semaphore (writer)
> and all tree lookups/scans under the same semaphore (reader). That way you
> can get rid of the tree search in ->write_inode(), BTW.

I'm currently ignoring locking almost entirely, because my support is
read only, but I did have a few ideas on where I would need locking.
Hopefully my code isn't completely wrong, but I'd be happy to accept
any advice on where I really do need to worry about locking. I still
haven't read the latest documentation that I've been told got put
into 2.4 but I also haven't started porting my code to 2.4 for lack
of time.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
