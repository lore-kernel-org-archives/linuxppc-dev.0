Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 209C310099A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 14:23:36 +1000 (EST)
Subject: Re: [PATCH] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric B Munson <emunson@mgebm.net>
In-Reply-To: <20110406212733.GB2596@mgebm.net>
References: <1301059689-4556-1-git-send-email-emunson@mgebm.net>
	<1301378637.2402.671.camel@pasglop> <20110329142519.GA3527@mgebm.net>
	<1301433165.2402.689.camel@pasglop> <20110330183656.GA2564@mgebm.net>
	<1301551476.2407.61.camel@pasglop>  <20110406212733.GB2596@mgebm.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Apr 2011 14:22:57 +1000
Message-ID: <1302150177.2458.30.camel@pasglop>
Mime-Version: 1.0
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > Doesn't that mean that power_pmu_read() can only ever increase the value of
> > the perf_event and so will essentially -stop- once the counter rolls over ?
> > 
> > Similar comments every where you do this type of comparison.
> > 
> > Cheers,
> > Ben.
> 
> Sorry for the nag, but am I missing something about the way the register and
> the previous values are reset in the overflow interrupt handler?

Well, not all counters get interrupts right ? Some counters are just
free running... I'm not sure when that power_pmu_read() function is
actually used by the core, I'm not that familiar with perf, but I'd say
better safe than sorry. When comparing counter values, doing in a way
that is generally safe vs. wraparounds. Eventually do a helper for that.

Cheers,
Ben.
