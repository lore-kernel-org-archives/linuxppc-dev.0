Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9035CB7B7C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 12:12:59 +1100 (EST)
Subject: Re: I think I have 8xx working...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
References: <20091015004127.GA15570@laura.chatsunix.int.mrv.com>
	<1255568772.2347.60.camel@pasglop>
	<20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Oct 2009 12:12:50 +1100
Message-Id: <1255569170.2347.62.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-14 at 18:08 -0700, Rex Feany wrote:
> Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > On Wed, 2009-10-14 at 17:41 -0700, Rex Feany wrote:
> > > The biggest problem for me turned out to be the MMU context IDs being
> > > clamped to 32 when the 8xx only has 16. With this, things are a bit more
> > > stable :)
> > 
> > This is with Joakim patches or without ?
> 
> with just one: adding tlbil_va() to do_page_fault().

Ah cool, at least that keeps my sanity, I didn't get how it could work
at all without that bit :-)

Scott, Joakim: It will be interesting to figure out exactly what is the
condition where that is necessary. It definitely should make the one
in set_pte_filter() or ptep_set_access_flags_filter() unnecessary.

Joakim, you mentioned increased amount of TLB errors or misses when
doing that too often, that sounds a bit weird and worth investigating

Finally we could implement preload from update_mmu_cache() but that's a
different matter alltogether.

Cheers,
Ben.
