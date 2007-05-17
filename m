Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 53D60DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 10:40:55 +1000 (EST)
Date: Wed, 16 May 2007 17:41:01 -0700 (PDT)
Message-Id: <20070516.174101.45179259.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: RT patches expose netdev race [was Re: [RFC] [patch 2/2]
	powerpc 2.6.21-rt1: fix kernel hang and/or panic
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070517001801.GB4325@austin.ibm.com>
References: <yyiirau5v8g.wl@toshiba.co.jp>
	<1179223742.32247.184.camel@localhost.localdomain>
	<20070517001801.GB4325@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, mingo@elte.hu,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Wed, 16 May 2007 19:18:02 -0500

> Hi,
> 
> On Tue, May 15, 2007 at 08:09:02PM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2007-05-15 at 17:47 +0900, Tsutomu OWA wrote:
> > >   I encountered the following error when doing netperf from other machine 
> > > to Celleb running RT kernel.  PREEPT_NONE kernel works just fine as well.
> > 
> > Hrm... sounds a bit weird. I wonder if there's a locking bug in the
> > driver in the first place.
> > 
> > Linas, what's your take ?
> 
> Heh. I almost deleted the entire email thread cause it
> didn't say "spidernet" in the subject line. :-)
> Seriously, I really almost did ....
> 
> Since this is a long email; let me put a summary up front:
> I think the RT/premption patches are exposing some sort
> of race in the ip header handling code. The rest of the 
> note is forensics pointing to this.

skb->head should never ever be NULL.
