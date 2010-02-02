Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5AD7B7D44
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 19:19:51 +1100 (EST)
Date: Tue, 2 Feb 2010 09:19:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/7] powerpc: Reduce footprint of irq_stat
Message-ID: <20100202081940.GA7552@lst.de>
References: <20100201063023.GT2996@kryten> <20100201215504.GA17194@lst.de>
	<1265065630.8287.46.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265065630.8287.46.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 02, 2010 at 10:07:10AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-02-01 at 22:55 +0100, Christoph Hellwig wrote:
> 
> > > +typedef struct {
> > > +	unsigned int __softirq_pending;
> > > +} ____cacheline_aligned irq_cpustat_t;
> > 
> > No need to bother with an irq_cpustat_t type at all in this case, just
> > declare a softirq_pending per-cpu variable.
> 
> I think his subsequent patches add members to that struct for
> CE, MCE etc... stats.

Well, if you want those in a structure for arch-local reasons please
give them an arch-local name.  I really want to get rid of the current
concept of a generic irq_cpustat_t - it doens't make much sense in
it's current form.  Instead the API will be the local_softirq_pending()
function/macro with arch specific or a generic implementation.
