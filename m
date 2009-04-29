Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1303DDEF2
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 21:36:15 +1000 (EST)
Date: Wed, 29 Apr 2009 13:36:05 +0200
From: Nick Piggin <npiggin@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
Message-ID: <20090429113604.GE3398@wotan.suse.de>
References: <20090428165343.2e357d7a.sfr@canb.auug.org.au>
	<49F6E421.401@in.ibm.com>
	<84144f020904280422s6a9a277fjc4619c904f37e5ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84144f020904280422s6a9a277fjc4619c904f37e5ca@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 02:22:06PM +0300, Pekka Enberg wrote:
> Nick,
> 
> Here's another one. I think we need to either fix these rather quickly
> or make SLUB the defaut for linux-next again so we don't interfere
> with other testing.
> 
>                                      Pekka
> 
> On Tue, Apr 28, 2009 at 2:10 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
> > Today's next tree fails to boot on variety of powerpc boxes (Power5, power6)
> >
> > Memory: 3882624k/4194304k available (8384k kernel code, 311680k reserved,
> > 2048k data, 4285k bss, 512k init)
> > Kernel panic - not syncing: kmem_cache_create(): failed to create slab
> > `kmalloc'
> >
> > Call Trace:
> > [c000000000a33c30] [c000000000011668] .show_stack+0x6c/0x16c (unreliable)
> > [c000000000a33ce0] [c000000000563c8c] .panic+0x80/0x1a8
> > [c000000000a33d70] [c0000000001410d8] .kmem_cache_open+0x4e8/0x51c
> > [c000000000a33e20] [c0000000007d90b8] .kmem_cache_init+0x264/0x35c
> > [c000000000a33ee0] [c0000000007b0b68] .start_kernel+0x404/0x51c
> > [c000000000a33f90] [c0000000000083d8] .start_here_common+0x1c/0x44

OK I think the problem is that with 64K pages you get a default MAX_ORDER
of 9, and slqb is trying to create slabs which exceed that size..

Does this help?
---

SLQB: fix slab calculation

SLQB didn't consider MAX_ORDER when defining which sizes of kmalloc
slabs to create. It panics at boot if it tries to create a cache
which exceeds MAX_ORDER-1.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/include/linux/slqb_def.h
===================================================================
--- linux-2.6.orig/include/linux/slqb_def.h	2009-04-29 21:27:30.000000000 +1000
+++ linux-2.6/include/linux/slqb_def.h	2009-04-29 21:28:13.000000000 +1000
@@ -172,7 +172,8 @@ struct kmem_cache {
 #endif
 
 #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
-#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 9)
+#define KMALLOC_SHIFT_SLQB_HIGH ((PAGE_SHIFT + 9) < MAX_ORDER ? \
+				(PAGE_SHIFT + 9) : (MAX_ORDER - 1))
 
 extern struct kmem_cache kmalloc_caches[KMALLOC_SHIFT_SLQB_HIGH + 1];
 extern struct kmem_cache kmalloc_caches_dma[KMALLOC_SHIFT_SLQB_HIGH + 1];
