Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E40B1A0795
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 10:47:36 +1000 (AEST)
Message-ID: <1441846056.31931.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/book3s32: Only select PPC_HAVE_PMU on e600
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: christophe leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Joakim
 Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 10 Sep 2015 10:47:36 +1000
In-Reply-To: <1441837481.2623.6.camel@freescale.com>
References: <20150903092704.2F4881A241D@localhost.localdomain>
 <20150904164349.GA10337@home.buserror.net> <55E9DC5B.4090506@c-s.fr>
 <1441837481.2623.6.camel@freescale.com>
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

On Wed, 2015-09-09 at 17:24 -0500, Scott Wood wrote:
> On Fri, 2015-09-04 at 20:00 +0200, christophe leroy wrote:
> > Le 04/09/2015 18:43, Scott Wood a écrit :
> > > On Thu, Sep 03, 2015 at 11:27:03AM +0200, Christophe Leroy wrote:
> > > > On PPC832x, perf record/report reports martian addresses
> > > > 
> > > >       2.62%  perf_reseau4  libpthread-2.18.so  [.] __libc_send
> > > >       2.56%  perf_reseau4  [kernel.kallsyms]   [k] __ip_make_skb
> > > >       1.62%  perf_reseau4  [kernel.kallsyms]   [k] 
> > > > __ip_append_data.isra.39
> > > >       1.55%  perf_reseau4  [kernel.kallsyms]   [k] ip_finish_output
> > > >       1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd94
> > > >       1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd95
> > > >       1.28%  perf_reseau4  [unknown]           [k] 0x7ffffd97
> > > >       1.26%  perf_reseau4  [unknown]           [k] 0x7ffffda3
> > > >       1.24%  perf_reseau4  [unknown]           [k] 0x7ffffd98
> > > >       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd92
> > > >       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd9b
> > > >       [.....]
> > > > 
> > > > This is due to function perf_instruction_pointer() reading SPR SIAR
> > > > which doesn't exist on e300 core. The perf_instruction_pointer() is
> > > > redefined in arch/powerpc/perf/core-book3s.c when CONFIG_PPC_PERF_CTRS
> > > > is selected.
> > > > 
> > > > This patch moves the selection of CONFIG_PPC_HAVE_PMU in 86xx section
> > > > so that CONFIG_PPC_PERF_CTRS won't be selected for other 6xx powerpc
> > > > 
> > > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > So, what happens when a kernel is built that supports both 83xx and 86xx?
> > Right, so should we define a processor feature for it ?
> 
> There aren't many CPU feature flags left (without changing the mechanism to 
> make more available), and runtime patching shouldn't be necessary.  Instead, 
> use the existing oprofile_type field.  

Yep, +1. Only add new cpu feature flags if you really need them please.

> BTW, I don't know why we have pmc_type in addition to that -- the hardware
> only needs to be described once, regardless of how many subsystems care about
> it.

Right, I think that's all just accreted over the years, and predates perf. We
could probably consolidate some of it.

cheers
