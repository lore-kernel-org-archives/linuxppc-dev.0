Message-ID: <3C7BC097.20009@embeddededge.com>
Date: Tue, 26 Feb 2002 12:06:31 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "John W. Linville" <linville@lvl7.com>
Cc: David Ashley <dash@xdr.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
References: <200202260315.g1Q3Fmt18809@dave.home> <3C7B0605.3080308@embeddededge.com> <3C7B9F2E.40BC7C46@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John W. Linville wrote:

> Could you elaborate on the problems associated w/ bus timings that
> you've seen on the 8xx?

I don't remember the details anymore.  I just remember looking at logic
analyzer traces of the system bus around MMU faults and CPM DMA and
thinking "....so that's what they mean in this timing diagram...."
As I recall, the bus lines would start to change state, but never really
start a cycle.

> .... We've been seeing a lot of unexplained Oops
> messages (and even crashes) on one of our hardware platforms.

This could be for many reasons.

> ....  The only
> common thread seems to be dereferncing bad pointer values,

Well, you aren't going to crash if you don't have bad pointer values,
so that is what you are going to see :-).

> I've asked our hardware guys to take a look at the settings for the UPM
> we are using to control SDRAM.  Do you think we are on the right track?
> Can you provide any guidance?

It could be incorrect timing.  That is one of the common problems.  You
don't get worst case bus timing until you fire up copyback caches, enable
the MMU, and start up the CPM DMA.  The core itself can't generate back to
back DRAM cycles.  Marginal timing or parts are going to show up on only
some boards.

If the DRAM timing is correct, these "weird" bus cycles don't bother DRAMs.
It usually messes up other devices glued on the 8xx bus that are trying to
decode their own address space.  It isn't like this isn't documented, but
it is easy to ignore or not understand until you see it in action.

> Thanks in advance for any help you can provide!  I'll buy you a beer and
> some maple candy the next time I'm up your way! :-)

Anything associated with UPM and SDRAM is going to cost you lots more
than a beer :-).

Good Luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
