Message-ID: <392EE49F.234413C5@embeddededge.com>
Date: Fri, 26 May 2000 16:54:55 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Curious limitation in copy_from_user()
References: <392EDED5.33749798@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Roberts wrote:
>
> While porting Linux PPC to my hardware, I discovered a curious
> limitation in copy_from_user() -- it cannot handle uncached memory.

Yeeup.  We have discussed that before.  The later/newer kernels trap
this fault and emulate the data move.  Although there are some cases
as you just discovered, the larger sample indicated access to uncached
memory spaces required special handling so this wasn't going to be
a problem.

The only choice is to not take advantage of the performance enhancements,
which didn't seem like a good thing.  In your case, you will have to write
your own function to validate the user buffer space and then copy the
data in a loop.  Perhaps we need a copy_from_user_uncached() or
something.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
