Message-ID: <38A0BED6.AD2E336C@zeta.org.au>
Date: Wed, 09 Feb 2000 12:11:50 +1100
From: Peter Allworth <linsol@zeta.org.au>
MIME-Version: 1.0
To: Jesper Skov <jskov@redhat.com>
CC: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: more Re: Low memory problems in 8xx Linux
References: <20000201235813.4F5611B51A@elph.research.canon.com.au> <38977960.40E014A1@zeta.org.au> <ot1z6of1ws.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jesper Skov wrote:

<snip>

> An alternative and slighly faster implementation might be to skip the
> _PAGE_PRESENT check. Any reason something like this wouldn't work?

<snip>

I had another look at the code and I now remember my rationale for
the _PAGE_PRESENT test. It wasn't to do with level 1 table entries,
Dan's code already takes care of that. It was so that a zeroed pte
couldn't get changed to a non-zero value, since that would make the
pte_none() function return the wrong result. (Moreover, it just seemed
wrong to mess with something that's marked "invalid".)

Admittedly I'm being a bit paranoid since the next thing the exception
handler is likely to do is set the page table entry to something valid.
But, can you be sure? What about a segmentation fault? ;)

Cheers,

PeterA.

"I've always considered a paranoid as a man with all the facts."
	-- Tales of Ordinary Madness

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
