From: flar@allandria.com
Message-Id: <200008300222.TAA13173@marcus.allandria.com>
Subject: Re: Btree directories (Re: Status of HFS+ support)
To: matthew@wil.cx (Matthew Wilcox)
Date: Tue, 29 Aug 2000 19:22:05 -0700 (PDT)
Cc: khalfmann@libra.de (Halfmann Klaus), matthew@wil.cx ('Matthew Wilcox'),
        roman@augan.com (Roman Zippel), linuxppc-dev@lists.linuxppc.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20000829181851.D6395@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at Aug 29, 2000 06:18:51 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matthew Wilcox wrote:
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

Catalog keys in HFS+ can be anywhere from 8 bytes all the way up to
518 bytes. I actually do save the key and do a search in the btree
in my HFS+ module. (It doesn't seem to work however. And yes, I'm
helping out Klaus with his code as well as working on a kernel
module with completely separate code.)

> Hmmm.. now the LFS patches have gone in and f_pos is now a 64-bit quantity,
> this sounds more plausible.  I'd be curious to hear from the ReiserFS
> people how they solved this problem.

The support for 64 bit filesystems is important for HFS+ as well, since
it uses 64 bit file sizes for all files.

> > I'd really like to know how the concurrency of the kernel filesystem
> > should work, can anybody feed me with documentations about that ?
>
> I've cc'd linux-fsdevel, where people can fill you in.

I've been ignoring this issue, but I certainly would love pointers to
more documentation.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
