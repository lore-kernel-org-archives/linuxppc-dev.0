Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPFc15BJRzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 11:19:29 +1100 (AEDT)
Message-ID: <1458001168.8059.3.camel@ellerman.id.au>
Subject: Re: Pull request: scottwood/linux.git next
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Date: Tue, 15 Mar 2016 11:19:28 +1100
In-Reply-To: <20160312031535.GA24351@home.buserror.net>
References: <20160312031535.GA24351@home.buserror.net>
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

On Fri, 2016-03-11 at 21:15 -0600, Scott Wood wrote:

> Highlights include 8xx optimizations, 32-bit checksum optimizations, 86xx
> consolidation, e5500/e6500 cpu hotplug, more fman and other dt bits, and
> minor fixes/cleanup.

Hi Scott,

This one's giving me a few troubles.

> chenhui zhao (6):
>       powerpc/mm: any thread in one core can be the first to setup TLB1
>       powerpc/cache: add cache flush operation for various e500
>       powerpc/rcpm: add RCPM driver

That commit doesn't build with SMP=n, as reported by Guenter:

  arch/powerpc/sysdev/fsl_rcpm.c:32:2: error: implicit declaration of function 'get_hard_smp_processor_id' [-Werror=implicit-function-declaration]

That's not a biggy, I can probably fix it up here.

>       powerpc/mpc85xx: Add CPU hotplug support for E6500

And this one breaks with old binutils (<= 2.22) because of:

  arch/powerpc/kernel/head_64.S:210: Error: Unrecognized opcode: `mttmr'

If you're happy to break the build on older bintuils for those configs then
that's OK with me.

> Christophe Leroy (31):
>       powerpc/8xx: Handle CPU6 ERRATA directly in mtspr() macro

This breaks mpc866_ads_defconfig for me, with lots of:

  arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly addressable

That's using gcc < 4.9. With >= 4.9 it builds OK. So again your call on whether
we drop support for those compilers for that config.

cheers
