Message-ID: <3CFC0794.7020907@embeddededge.com>
Date: Mon, 03 Jun 2002 20:19:32 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
References: <20020530080434.GY16537@zax> <20020603024344.GA6765@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Ok, not seeing any replies here.  If no-one speaks up for this tlbsx
> in the next couple of days, I'll remove it from 2_4_devel.

Some of us (fortunately) have a life outside of kernel hacking, so
it takes time to reply.

An instuction TLB miss will load the TLB with a PTE that indicates it isn't
valid.  A subsequent TLB instruction fault to load the page will cause a
data tlb miss to copy the page, and when you fix up this entry to allow a
write, you don't want to create an alias in the TLB.

If you remove the tlbsx, you can see this happen when init starts and you
dump the TLB after every type of TLB fault while it is starting.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
