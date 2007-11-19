Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id B69BFDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 09:50:07 +1100 (EST)
Date: Mon, 19 Nov 2007 14:50:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: root <root@programming.kicks-ass.net>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
In-Reply-To: <20071117230049.GA25905@dyad>
Message-ID: <Pine.LNX.4.64.0711191449360.15054@schroedinger.engr.sgi.com>
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<20071117180946.GA14055@elte.hu> <20071117230049.GA25905@dyad>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	LKML <linux-kernel@vger.kernel.org>,
	Torsten Kaiser <just.for.lkml@googlemail.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Ingo Molnar <mingo@elte.hu>, Jan Blunck <jblunck@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 18 Nov 2007, root wrote:

> @@ -2155,6 +2155,7 @@ static struct kmem_cache_node *early_kme
>  {
>  	struct page *page;
>  	struct kmem_cache_node *n;
> +	unsigned long flags;
>  
>  	BUG_ON(kmalloc_caches->size < sizeof(struct kmem_cache_node));
>  

Well local_irq_save is a bit of an overkill. We know that interrupts are 
enabled during this phase of the boot sequence.
