Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57479DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 21:27:44 +1100 (EST)
Date: Tue, 17 Feb 2009 11:27:33 +0100
From: Nick Piggin <npiggin@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: next-20090216: slqb
Message-ID: <20090217102733.GB26402@wotan.suse.de>
References: <20090216172016.f1d159a7.sfr@canb.auug.org.au>
	<20090217005539.GA6292@x200.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090217005539.GA6292@x200.localdomain>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 17, 2009 at 03:55:40AM +0300, Alexey Dobriyan wrote:
> FYI, on powerpc-64-smp-n-debug-n:
> 
> mm/slqb.c: In function '__slab_free':
> mm/slqb.c:1648: error: implicit declaration of function 'slab_free_to_remote'
> mm/slqb.c: In function 'kmem_cache_open':
> mm/slqb.c:2174: error: implicit declaration of function 'kmem_cache_dyn_array_free'
> mm/slqb.c:2175: warning: label 'error_cpu_array' defined but not used
> mm/slqb.c: In function 'kmem_cache_destroy':
> mm/slqb.c:2294: error: implicit declaration of function 'claim_remote_free_list'
> mm/slqb.c: In function 'kmem_cache_reap_percpu':
> mm/slqb.c:2547: error: implicit declaration of function 'flush_remote_free_cache'
> mm/slqb.c: In function 'kmem_cache_init':
> mm/slqb.c:2783: error: 'per_cpu__kmem_cpu_nodes' undeclared (first use in this function)
> mm/slqb.c:2783: error: (Each undeclared identifier is reported only once
> mm/slqb.c:2783: error: for each function it appears in.)
> mm/slqb.c:2784: error: 'kmem_cpu_cache' undeclared (first use in this function)

Hmm, I guess this (SMP=n && NUMA=y) must be a valid config on ppc if
SLQB is the only one tripping on it, so I'll look at code to fix tihs
up.

Thanks,
Nick
