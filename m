In-Reply-To: <40BB42EF.10805@intracom.gr>
References: <40BB42EF.10805@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6715B8BC-B4A7-11D8-853B-003065F9B7DC@embeddededge.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] fix TLB handling for 8xx on linuxppc-2.5
Date: Wed, 2 Jun 2004 11:13:28 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 31, 2004, at 10:36 AM, Pantelis Antoniou wrote:
> +#define LAZY_DTLB_FIX			\
> +	rlwinm  r12,r10,0,23,25;	\
> +	cmpwi   r12,0xc0;		\
> +	bne+    0f;			\
> +	ori     r10,r10,0x100;		\
> +	b	1f;			\
> + 0:	cmpwi   r12,0x100;		\
> +	bne+    1f;			\
> +	rlwinm  r10,r10,0,24,22;	\
> + 1:
> +

This shouldn't be necessary.  The TLB handler manages dirty/used
flags already.  There is absolutely no need for testing/branching like
this in the TLB handlers.  Simply getting the exception and the flow
through the handler will imply the states that need to be cleared or
set.

I'll look into this further.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
