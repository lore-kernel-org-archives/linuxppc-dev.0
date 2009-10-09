Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E82F6B7B79
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 11:57:25 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFD13ED50D.BE2734E7-ONC1257649.007DB1F8-C1257649.007E7CB6@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
	<1255033705.2146.17.camel@pasglop>
	<34A4641D-8121-4EBC-9880-26CB70DD3339@embeddedalley.com>
	<1255040628.2146.54.camel@pasglop>
	<OFD13ED50D.BE2734E7-ONC1257649.007DB1F8-C1257649.007E7CB6@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 11:56:45 +1100
Message-Id: <1255049805.2355.23.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 01:01 +0200, Joakim Tjernlund wrote:
> Ok, that's my understanding too and I think we had the tlbie in
> > update_mmu_cache to do the trick, though the comment is misleading
> > making it think that the only reason it's there is for the dcbst
> > problem. At least that's my understanding. That was lost recently in
> 2.6
> > so I'll have to put it back properly.
> 
> So you don't think my invalidate "only !present pages" patch in
> do_page_fault is enough?

It might well be the right solution, I was talking about the code as we
have upstream today.

> I don't think we do the pre-load to avoid the second fault, but we
> It won't get much faster than my current patch. Trapping all DTLB
> Errors to C won't make it faster, only more correct should there be
> a bug in the asm version. Actually there is one that has been there
> all the time, guarded flag is not set by DTLB Error.

There's other areas of improvements I suggested that can make it faster
such as avoiding the whole kernel/user test in the TLB misses.

Removing the stuff in DataTLBError can potentially make normal page
faults faster too by avoiding going through a bunch of useless code
before going to do the real thing in C :-)

As I said, the case of ACCESSED or DIRTY updates are rare enough to not
warrant code in the main page fault hot path.

Cheers,
Ben.
