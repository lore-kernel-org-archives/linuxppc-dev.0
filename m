Message-ID: <385872A6.14555CD1@netx4.com>
Date: Thu, 16 Dec 1999 00:03:34 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <3857E6CC.2D99B69C@netx4.com> <38581CA8.152E5204@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> In the mbxboot directory, the code basically copies the kernel to
> 0x100000, uncompresses the kernel and then jumps to the kernel starup
> code.  I take it this is known as the "kernel loader" ?

Yeah, I guess that is a good name for it.

> This code has statements to invalidate the cache before jumping to the
> kernel. Is this the same as making sure lines are not "locked" in the
> cache ?

No.  There are a couple of cache instructions that need to
be run during processor initialization out of reset.  I don't
have a book handy, but if you look in my fadsrom code in
start.S, the instructions are there.  It is a certain sequence
of invalidates and unlocks.


> All caches are disabled at this stage so I guess it shouldn't matter.

Right.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
