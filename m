Message-ID: <3CFCFDB0.9010304@embeddededge.com>
Date: Tue, 04 Jun 2002 13:49:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
References: <20020530080434.GY16537@zax>	<20020603024344.GA6765@zax>	<3CFC0794.7020907@embeddededge.com> <15612.47115.300768.766742@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:


> If the PTE isn't valid (i.e. the _PAGE_PRESENT bit is 0) we don't put
> it into the TLB.

OK, so remove the tlbsx..........The tlb handler doesn't look like the
one I originally wrote, so whoever made the changes should have understood
and changed everything.  I'm just explaining why it was there in the first
place, maybe it isn't needed anymore.

IMHO, a tlb miss handler design should simply emulate a hardware implementation,
and fetch the PTE entries into the TLB cache as quickly and efficiently as
possible.  You are typically loading valid, ready to use PTEs in a much higher
proportion to invalid ones, and I don't like the normal fast path cluttered
by the overhead of checking the special cases that require more work.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
