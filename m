Message-ID: <3E63F69C.80001@embeddededge.com>
Date: Mon, 03 Mar 2003 19:43:08 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-dev@lists.linuxppc.org, drow@false.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <005401c2e0e4$27a1b6b0$020120b0@jockeXP> <3E63C6BE.6020002@embeddededge.com> <006a01c2e1da$e108ddd0$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> OK so this is not it then, but what is it then? Are you 100% that
> the bug(whatever this may be) is present for mpc860, rev D4 or later?
> How can I make it bite me on kernel space memory?
> I can't find that info in the archives, if it's there please give me a hint.

I guess once again I don't understand the questions or failed to express
my responses properly.

In the previous message, you included a link that indicated a problem
setting the DAR, cache instructions, and asked if this was a problem.
In this case, due to the way we map kernel space and use the cache instructions,
we have "fixed" this bug.  I believe it was found because of the way we
copy instructions in the C library, and it affected user applications.
The specific problem described in this link is not a problem with Linux.

In general, over the many years and many different revisions of 8xx silicon,
there was always a common problem with cache instructions used on virtual
addresses that missed in the TLB.  They either never caused an exception,
caused the wrong one, or didn't set status or other registers as expected.
It was possible to trigger the proper sequence of events with Linux because
we heavily use the TLB in a dynamic manner and use a variety of different
cache modes on a page resolution.  To discover the error required a specific
code path with the TLB in a certain state and data accessed in a particular
cache line.  It was often configuration specific, as adding/deleting options
moved code in the kernel.

> I have enabled all kernel functions that uses dcbz for 8xx as well. I even split copy_tofrom_user
> into copy_from_myuser resp. copy_to_myuser and enabled dcbz in copy_from_myuser
> and still everything is working just fine.

Maybe it works in your silicon.  Maybe it works because the code path and
data access doesn't trigger a problem.  Maybe it works because the cache
instructions aren't doing anything and the data didn't need to get zeroed
out to start with (this happens in lots of cases).  We know there are lots
of cases where the instructions don't work, and you are the first to claim
they do.  I'd suggest posting a patch someplace, let people use it if they
wish, and try to accumulate real application information to see if we can
collect some stability data.  I hope the only change needed to the code
is modification of the 'ifdef CONFIG_8xx' directives in the assembler code
that implements the clear/copy functions.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
