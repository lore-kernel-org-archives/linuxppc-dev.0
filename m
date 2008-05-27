Return-Path: <SRS0+2f27d213a50205e9664f+1738+infradead.org+arjan@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7A43DDF87
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 14:27:21 +1000 (EST)
Date: Mon, 26 May 2008 21:20:10 -0700
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080526212010.664302cf@infradead.org>
In-Reply-To: <adad4n82xud.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org> <adad4n82xud.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 26 May 2008 21:08:10 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > either via sparse or some fancy lockdep like "device store" thing?
>  > If we can't test for it and it doesn't show up on x86 ... it'll
>  > just be an eterrnal chase.
> 
> Ben's point is that it will start showing up on x86 because newer
> compilers are reordering things...
> 
>  - R.


I know a basic reorder will show up there. A simple "barrier()" in
readl/writel solves it for x86. Understandably, Ben doesn't really like
that answer ;-)

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
