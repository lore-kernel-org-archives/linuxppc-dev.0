Message-ID: <3E652B8C.8080602@embeddededge.com>
Date: Tue, 04 Mar 2003 17:41:16 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Tom Rini <trini@kernel.crashing.org>,
	Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I can't find any further info about this bug/workaround. There is nothing in
> linux that indicates that the workaround is dependant on any revision.

That's because we couldn't determine which ones in particular may be
broken.  Remember there are several different sources of cores, the 823/850
core is different from the 860 core.  We don't distinguish among these
in the kernel.

> Further, dcbi and dcbz are pretty similar in behavior w.r.t TLB error so
> I suspect that if this works for dcbi it also works for dcbz, only
> on kernel addresses though.

Maybe.

> Maybe user space also can be fixed with instruction decoding

No, user space has always been "fixed" by providing a unique version
of C libraries for the 8xx.  This has to be done for more reasons
than just the cache instructions.  It also includes supporting a
different sized cache line for dynamic relocation and often the
performance advantage of using soft-float instead of kernel emulated
floating point.  It's also perfectly suited for the IBM 403, BTW :-)

> as Daniel said even if it's ugly. Then you would not have to worry about
> apps/libs using dcbz, at least it would work but perhaps the performance sucks

I'm trying to discourage you guys from wasting time here.  These are
all known problems that have been solved.  If we want to use this processor
we have to accept some limitations and get on with using it. :-)  People
have been successfully deploying products for years using Linux and 8xx.
Leave the cache instructions alone.  :-)

This discussion has been moved to a very low priority in my mailbox.
Don't expect timely or any further replies, and please don't be sending me
any dcbz kernel patches! :-)

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
