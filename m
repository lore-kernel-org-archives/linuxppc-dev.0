Message-ID: <391EA5F6.7AA3BDA4@pop.agri.ch>
Date: Sun, 14 May 2000 15:11:27 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: insl_ns/outsl_ns in 2.3.x kernels???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

on the try to get the vortex 3c590 card to run on the 2.3.99px kernel I
ran in massive trouble. First thought was the driver itself which could
be wrong. But this is not the case, for basic functioning at least.

A 3c905b works, the vortex(3c590) uses insl and outsl functions to
read/write the FIFO's. So I compared the insl_ns and the outsl_ns code
in misc.S from 2.3.99px with the ones from 2.2.16pre2.

Here it comes, below the two functions from 2.3.99p6. The lines which
are commented out are in 2.3.99p6 misc.S. In 2.2.16p2 they are not
available.
When commenting these lines out that it looks like in 2.2.16p2 I get my
vortex to work.

My question, what is behind this scenario, what was the motivation for
this change from stable to devel?
AFAIK these functions, insl/outsl and friends, are used very rarely.

Are there alternate functions available?

As a side note, the ne2k-pci driver uses these functions too.

It would be great if you Paul, or anyone else could explain me the
situation and what I shall do.

TIA

Andreas

_GLOBAL(_insl_ns)
	/*cmpw	0,r5,0*/ <-- used in 2.3.x
	mtctr	r5
	subi	r4,r4,4
	/*blelr-*/          <-- used in 2.3.x
00:	lwz	r5,0(r3)
	eieio
	stwu	r5,4(r4)
	bdnz	00b
	blr

_GLOBAL(_outsl_ns)
	/*cmpw	0,r5,0*/ <-- used in 2.3.x
	mtctr	r5
	subi	r4,r4,4
	/*blelr-*/          <-- used in 2.3.x
00:	lwzu	r5,4(r4)
	stw	r5,0(r3)
	eieio
	bdnz	00b
	blr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
