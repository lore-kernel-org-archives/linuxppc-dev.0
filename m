Message-ID: <BE1C564723B3D21191FD0000F840E39801D81482@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Another try at the run-from-Flash issue for MPC8xx/MBX/custom
Date: Thu, 30 Mar 2000 09:56:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I agree, 40 seconds is too long: he must be doing something wrong.
But even 5 seconds is annoyingly long for an embedded system.

I haven't found anything better than LZO for compressing flash.
It is wicked fast, takes very little code, and no dynamic memory for
decompression.
Compressing takes some memory, and can be slow at higher compression levels,
but that happens once on the host so it isn't an issue.

LZO is available under GPL.  Perhaps someone could investigate using this
for compressing the Linux kernel and initrd.  Alas, I don't have time right
now.
--
Dave Brown <dbrown03@harris.com>
Principal Software Engineer, Harris Corporation

http://wildsau.idv.uni-linz.ac.at/mfx/lzo.html

> -----Original Message-----
> From: Dan Malek [mailto:dan@netx4.com]
> Sent: Wednesday, March 29, 2000 8:26 PM
> To: Doug Rogers
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Another try at the run-from-Flash issue for
> MPC8xx/MBX/custom
>
>
>
> Doug Rogers wrote:
>
> > ..... It is simply a matter of size.
>
> So, what methods are you planning to use for storing the applications,
> libraries and other files you need to use and update?
>
> > ....... I've timed the decompression of our smaller test image
> > and it takes over 40 seconds on a 40MHz MBX860 board.
> That's too slow.
>
> You are doing something very wrong.  I have worked on production
> set top boxes that uncompress a kernel and 16 Mbyte ram disk from an
> 8-bit flash rom that are executing in the application in
> under 5 seconds.
> This is a 50 Mhz 860......turn on some caches, align some data, use
> faster memory.....
>
>
> > I was hoping that Linux was to that point, but apparently not. Just
> > having the kernel run from ROM would be helpful for now,
>
> That saves only about 800K or so of memory.  If you are counting bytes
> at that level you are in trouble already.
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
