Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 710461007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 00:34:54 +1000 (EST)
Date: Thu, 12 May 2011 16:08:32 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] seqlock: don't smp_rmb in seqlock reader spin loop
Message-ID: <20110512140832.GK6008@one.firstfloor.org>
References: <1304703767.3066.211.camel@edumazet-laptop>
	<20110506175051.GL11636@one.firstfloor.org>
	<1304710003.2821.0.camel@edumazet-laptop>
	<1304712267.2821.29.camel@edumazet-laptop>
	<1304713443.20980.124.camel@work-vm>
	<1304721004.2821.148.camel@edumazet-laptop>
	<1304722000.20980.130.camel@work-vm>
	<1304722835.2821.192.camel@edumazet-laptop>
	<1304724519.20980.139.camel@work-vm> <seqlock-rmb@mdm.bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <seqlock-rmb@mdm.bga.com>
Cc: Nick Piggin <npiggin@kernel.dk>, Eric Dumazet <eric.dumazet@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi@firstfloor.org>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2011 at 04:13:54AM -0500, Milton Miller wrote:
> 
> Move the smp_rmb after cpu_relax loop in read_seqlock and add
> ACCESS_ONCE to make sure the test and return are consistent.
> 
> A multi-threaded core in the lab didn't like the update

Which core was that?

-Andi
