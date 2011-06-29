Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3413B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 05:40:18 +1000 (EST)
Date: Wed, 29 Jun 2011 14:40:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
Message-ID: <20110629144010.1fe5df24@schlenkerla.am.freescale.net>
In-Reply-To: <1309333828.14501.65.camel@pasglop>
References: <20110622212542.GA23089@schlenkerla.am.freescale.net>
	<1309333828.14501.65.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jun 2011 17:50:28 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-06-22 at 16:25 -0500, Scott Wood wrote:
> > On MMUs such as FSL where we can guarantee the entire linear mapping is
> > bolted, we don't need to worry about linear TLB misses.  If on top of
> > that we do a full table walk, we get rid of all recursive TLB faults, and
> > can dispense with some state saving.  This gains a few percent on
> > TLB-miss-heavy workloads, and around 50% on a benchmark that had a high
> > rate of virtual page table faults under the normal handler.
> > 
> > While touching the EX_TLB layout, remove EX_TLB_MMUCR0, EX_TLB_SRR0, and
> > EX_TLB_SRR1 as they're not used.
> 
> I merged that into -next, but it was breaking 64K pages on WSP, I had to
> add an ifdef in there to skip the PUD level when walking the page tables
> (PUD_SHIFT isn't defined for asm when doing 64K pages).
> 
> Please check I didn't break anything.

Looks good, though I wonder if all the bolted stuff should be under the
ifdef, at least for now.

What is the "weird page table format" referred to by the normal miss
handler?

-Scott
