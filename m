Message-ID: <3C18336D.7030706@embeddededge.com>
Date: Wed, 12 Dec 2001 23:49:49 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@labs.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled - problem found
References: <3C112297.6DE37608@labs.mot.com> <3C114C63.3050102@embeddededge.com> <3C14F91F.F382ABE3@labs.mot.com> <3C177748.1A1342C2@labs.mot.com> <3C17E3B4.9E73B22E@labs.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:


> So the problem is that mask & ack only masks the pending interrupts....

You are right.  Sorry, but I didn't have time today to reply to your first
message.  The problem with the 8xx (and 8260, and 4xx) is there isn't any
notion of priorities within the interrupt nesting.  As you have seen, any
interrupt can interrupt another, and although SIVEC (or the software bit
search) gives us the highest priority pending interrupt, once we enable
them again we get the next one delivered.

We should mask all lower priority interrupts, and the challenge is keeping
the proper nesting of the masks so the nested interrupts can be "unwound"
properly.  I'm thinking about it, and since you have been looking at the
functions so closely, if you have any implementation details let us know :-).
Perhaps we could look at the pending and enabled masks and unmask up to the
next pending interrupt to be serviced.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
