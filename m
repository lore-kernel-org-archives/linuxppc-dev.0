From: linas@austin.ibm.com
Date: Fri, 2 Apr 2004 16:17:06 -0600
To: "Christopher R. Johnson" <cjohnson@gcctech.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: General question about caching
Message-ID: <20040402161706.B58706@forte.austin.ibm.com>
References: <406D92CF.8040302@gcctech.com> <20040402110239.A58706@forte.austin.ibm.com> <406DBE90.1060603@gcctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406DBE90.1060603@gcctech.com>; from cjohnson@gcctech.com on Fri, Apr 02, 2004 at 02:27:12PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 02, 2004 at 02:27:12PM -0500, Christopher R. Johnson wrote:
>
> Ok, I'll give it a shot.
>
> 1. Isn't it taking up memory?  If not then what does "Cached: 11924kB"
> mean in meminfo?  With my embedded application, I desperately need every
> byte I can get; 11924k is HUGE in my little 32MB environment.

Its only using space that no one else is using.  If you malloc more
space for yourself, the cache will shrink; but for the most part the
kernel will try to use all of the memory it can.  No harm in that, it
usually helps.

> 2. Not sure why its vague that avoiding needless caching in ram of stuff
> that's already in ram is silly.  Perhaps the performance hit is minimal,
> but its still silly.  At the very least won't there be some needless
> data copying?

Yes, there's probably some needless copying, although I haven't really
read through the linux kernel ramdisk implementation, so I don't really
know. They might have gotten smart.  But things like buffer heads
contain all sorts of flags and locks and linked lists and
what-not in there, so you can't just poof-and-make it go away.

> Which cache is used for file contents?  That would be the one I don't need.

Not sure what you mean.  The buffer cache?

Maybe you're thinking about the /proc/slabinfo?  It hold the various
allocated and free blocks of various sizes, it speeds up allocation.

Different filesystems organize thier data in different ways; e.g. reiserfs
packs file tails into one block.  There's no trivial way to figure out
what data is where in a file system, which is why the the "users" usually
go through buffers.  You can layer block devices onto files in
arbitrary file systems on block devices ad infinitum; there's no trivial
untangling of this stuff.

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
