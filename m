From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15614.49971.298608.61998@argo.ozlabs.ibm.com>
Date: Thu, 6 Jun 2002 12:04:35 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
In-Reply-To: <3CFCFDB0.9010304@embeddededge.com>
References: <20020530080434.GY16537@zax>
	<20020603024344.GA6765@zax>
	<3CFC0794.7020907@embeddededge.com>
	<15612.47115.300768.766742@argo.ozlabs.ibm.com>
	<3CFCFDB0.9010304@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> IMHO, a tlb miss handler design should simply emulate a hardware implementation,
> and fetch the PTE entries into the TLB cache as quickly and efficiently as
> possible.  You are typically loading valid, ready to use PTEs in a much higher
> proportion to invalid ones, and I don't like the normal fast path cluttered
> by the overhead of checking the special cases that require more work.

Well, simpler is better with a TLB miss handler, for sure.

However, in the context of 4xx, if we load an entry into the TLB with
the valid bit clear, all that will happen is that the cpu will give us
the same TLB miss exception again immediately.  So that doesn't get us
anywhere at all.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
