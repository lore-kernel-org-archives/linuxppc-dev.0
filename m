Return-Path: <just.for.lkml@googlemail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id BCEADDDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 07:10:46 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so5930134pyi
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 12:10:45 -0800 (PST)
Message-ID: <64bb37e0711171210x40dd500ap31e4ea4f8535349d@mail.gmail.com>
Date: Sat, 17 Nov 2007 21:10:44 +0100
From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
In-Reply-To: <Pine.LNX.4.64.0711171128530.7986@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<20071117100507.912c5e5c.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0711171128530.7986@schroedinger.engr.sgi.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
	LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, Jan Blunck <jblunck@suse.de>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 17, 2007 8:33 PM, Christoph Lameter <clameter@sgi.com> wrote:
> On Sat, 17 Nov 2007, Andrew Morton wrote:
>
> > That's slub.  It appears that list_lock is being taken from process context
> > in one place and from softirq in another.
>
> I kicked out some weird interrupt disable code in mm that was only run during
> NUMA bootstrap.

I'm using NUMA (Opteron), so this indeed fixes it.

A kernel complied with SLUB now outputs the same message as the SLAB
one, that lockdep annotations are needed at the place where nfs hangs.

> This should fix it but isnt there some mechanism to convince lockdep that
> it is okay to do these things during bootstrap?
>
> ---
>  mm/slub.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: linux-2.6/mm/slub.c
> ===================================================================
> --- linux-2.6.orig/mm/slub.c    2007-11-17 11:31:21.044136631 -0800
> +++ linux-2.6/mm/slub.c 2007-11-17 11:32:17.364386560 -0800
> @@ -2044,7 +2044,9 @@ static struct kmem_cache_node *early_kme
>  #endif
>         init_kmem_cache_node(n);
>         atomic_long_inc(&n->nr_slabs);
> +       local_irq_disable();
>         add_partial(kmalloc_caches, page, 0);
> +       local_irq_enable();
>         return n;
>  }
>
>
>
