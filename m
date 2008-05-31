Return-Path: <jeremy@classic.engr.sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id E74BFDDF45
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 17:52:51 +1000 (EST)
Date: Sat, 31 May 2008 00:52:42 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080531075242.GC108600@sgi.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<yq0iqwxrwuh.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq0iqwxrwuh.fsf@jaguar.mkp.net>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 29, 2008 at 10:47:18AM -0400, Jes Sorensen wrote:
> Thats not going to solve the problem on Altix. On Altix the issue is
> that there can be multiple paths through the NUMA fabric from cpuX to
> PCI bridge Y. 
> 
> Consider this uber-cool<tm> ascii art - NR is my abbrevation for NUMA
> router:
> 
>         -------         -------
>         |cpu X|         |cpu Y|
>         -------         -------
>          |   \____  ____/    |
>          |        \/         |
>          |    ____/\____     |
>          |   /          \    |
>          -----          ------
>          |NR 1|         |NR 2|
>          ------         ------
>               \         /
>                \       /
>                 -------
>                 | PCI |
>                 -------
> 
> The problem is that your two writel's, despite being both issued on
> cpu X, due to the spin lock, in your example, can end up with the
> first one going through NR 1 and the second one going through NR 2. If
> there's contention on NR 1, the write going via NR 2 may hit the PCI
> bridge prior to the one going via NR 1.

We don't actually have that problem on the Altix.  All writes issued
by CPU X will be ordered with respect to each other.  But writes by
CPU X and CPU Y will not be, unless an mmiowb() is done by the
original CPU before the second CPU writes.  I.e.

	CPU X	writel
	CPU X	writel
	CPU X	mmiowb

	CPU Y	writel
	...

Note that this implies some sort of locking.  Also note that if in
the above, CPU Y did the mmiowb, that would not work.

jeremy
