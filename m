Return-Path: <SRS0+8dd218c1a5062aad74f4+1208+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82AAB67D77
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 04:37:07 +1100 (EST)
Date: Thu, 14 Dec 2006 17:36:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 12/14] Spidernet Avoid possible RX chain corruption
Message-ID: <20061214173649.GB3452@infradead.org>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213212301.GL1915@austin.ibm.com>
	<1166055763.6838.5.camel@concordia.ozlabs.ibm.com>
	<20061214171511.GT4329@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061214171511.GT4329@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 14, 2006 at 11:15:11AM -0600, Linas Vepstas wrote:
> On Thu, Dec 14, 2006 at 11:22:43AM +1100, Michael Ellerman wrote:
> > >  	spider_net_refill_rx_chain(card);
> > > -	spider_net_enable_rxchtails(card);
> > >  	spider_net_enable_rxdmac(card);
> > >  	return 0;
> > 
> > Didn't you just add that line?
> 
> Dagnabbit. The earlier pach was moving around existing code.
> Or, more precisely, trying to maintain the general function
> of the old code even while moving things around.
> 
> Later on, when I started looking at what the danged function 
> actually did, and the context it was in, I realized that it 
> was a bad idea to call the thing.  So then I removed it. :-/
> 
> How should I handle this proceedurally? Resend the patch sequence? 
> Let it slide?

Just keep it as is in this case.  In case you have to redo the patch
series for some other reason or for similar cases in the future put
the patch to remove things in front of the one that reorders the surrounding
bits.
