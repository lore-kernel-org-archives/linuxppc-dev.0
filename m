Message-Id: <200008291845.NAA17251@jen.americas.sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: "Halfmann, Klaus" <khalfmann@libra.de>, Roman Zippel <roman@augan.com>,
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
Subject: Re: Btree directories (Re: Status of HFS+ support) 
In-Reply-To: Message from Matthew Wilcox <matthew@wil.cx>
   of "Tue, 29 Aug 2000 18:18:51 BST." <20000829181851.D6395@parcelfarce.linux.theplanet.co.uk>
Date: Tue, 29 Aug 2000 13:45:51 -0500
From: Steve Lord <lord@sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Tue, Aug 29, 2000 at 06:40:08PM +0200, Halfmann, Klaus wrote:
> > On the other hand: The hfs acces is normally not needed for heavy
> > concurrent acces. (Mhh, there might be AFP Servers publishing HFS
> > partions) For now it should be enough to have a global update
> > lock on the root of the node. Im not firm with kernel code yet, dont
> > ask me about the details :-)
>
> It's not that easy.  Unfortunately, getdents is a nasty interface (I
> actually haven't seen a good one -- anyone know of one which doesn't
> suffer from this problem?)
>
> You can lock while you're in a call, but eventually, you fill up the
> user's buffer and return.  At that point, you have to drop the lock
> because they might never call you again.  So you have to consider
> the case of a file being added or removed between calls to getdents.
> Current HFS doesn't even pretend to try.  It just stores an index (0
> .. n-1) and you pick up from there.  So sometimes you get files twice,
> sometimes files don't show up at all.
>
> I suspect you need to store the key of the item you just found, and
> then continue filling in the buffer from there on subsequent calls.
> The trouble is that there frequently isn't enough space available to
> do that.  The proposed ext2 btree extensins needed 64 bits of space and
> there was only 32 bits available.  What size keys does HFS+ have?
>
> Hmmm.. now the LFS patches have gone in and f_pos is now a 64-bit quantity,
> this sounds more plausible.  I'd be curious to hear from the ReiserFS
> people how they solved this problem.

f_pos being 64 bit is one thing, go look at the source code for glibc
getdents, it is not 64 bit friendly, actually it is only 31 bit friendly,
if you return anything bigger than a signed integer it gets confused and
can skip entries - or go into an infinite loop.

>
> There's an additional complication of rewinddir/seekdir/telldir, but
> let's get onto that later.

Which glibc getdents uses because it's dirent is different in size from
the kernel's dirent, it uses a heuristic to decide how much data to ask
the kernel for. If it guesses wrong and gets more data back from the
kernel than will fit in the user's buffer it seeks backwards again to
reposition for the next call.

Steve Lord


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
