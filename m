In-Reply-To: <40B4880B.1000801@intracom.gr>
References: <40B4880B.1000801@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B89F9AE2-AFF4-11D8-89B7-003065F9B7DC@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: 8xx-2.6 | Prolog
Date: Thu, 27 May 2004 11:44:21 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 26, 2004, at 8:05 AM, Pantelis Antoniou wrote:

> Awaiting comments.

The interrupt stuff in patch 1 was wrong when it was done in 2.4
and I'm disappointed to see it again in 2.6.  Unfortunately, I
don't have time to fix it now, but it will get done properly when I
implement the similar thing for the 8560.

In patch 4, get rid of that #if 0 around the machine check exception.
If the code works, just check it in.  We can't define update_mmu_cache
as a null function.  It performs a necessary function of cache
management.  We may just be lucky because the caches on the 8xx
are small, but this is a subtle bug waiting to happen.

Why did you need to include patch 5 and 6?  These should have
been done and checked into the trees long ago.

In patch 8, why is the 8xx FEC driver dependent upon NETTA and
NETPHONE?  All 8xx boards should use this driver, and it would have
been nice if you would have done board specific files for all other
8xx boards that are supported, even if they couldn't be tested.  The
price of making such major changes that affect everyone :-)

I did not check these in.  Tom can you do so and make sure other
8xx boards will at least compile?  I'll fix up the stuff I don't like
later :-)

Thanks.

	-- Dan

>
> Pantelis
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
