Message-ID: <396B42F0.EF939444@embeddededge.com>
Date: Tue, 11 Jul 2000 11:53:20 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Adrian Cox <apc@agelectronics.co.uk>
CC: Dan Malek <dan@netx4.com>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com> <396969E1.A7256E4A@lightning.ch> <396A5162.411F49EF@embeddededge.com> <396AF1B8.6FB1401C@agelectronics.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox wrote:

> The 7xx(x) processors don't have the alignment handler set up ....

Paul and I (and possibly others) conspired and added this in the late
2.3.xx kernels for all processors.  It had been floating around for
the MPC8xx processors, I hit it again on the 8260, and we just made
the code generic for all processors.  It "fixes" alignment faults and
will also zero memory on a dcbz fault.  Hmmm, I wonder if this code
actually gets called and if it still does the right thing?  I'll check
it again.

> Or by removing the cache operations. Even if they stay, could they be a
> compilation time optimisation for particular processors?

While the code wasn't really correct for anything but 32 byte cache
lines, it should work correctly on 16 byte lines.  You don't get the
performance increase as the dcbz is only performed every other cache
line.  However, like David mentioned, it really is broken for 64 and
128 byte cache lines.  Here, you zero a long line, but only fill 32
bytes of data.  You end up with a nearly zero filled buffer.

Anyway, enough talk, it has to be fixed.  I'll do the best I can.  I
would like to remove the assumption in copy_tofrom_user that we can
fault in so many places in the cache line.  Considering all of the
alignment restrictions, it seems to me you will only fault on the
first access to the cache line (it isn't like you are going to
cross a page boundary in the middle of a line).  This would simplify
the function and make for a much smaller exception table.

> The 7400 certainly doesn't need the dcbz, as it will perform an implicit
> allocation if the entire cache line is written by store instructions.

No, but those cache streaming instructions and data move cache hints
really do something.  It was my attempt at humor, you see :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
