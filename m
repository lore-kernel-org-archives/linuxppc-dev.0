Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B194AB7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 10:07:16 +1100 (EST)
Subject: Re: [PATCH 1/7] powerpc: Reduce footprint of irq_stat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20100201215504.GA17194@lst.de>
References: <20100201063023.GT2996@kryten>  <20100201215504.GA17194@lst.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Feb 2010 10:07:10 +1100
Message-ID: <1265065630.8287.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-01 at 22:55 +0100, Christoph Hellwig wrote:

> > +typedef struct {
> > +	unsigned int __softirq_pending;
> > +} ____cacheline_aligned irq_cpustat_t;
> 
> No need to bother with an irq_cpustat_t type at all in this case, just
> declare a softirq_pending per-cpu variable.

I think his subsequent patches add members to that struct for
CE, MCE etc... stats.

Cheers,
Ben.
