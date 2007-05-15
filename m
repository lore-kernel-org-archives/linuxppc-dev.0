Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 920CADDEFF
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 05:28:52 +1000 (EST)
Date: Tue, 15 May 2007 21:29:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
Message-ID: <20070515192946.GA22476@uranus.ravnborg.org>
References: <3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
	<989B956029373F45A0B8AF0297081890B76041@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <989B956029373F45A0B8AF0297081890B76041@zch01exm26.fsl.freescale.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus <torvalds@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 05:36:40PM +0800, Li Yang-r58472 wrote:
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Monday, May 14, 2007 9:57 PM
> > To: Sam Ravnborg
> > Cc: Li Yang-r58472; Linus; Andrew Morton; Linux Kernel;
> linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning
> whitelist for
> > powerpc
> > 
> > 
> > On May 14, 2007, at 6:06 AM, Sam Ravnborg wrote:
> > 
> > > On Mon, May 14, 2007 at 06:53:32PM +0800, Li Yang wrote:
> > >> This patch fixes the following "Section mismatch" warnings when
> > >> build powerpc platforms.
> > >>
> > >> -------------
> > >> WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference
> to
> > >> .init.text:early_get_page from .text between
> > >> 'pte_alloc_one_kernel' (at
> > >> offset 0xc68) and 'pte_alloc_one'
> > >> WARNING: mm/built-in.o - Section mismatch: reference to
> > >> .init.text:set_up_list3s from .text between
> > >> 'kmem_cache_create' (at offset
> > >> 0x20300) and 'cache_reap'
> > >> -------------
> > 
> > This warnings should be handled by __init_refok instead.
> 
> Yes.  When __init_refok gets in, we can change all Pattern 9 members in
> the whitelist to use __init_refok.

I have applied the patch without the fixes for the above functions.
Will merge and push the __init_refok changes soonish.

	Sam
