Message-ID: <38581CA8.152E5204@ctam.com.au>
Date: Thu, 16 Dec 1999 09:56:41 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <3857E6CC.2D99B69C@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Brian Kuschak wrote:
>
> > Other potential problem, which has bitten me, is to
> > make sure you don't have any lines locked in cache
> > before you jump to the kernel loader.
>
> This is all part of the documented steps necessary to
> properly initialize the 8xx after power up........things
> a boot rom should perform.

I'm going to jump back a step or two so I can clarify a few things.

In the mbxboot directory, the code basically copies the kernel to
0x100000, uncompresses the kernel and then jumps to the kernel starup
code.  I take it this is known as the "kernel loader" ?
This code has statements to invalidate the cache before jumping to the
kernel. Is this the same as making sure lines are not "locked" in the
cache ?

I have boot code which does basic initialisation of the 860
(chipselects, DRAM, etc).  This code will eventually jump to the start
of the "kernel loader".  Do I also have to invalidate the caches just
before jumping to the kernel loader ?  This currently isn't done.  BTW.
All caches are disabled at this stage so I guess it shouldn't matter.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
