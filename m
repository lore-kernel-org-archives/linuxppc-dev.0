Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-4.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 934D4DE218
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 03:49:22 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211906268.3435.44.camel@localhost.localdomain>
Date: Tue, 27 May 2008 10:38:56 -0700
In-Reply-To: <1211906268.3435.44.camel@localhost.localdomain> (James
	Bottomley's message of "Tue, 27 May 2008 11:37:48 -0500")
Message-ID: <adad4n71wb3.fsf@cisco.com>
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

 > Actually, this specifically should not be.  The need for mmiowb on altix
 > is because it explicitly violates some of the PCI rules that would
 > otherwise impede performance.   The compromise is that readX on altix
 > contains the needed dma flush but there's a variant operator,
 > readX_relaxed that doesn't (for drivers that know what they're doing).
 > The altix critical drivers have all been converted to use the relaxed
 > form for performance, and the unconverted ones should all operate just
 > fine (albeit potentially more slowly).

Is this a recent change?  Because as of October 2007, 76d7cc03
("IB/mthca: Use mmiowb() to avoid firmware commands getting jumbled up")
was needed.  But this was involving writel() (__raw_writel() actually,
looking at the code), not readl().  But writel_relaxed() doesn't exist
(and doesn't make sense).

 - R.
