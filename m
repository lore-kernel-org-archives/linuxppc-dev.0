Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DF11DDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 08:06:39 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<yq0iqwxrwuh.fsf@jaguar.mkp.net>
Date: Thu, 29 May 2008 15:06:35 -0700
In-Reply-To: <yq0iqwxrwuh.fsf@jaguar.mkp.net> (Jes Sorensen's message of "29
	May 2008 10:47:18 -0400")
Message-ID: <adawslcojdg.fsf@cisco.com>
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

 > The problem is that your two writel's, despite being both issued on
 > cpu X, due to the spin lock, in your example, can end up with the
 > first one going through NR 1 and the second one going through NR 2. If
 > there's contention on NR 1, the write going via NR 2 may hit the PCI
 > bridge prior to the one going via NR 1.

Really??  I can't see how you can expect any drivers to work reliably if
simple code like

	writel(reg1);
	writel(reg2);

might end up with the write to reg2 hitting the device before the write
to reg1.  Almost all MMIO stuff has ordering requirements and will
totally break if you allow, say, the "start IO" write to be reordered
before the "set IO address" write.

 - R.
