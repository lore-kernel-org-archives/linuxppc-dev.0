Message-ID: <3740310A.1B7B7492@jlc.net>
Date: Mon, 17 May 1999 11:08:58 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: MPC8xx porting issues
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




To those of you that are having "weird" problems with the 8xx port.........
It hit me this morning.  If you are running with copy back caches enabled,
please use the binaries of the libraries I have compiled and placed on the
server.  It contains a modification to the dynamic loader function so it
understands the smaller size of the 8xx caches.  The global cache mode
configuration is found in 'arch/ppc/kernel/head.S', and I believe I enable
copy back by default.

To those of you working on the PPC software.....we need a solution to this
cache line size difference so we don't need a unique 8xx library set (although
we probably should for floating-point purposes).  The other real big cache
related issue is the 8xx will only support the 'dcbz' instruction on cache
lines marked as copy-back.  If implementations choose to use write
through or no cache modes on some data pages (I/O for example), the
"optimized" memory zero functions using 'dcbz' will generate data access
exceptions in logically correct code.

Thanks.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
