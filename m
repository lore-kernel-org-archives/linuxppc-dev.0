Date: Wed, 30 Aug 2000 15:13:37 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Alexander Viro <viro@math.psu.edu>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.GSO.4.10.10008301742190.28976-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1000830150717.10035G-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, Alexander Viro wrote:

> On Wed, 30 Aug 2000, David A. Gatwood wrote:
>
> > Also, race protection in the VFS layer doesn't make sense either, because
> > how can the VFS possibly assume anything about the structure to know what
> > it can and can't allow to happen concurrently?  And the sticky directory
> > thing... that's the filesystem's responsibility to implement that, not the
> > VFS layer.
>
> Oh, really? How about rename()/rename() ones? I mean, those that were
> _totally_ fucked up in 4.4BSD all over the friggin' place. How about
> rename()/rmdir()? (ditto) Why should _that_ be duplicated into every fs,
> with its own set of bugs in each of them?

How about a database filesystem that presents different view to different
clients.  User A may rename the "file" and it may only affect user A's
view.  User B could then rename that same file to a different filename.
It's simply not reasonable to assume global (system-wide) unix semantics
for a filesystem, even for obvious functions like rename or rmdir if you
want the fs API to be expandable to future filesystems that might come
along.


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
