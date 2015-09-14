Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 250C61A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 19:36:50 +1000 (AEST)
Message-ID: <1442223409.21802.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: msi: mark bitmap with kmemleak_not_leak()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 14 Sep 2015 19:36:49 +1000
In-Reply-To: <20150914091529.GC22991@e104818-lin.cambridge.arm.com>
References: <1442169397-4271-1-git-send-email-kda@linux-powerpc.org>
 <1442210677.8149.1.camel@ellerman.id.au>
 <20150914091529.GC22991@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-14 at 10:15 +0100, Catalin Marinas wrote:
> On Mon, Sep 14, 2015 at 04:04:37PM +1000, Michael Ellerman wrote:
> > On Sun, 2015-09-13 at 21:36 +0300, Denis Kirjanov wrote:
> > > The comment in msi_bitmap_free() states that we can't free
> > > the bitmap so mark it with the kmemleak_not_leak().
> > 
> > Yeah, and I've always hated that comment :)
> > 
> > I assume it's still true now that we don't use bootmem?
> 
> If it's not bootmem, it's probably memblock. Looking at the code, it
> seems that msi_bitmap_free() cannot make the distinction between a slab
> allocation and a bootmem/memblock one (allocated via
> zalloc_maybe_bootmem).

Yeah it is memblock these days.

> You could add some flag to struct msi_bitmap based on mem_init_done to
> be able to reclaim some slab memory later. If the bitmap is small and
> such allocation doesn't happen outside boot, it may not be worth the
> effort.

Right, I think that's the only solution, and it's not quite worth the trouble
because it's generally not freed at all, except via error paths.

Still I think it would be better to move the kmemleak annotation into the msi
bitmap test code, or maybe a wrapper that's called by the test code.

That way if someone starts calling alloc/free from a hotplug path for example,
kmemleak will still notice that free isn't really freeing.

cheers
