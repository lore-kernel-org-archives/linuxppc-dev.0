Date: Tue, 22 Jun 1999 23:09:02 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
Reply-To: Jeff Rugen <jrugen@primenet.com>
To: Michael Engel <engel@math.uni-siegen.de>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xbh not working (Cirrus X server)
In-Reply-To: <199906230224.EAA24948@fourier.numerik.math.uni-siegen.de>
Message-ID: <Pine.BSI.3.96.990622225336.2245A-100000@usr08.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Jun 1999, Michael Engel wrote:

> 
> 
> Hi,
> 
> I'm experiencing a problem with Xbh on the Motorola PowerStack Series E
> and PowerStack II here. Xbh crashes with segmentation fault shortly after
> starting the server, gdb shows that the server is crashing in
> gd54xx_memsize
> (in xc/programs/Xserver/hw/bh/gd54xx.c). I built XFree from source
> (rpm --rebuild) with the same result. When setting a fixed memsize of 2 MB
> in gd54xx_memsize, the server crashes in outb() in
> gd54xx_setcolor
> 

Ok, I wrote the reply below before I remembered the first important
question:

Are you starting Xbh with the -mmap option?  If you're using 2.2.x or later,
you have to have that option selected, and it might not be default:

startx -- -mmap

If that doesn't work, read on. :-)

------------------

I might be the de-facto maintainer for Xbh right now (I'm the latest person
I know to play with it much).  A couple questions:

1) How much video memory does your graphics chip have (it sounds like 2 MB
with you setting a fixed memsize).
2) What version of Linux are you running.
3) Is your Series E one in a black case, or is it a standard PC
tower/desktop model (I can't remember if my motherboard is considered the
series E, but its a standard PC tower with 2MB video memory -- I'm using
various 2.2.x and 2.3.x kernels, though Xbh mainly with an older 2.2.x
kernel).

Which version of glibc do you have?  (Are you a R5 or pre-R5 distribution,
with the newer glibc, or an older R4+ with glibc 1.99?)

If you're running R5 (glibc of 2.1 or something like that), is it convenient
for you to download the Xbh I have compiled at
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/Xbh-16bit-glibc2x

If you have R4, you could download my updates to the Xbh source from the
same directory and try rebuilding as well, though I can't think of any
changes I made which would affect that -- however, a full gdb output using
that source may be easier for me to deal with, since it represents the
current source that I look at occasionally.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
