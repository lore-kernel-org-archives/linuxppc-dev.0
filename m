Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 524921A0E3D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:24:52 +1100 (AEDT)
Message-ID: <1421987091.24984.13.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] mm: fix undefined reference to `.kernel_map_pages'
 on PPC builds
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kim Phillips <kim.phillips@freescale.com>
Date: Fri, 23 Jan 2015 15:24:51 +1100
In-Reply-To: <20150122212017.4b7032d52a6c75c06d5b4728@freescale.com>
References: <20150120140200.aa7ba0eb28d95e456972e178@freescale.com>
 <20150120230150.GA14475@cloud>
 <20150120160738.edfe64806cc8b943beb1dfa0@linux-foundation.org>
 <CAC5umyieZn7ppXkKb45O=C=BF+iv6R_A1Dwfhro=cBJzFeovrA@mail.gmail.com>
 <20150122014550.GA21444@js1304-P5Q-DELUXE>
 <20150122144147.019eedc41f189eac44c3c4cd@freescale.com>
 <CAC5umyiF52cykH2_5TD0yzXb+842gywpe-+XZHEwmrDe0nYCPw@mail.gmail.com>
 <20150122212017.4b7032d52a6c75c06d5b4728@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
 Rik van Riel <riel@redhat.com>, josh@joshtriplett.org,
 Minchan Kim <minchan@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
 Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-22 at 21:20 -0600, Kim Phillips wrote:
> On Fri, 23 Jan 2015 08:49:36 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > 2015-01-23 5:41 GMT+09:00 Kim Phillips <kim.phillips@freescale.com>:
> > > Thanks. Now I get this:
> > >
> > >   LD      init/built-in.o
> > > mm/built-in.o: In function `kernel_map_pages':
> > > include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
> > > include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
> > > include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
> > > Makefile:925: recipe for target 'vmlinux' failed
> > > make: *** [vmlinux] Error 1
> > >
> > > but, AFAICT, that's not because this patch is invalid: it's because
> > > __kernel_map_pages() isn't implemented in
> > > arch/powerpc/mm/pgtable_64.c, i.e., for non-PPC_STD_MMU_64 PPC64
> > > machines.
> > 
> > Then, in order to use generic __kernel_map_pages() in mm/debug-pagealloc.c,
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC shouldn't be selected in
> > arch/powerpc/Kconfig, when CONFIG_PPC_STD_MMU_64 isn't defined.
> 
> Thanks.  I'm still build-testing this now:
> 
> From 082911ee947246ff962ef21863c45ec467455c40 Mon Sep 17 00:00:00 2001
> From: Kim Phillips <kim.phillips@freescale.com>
> Date: Thu, 22 Jan 2015 20:42:40 -0600
> Subject: [PATCH v2] mm: fix undefined reference to  `.__kernel_map_pages' on FSL
>  PPC64
> 
> arch/powerpc has __kernel_map_pages implementations in mm/pgtable_32.c, and
> mm/hash_utils_64.c, of which the former is built for PPC32, and the latter
> PPC64's without PPC_STD_MMU.

That last part is wrong.

hash_utils_64.c is built for CONFIG_PPC_STD_MMU_64, which is:

config PPC_STD_MMU_64
	def_bool y
	depends on PPC_STD_MMU && PPC64

The problem is when you have PPC64 && !PPC_STD_MMU.

cheers
