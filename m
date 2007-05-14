Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5835EDDD09
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 05:31:40 +1000 (EST)
Date: Mon, 14 May 2007 12:30:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist
	for powerpc
Message-Id: <20070514123046.d75cc170.akpm@linux-foundation.org>
In-Reply-To: <3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
References: <46483FAC.60503@freescale.com>
	<20070514110636.GB10143@uranus.ravnborg.org>
	<3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linus <torvalds@linux-foundation.org>, Li Yang <leoli@freescale.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 May 2007 08:56:52 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> On May 14, 2007, at 6:06 AM, Sam Ravnborg wrote:
> 
> > On Mon, May 14, 2007 at 06:53:32PM +0800, Li Yang wrote:
> >> This patch fixes the following "Section mismatch" warnings when
> >> build powerpc platforms.
> >>
> >> -------------
> >> WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference to
> >> .init.text:early_get_page from .text between  
> >> 'pte_alloc_one_kernel' (at
> >> offset 0xc68) and 'pte_alloc_one'
> >> WARNING: mm/built-in.o - Section mismatch: reference to
> >> .init.text:set_up_list3s from .text between  
> >> 'kmem_cache_create' (at offset
> >> 0x20300) and 'cache_reap'
> >> -------------
> 
> This warnings should be handled by __init_refok instead.
> 

Yes, I think so.

> 
> >> Massive warnings represented by:
> >> -------------
> >> WARNING: arch/powerpc/kernel/built-in.o - Section mismatch:  
> >> reference to
> >> .init.data:.got2 from prom_entry (offset 0x0)
> >> WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:  
> >> reference to
> >> .init.text:mpc8313_rdb_probe from .machine.desc after  
> >> 'mach_mpc8313_rdb'
> >> (at offset 0x4)
> >> -------------
> >>
> >> Signed-off-by: Li Yang <leoli@freescale.com>
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>

I always get confused when a git-tree-owner says "acked-by" against a patch
which falls within his tree's area.  An acked-by would mean "I'm OK with
the patch, please apply it".  But I'd have expected to see a "thanks,
applied" instead.

If it was "Andrew: please merge and send to Linus because it's urgent and I
can't be bothered setting up a git pull for it" then fine, but please be
explicit about that.
