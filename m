Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F0DE2DDFFB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:35:25 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop>
Date: Tue, 27 May 2008 14:33:48 -0700
In-Reply-To: <1211922696.3286.82.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Wed, 28 May 2008 07:11:36 +1000")
Message-ID: <adaiqwzsa83.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > This is a different issue. We deal with it on powerpc by having writel
 > set a per-cpu flag and spin_unlock() test it, and do the barrier if
 > needed there.

Cool... I assume you do this for mutex_unlock() etc?

Is there any reason why ia64 can't do this too so we can kill mmiowb and
save everyone a lot of hassle?  (mips, sh and frv have non-empty
mmiowb() definitions too but I'd guess that these are all bugs based on
misunderstandings of the mmiowb() semantics...)

 > However, drivers such as e1000 -also- have a wmb() between filling the
 > ring buffer and kicking the DMA with MMIO, with a comment about this
 > being needed for ia64 relaxed ordering.

I put these barriers into mthca, mlx4 etc, although it came from my
possible misunderstanding of the memory ordering rules in the kernel
more than any experience of problems (as opposed the the mmiowb()s,
which all came from real world bugs).

 - R.
