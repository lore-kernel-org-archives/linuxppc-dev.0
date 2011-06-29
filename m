Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5304B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 17:50:40 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110622212542.GA23089@schlenkerla.am.freescale.net>
References: <20110622212542.GA23089@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 17:50:28 +1000
Message-ID: <1309333828.14501.65.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-22 at 16:25 -0500, Scott Wood wrote:
> On MMUs such as FSL where we can guarantee the entire linear mapping is
> bolted, we don't need to worry about linear TLB misses.  If on top of
> that we do a full table walk, we get rid of all recursive TLB faults, and
> can dispense with some state saving.  This gains a few percent on
> TLB-miss-heavy workloads, and around 50% on a benchmark that had a high
> rate of virtual page table faults under the normal handler.
> 
> While touching the EX_TLB layout, remove EX_TLB_MMUCR0, EX_TLB_SRR0, and
> EX_TLB_SRR1 as they're not used.

I merged that into -next, but it was breaking 64K pages on WSP, I had to
add an ifdef in there to skip the PUD level when walking the page tables
(PUD_SHIFT isn't defined for asm when doing 64K pages).

Please check I didn't break anything.

Cheers,
Ben.
