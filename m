Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D8D4B70D4
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 12:31:19 +1100 (EST)
Subject: Re: in_atomic() check in page_cache_get_speculative()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20101004153753.2cda1abf@udp111988uds.am.freescale.net>
References: <20101004152259.25c56ad2@udp111988uds.am.freescale.net>
	<20101004153753.2cda1abf@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 12:31:04 +1100
Message-ID: <1286501464.2463.400.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nick Piggin <npiggin@kernel.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-04 at 15:37 -0500, Scott Wood wrote:
> [Updated with Nick's current address; previous one bounced]
> 
> On Mon, 4 Oct 2010 15:22:59 -0500
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > I'm seeing the in_atomic() check in page_cache_get_speculative()
> > (linux/pagemap.h:138) fail when running e500 KVM with .  
> 
> Sorry, that should finish as "with CONFIG_DEBUG_VM."
> 
> > It's coming
> > from get_user_pages_fast(), from KVM's hva_to_pfn().  This is on kvm.git
> > plus a few local patches that should be completely unrelated, but it
> > looks like this code hasn't changed much in a couple years.
> > 
> > Interrupts are disabled by get_user_pages_fast(), but apparently
> > preemption was not separately disabled.  The comment in
> > page_cache_get_speculative() says that preemption disabling is done by
> > rcu_read_lock(), and that "this function must be called inside the same
> > rcu_read_lock() section as has been used to lookup the page in the
> > pagecache radix-tree (or page table)".
> > 
> > Where is this RCU lock supposed to be acquired?  I don't see any RCU in
> > arch/powerpc/mm/gup.c.  Is it buried in some macro or function call?
> > 

Well, we shouldn't need the rcu lock if interrupts are off, at least
that's my understanding...

Cheers,
Ben.
