Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9XGs2JrlzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:39:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
In-Reply-To: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
Date: Fri, 12 Aug 2016 14:39:32 +1000
Message-ID: <87k2fmtxbv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kevin Hao <haokexin@gmail.com> writes:

> With the commit 44a7185c2ae6 ("of/platform: Add common method to
> populate default bus"), a default function is introduced to populate
> the default bus and this function is invoked at the arch_initcall_sync
> level. This will override the arch specific population of default bus
> which run at a lower level than arch_initcall_sync. Since not all
> powerpc specific buses are added to the of_default_bus_match_table[],
> this causes some powerpc specific bus are not probed. Fix this by
> using a more preceding initcall.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> Of course we can adjust the powerpc arch codes to use the
> of_platform_default_populate_init(), but it has high risk to break
> other boards given the complicated powerpc specific buses. So I would
> like just to fix the broken boards in the current release, and cook 
> a patch to change to of_platform_default_populate_init() for linux-next.
>
> Only boot test on a mpc8315erdb board.
>
>  arch/powerpc/platforms/40x/ep405.c               | 2 +-
>  arch/powerpc/platforms/40x/ppc40x_simple.c       | 2 +-
>  arch/powerpc/platforms/40x/virtex.c              | 2 +-
>  arch/powerpc/platforms/40x/walnut.c              | 2 +-
>  arch/powerpc/platforms/44x/canyonlands.c         | 2 +-
>  arch/powerpc/platforms/44x/ebony.c               | 2 +-
>  arch/powerpc/platforms/44x/iss4xx.c              | 2 +-
>  arch/powerpc/platforms/44x/ppc44x_simple.c       | 2 +-
>  arch/powerpc/platforms/44x/ppc476.c              | 2 +-
>  arch/powerpc/platforms/44x/sam440ep.c            | 2 +-
>  arch/powerpc/platforms/44x/virtex.c              | 2 +-
>  arch/powerpc/platforms/44x/warp.c                | 2 +-
>  arch/powerpc/platforms/82xx/ep8248e.c            | 2 +-
>  arch/powerpc/platforms/82xx/km82xx.c             | 2 +-
>  arch/powerpc/platforms/82xx/mpc8272_ads.c        | 2 +-
>  arch/powerpc/platforms/82xx/pq2fads.c            | 2 +-
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c        | 2 +-
>  arch/powerpc/platforms/83xx/mpc834x_itx.c        | 2 +-
>  arch/powerpc/platforms/85xx/ppa8548.c            | 2 +-
>  arch/powerpc/platforms/8xx/adder875.c            | 2 +-
>  arch/powerpc/platforms/8xx/ep88xc.c              | 2 +-
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c     | 2 +-
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c     | 2 +-
>  arch/powerpc/platforms/8xx/tqm8xx_setup.c        | 2 +-
>  arch/powerpc/platforms/cell/setup.c              | 2 +-
>  arch/powerpc/platforms/embedded6xx/gamecube.c    | 2 +-
>  arch/powerpc/platforms/embedded6xx/linkstation.c | 2 +-
>  arch/powerpc/platforms/embedded6xx/mvme5100.c    | 2 +-
>  arch/powerpc/platforms/embedded6xx/storcenter.c  | 2 +-
>  arch/powerpc/platforms/embedded6xx/wii.c         | 2 +-
>  arch/powerpc/platforms/pasemi/setup.c            | 2 +-

That's not a very minimal fix.

Every one of those initcall changes could be introducing a bug, by
changing the order vs other init calls.

Can we just go back to the old behaviour on ppc?

cheers
