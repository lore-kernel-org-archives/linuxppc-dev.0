To: linuxppc-dev@lists.linuxppc.org
Subject: Re: altivec
References: Sacha Varma's message of Fri, 09 Jul 1999 12:29:35 +0100
	<3785DD1F.B853E731@ssl.co.uk> <v04020a00b3aba2034899@[192.168.0.2]>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 09 Jul 1999 17:33:41 +0200
In-Reply-To: Mike DeSimone's message of Fri, 9 Jul 1999 08:04:03 -0500
Message-ID: <8xyagpbzxm.fsf@s53.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike DeSimone <Hot-Wire@mail.utexas.edu> writes:

> 
> 
> >> 2. would it be possible to trap altivec instructions on a non-altivec
> >>    processor and reroute them through code using generic instructions?
> >
> >Possible - yes. Dead slow - absolutely. (Apple's simulator is strictly a
> >development tool, nothing more.)
> 
> It shouldn't be dead slow, but it will be much slower than it would be on
> Altivec processors (esp. since cache pipelining won't work nearly the
> same).  Basically, most Altivec instructions can be replaced with for
> loops.  So long as the iteration count of the loop is high, the overhead
> from the illegal instruction trap activity should be minimized, so it
> should boil down to about the same time as an assembly-coded loop.
> 
Well, if you do instruction-by-instruction emulation, the iteration count is
at most 16 (16 bytes in a vector). Furthermore, the overhead of a context
switch into privileged mode and back again is not negligible (at the very
least a pipeline flush and some saving/restoring of registers). Finally,
keeping the emulated vector registers somewhere in memory means that you will
quite often be limited by the availability of 'only' one load/store unit.

[...]
>
> I'm also wondering what has been done on this issue on the Intel side of
> the fence, since KNI and 3Dnow! are similar to Altivec in concept and, at
> least for 3Dnow!, implementation.
>
Similar? Please forgive my ranting, but AltiVec is feature-complete,
orthogonal, and implemented without compromises. MMX, 3DNow!, and ISSE have
none of the above three qualities. They were available sooner, but that's
about it.

  Holger


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
