Date: Wed, 30 Aug 2000 18:17:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.LNX.3.96.1000830150717.10035G-100000@deepspace.mklinux.org>
Message-ID: <Pine.GSO.4.10.10008301811540.28976-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, David A. Gatwood wrote:

> How about a database filesystem that presents different view to different
> clients.  User A may rename the "file" and it may only affect user A's
> view.  User B could then rename that same file to a different filename.
> It's simply not reasonable to assume global (system-wide) unix semantics
> for a filesystem, even for obvious functions like rename or rmdir if you
> want the fs API to be expandable to future filesystems that might come
> along.

So what? You have different views, you have separate dentry trees. More
power to you... dentry tree represents visible namespace, no matter what
stands behind it.

BTW, the race in question looks so: get two long branches and do
simultaneous rename() of the middle of first branch to the top of the
second and symmetric one. Notice that each of them is OK, but together
they would create a loop, detached from fs. Completely independent from
the filesystem type. And completely fscked up in *BSD. Yes, chews
filesystems.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
