Date: Tue, 29 Aug 2000 22:25:13 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Steve Lord <lord@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "Halfmann, Klaus" <khalfmann@libra.de>,
        Roman Zippel <roman@augan.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support)
Message-ID: <20000829222513.A830@parcelfarce.linux.theplanet.co.uk>
References: <matthew@wil.cx> <200008291845.NAA17251@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200008291845.NAA17251@jen.americas.sgi.com>; from lord@sgi.com on Tue, Aug 29, 2000 at 01:45:51PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 29, 2000 at 01:45:51PM -0500, Steve Lord wrote:
> f_pos being 64 bit is one thing, go look at the source code for glibc
> getdents, it is not 64 bit friendly, actually it is only 31 bit friendly,
> if you return anything bigger than a signed integer it gets confused and
> can skip entries - or go into an infinite loop.

hmm.. glibc 2.2 looks better from this PoV..  but i haven't tested it,
is the bug gone?

> > There's an additional complication of rewinddir/seekdir/telldir, but
> > let's get onto that later.
>
> Which glibc getdents uses because it's dirent is different in size from
> the kernel's dirent, it uses a heuristic to decide how much data to ask
> the kernel for. If it guesses wrong and gets more data back from the
> kernel than will fit in the user's buffer it seeks backwards again to
> reposition for the next call.

Exactly.  So, as a minimum, we have to be able to support seeking to one
of the keys in the B-tree.  It'd be nice if the search algorithm coped
with searching for an entry which is between two values in the B-tree
and returned the lower one.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
