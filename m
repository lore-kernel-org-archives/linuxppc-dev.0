From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15612.47115.300768.766742@argo.ozlabs.ibm.com>
Date: Tue, 4 Jun 2002 22:52:27 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
In-Reply-To: <3CFC0794.7020907@embeddededge.com>
References: <20020530080434.GY16537@zax>
	<20020603024344.GA6765@zax>
	<3CFC0794.7020907@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> An instuction TLB miss will load the TLB with a PTE that indicates it isn't
> valid.  A subsequent TLB instruction fault to load the page will cause a

If the PTE isn't valid (i.e. the _PAGE_PRESENT bit is 0) we don't put
it into the TLB.  If we did it would be ignored by the hardware and we
would get another TLB miss straight away.  I believe that on 8xx you
actually have two valid bits in each TLB entry, so you can have a TLB
entry that is "valid" but describes a non-present page.  That isn't
the case on 4xx.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
