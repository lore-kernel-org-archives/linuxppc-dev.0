Date: Fri, 18 Aug 2000 10:25:17 -0400
Message-Id: <200008181425.KAA03971@rome.wm.sps.mot.com>
From: kentborg@wavemark.com
To: pkpathak@dnrc.bell-labs.com
CC: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <399B0FCD.A6E0A6BE@dnrc.bell-labs.com> (message from Pravin
	Pathak on Wed, 16 Aug 2000 18:03:57 -0400)
Subject: Re: What is embedded linux ?
References: <399B0FCD.A6E0A6BE@dnrc.bell-labs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pravin Pathak <pkpathak@dnrc.bell-labs.com> asked how embedded Linux
can work without a disk.

And, as others have already posted, it is quite possible to have a
rather traditional file system even if there is no spinning magnetic
media supporting it.

He also wrote:
>...from where it loads shell and other application task images... For
>VxWOrks/pSOS have a single object file.

Our current designs are also based on this traditional embedded
architecture.  The program sits in ROM, and when the program counter
points to it, it runs.

>How about Embedded Linux?

Linux programs also execute when the program counter eventually points
to them.  And, in an embedded system, that software might well sit in
some sort of directly accessable ROM.  BUT, in all versions of
embedded Linux that I have heard of, there is no way to set the
program counter to point to ROM and execute software *in*place*, it
must first be copied into RAM buffers.  (And compete with other uses
of buffer space.)

Frequently this is a quite sensible approach: Software can be
compressed to fit in a small, slow, narrow, inexpensive part, and the
first increment of RAM might be 8 MB and more than ample.  After all,
Unix started life as with disk space being significantly larger than
RAM, so embedded uses without any disk have been tended towards
systems flush with RAM.

However, there are situations (such as ours) where RAM is tight.  In
our systems the embedded software is large and already going to live
in fast, wide flash parts.  Our software is about as big as its
minimum RAM requirements.  In our case the cost of the RAM is a
significant part of total product cost which must be kept low,
doubling our minimum RAM needs as the price of going to Linux is
unattractive.  Plus, in our price/performance sensitive case we need
to spend wisely all of the computrons the CPU can put out.  To spend
the time to frequently copy to RAM is expensive, and to spend the
money on enough extra RAM to only do that copying once is still
uncertain, for the point at which we might run low on RAM is also a
point when we want the system to be both fast and deterministic.
Starting to page at that point--even from a fast source--is scary.

Alas, there is apparently no Linux code in existence that does what we
need.

To do this, from what I have learned so far, would take the following
(substantive comments from any who know better would be much
appreciated):

1) Development tools to create an object file type that is directly
   executable.

   At first glance this sounds easy, but dynamic libraries are a major
   catch.  Static linking would get around this, but then object sizes
   would balloon for anything but monolithic code, and one of the
   reasons for going to Linux is to not be monolithic.

   One way to use dynamic linking would be to also put those routines
   (formerly thought to be dynamic) in their own directly executable
   files, at known addresses, and for the software that uses them, to
   have done the dynamic "fixup" in advance.  This way these routines
   would remain single shared copies.

   For development stages it would be nice, when possible, to have
   traditionally loaded programs also link to those shared routines
   that have already been stored in directly executable form, but I
   don't think it would be strictly necessary.  It depends upon how
   easy it would be to implement this, it might fall out for free or
   nearly free.  If so, cool.

2) Driver for a file system that handles this kind of
   executable-in-place file.

   Uses of this file system would skip the traditional copying into
   buffer space and pointing the CPU at it, rather I figure it would
   set up something that looked very much like a memory mapped file,
   but where the entire file is resident and so there is never going
   to be a page fault.  If there is never a page fault, there is never
   a need to page in a missing portion of the file, it merely executes
   in place.  There is never going to be any non-deterministic
   fighting for buffer space on the part of this executable.

   Any application code that wishes to efficiently access large
   in-place data files could do so, but would have to know it would be
   doing so and not use standard IO functions (which are inherently
   buffered).

Certainly the current use-the-buffers-Luke philosophy of embedded
Linux works (and works well) for many applications, but not for all.
(Yes, I *have* done the math.  It is not appropriate for us.)
Especially if avoiding it is only a Simple Matter of Programming.


-kb, the Kent who hasn't had the time (yet) to learn enough and
implement the above hypotheticals.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
