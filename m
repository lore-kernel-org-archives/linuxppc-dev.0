Date: Wed, 30 Aug 2000 17:05:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: flar@allandria.com, Andi Kleen <ak@suse.de>, Steve Lord <lord@sgi.com>,
        Matthew Wilcox <matthew@wil.cx>, Halfmann Klaus <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
In-Reply-To: <Pine.LNX.3.96.1000830133511.10035C-100000@deepspace.mklinux.org>
Message-ID: <Pine.GSO.4.10.10008301648450.28976-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, David A. Gatwood wrote:

> In my mind, this really screams the need for a pure vnode API in addition
> to keeping the current API for more traditional filesystems.  You could
> then keep track of these complex keys with either a table or hashing
> method into slots/buckets with 32 bit identifiers, then provide these to
> the vnode layer.  Sounds much easier than trying to make this look like a
> more traditional fs.

??? Current API _is_ vnode one with namespace made visible to VFS and some
race-protection done there, along with generic checks like "thou shalt not
remove other's file from other's sticky directory even if you have write
permissions".

WTF is "traditional" filesystem? Inumber-based one? No such thing at the
VFS level.

VFS does not rely on inode numbers and it does not pass them around. Even
in ->lookup(). It passes the request "here's dentry with name foo and
parent bar, see if such file exists and say d_instantiate()". All other
requests are done in terms of such "filled" dentries. Period. VFS doesn't
care for inodes. You can have all inodes on your filesystem with random
->i_ino and/or constant ->i_ino with whatever internal search scheme you
like. They don't have to be anywhere near icache. Moreover, quite a few
filesystems work that way. VFS simply doesn't give a fuck.

Guys, WTF? Could you please read the (slightly outdated, whatever)
description of the current API _before_ discussing what should be changed?

That's bloody ridiculous - I challenge anyone who did fs work on 2.2, let
alone 2.4 to stand up and say how much common the thing has with 2.0.

"I don't know what's there, but it got to be replaced with $FOO, because
I think that currently it's $BAR or something" is just plain silly,
_especially_ when $FOO is pretty much what we have right now, with several
stupid things fixed and _NONE_ of them relevant to problems in question.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
