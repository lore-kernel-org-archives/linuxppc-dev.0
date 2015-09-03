Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C88991A1F46
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 19:47:30 +1000 (AEST)
Message-ID: <1441273649.26379.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/book3s32: Only select PPC_HAVE_PMU on e600
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, scottwood@freescale.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Joakim Tjernlund
 <joakim.tjernlund@transmode.se>
Date: Thu, 03 Sep 2015 19:47:29 +1000
In-Reply-To: <20150903092704.2F4881A241D@localhost.localdomain>
References: <20150903092704.2F4881A241D@localhost.localdomain>
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

On Thu, 2015-09-03 at 11:27 +0200, Christophe Leroy wrote:
> On PPC832x, perf record/report reports martian addresses
> 
>      2.62%  perf_reseau4  libpthread-2.18.so  [.] __libc_send
>      2.56%  perf_reseau4  [kernel.kallsyms]   [k] __ip_make_skb
>      1.62%  perf_reseau4  [kernel.kallsyms]   [k] __ip_append_data.isra.39
>      1.55%  perf_reseau4  [kernel.kallsyms]   [k] ip_finish_output
>      1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd94
>      1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd95
>      1.28%  perf_reseau4  [unknown]           [k] 0x7ffffd97
>      1.26%  perf_reseau4  [unknown]           [k] 0x7ffffda3
>      1.24%  perf_reseau4  [unknown]           [k] 0x7ffffd98
>      1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd92
>      1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd9b
>      [.....]
> 
> This is due to function perf_instruction_pointer() reading SPR SIAR
> which doesn't exist on e300 core. The perf_instruction_pointer() is
> redefined in arch/powerpc/perf/core-book3s.c when CONFIG_PPC_PERF_CTRS
> is selected.
> 
> This patch moves the selection of CONFIG_PPC_HAVE_PMU in 86xx section
> so that CONFIG_PPC_PERF_CTRS won't be selected for other 6xx powerpc

I don't know much about these old 6xx cpus, deferring to Paul.

cheers
