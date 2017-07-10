Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5hrW1g3tzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 20:52:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv/idle: Put pnv_cpu_offline behind
 HOTPLUG_CPU
In-Reply-To: <20170703040152.5144-1-joel@jms.id.au>
References: <20170703040152.5144-1-joel@jms.id.au>
Date: Mon, 10 Jul 2017 20:52:58 +1000
Message-ID: <878tjwva0l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> writes:
> In commit 900612315788 ("powerpc/powernv/smp: Add busy-wait loop as fall =
back
> for CPU-Hotplug") the idle code uses generic_check_cpu_restart(), but that
> function is not available when CONFIG_HOTPLUG_CPU is disabled.
>
> arch/powerpc/platforms/powernv/idle.c: In function =E2=80=98pnv_cpu_offli=
ne=E2=80=99:
> arch/powerpc/platforms/powernv/idle.c:286:11: error: implicit declaration=
 of
> function =E2=80=98generic_check_cpu_restart=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
>    while (!generic_check_cpu_restart(cpu)) {
>            ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> The callers of pnv_cpu_offline are behind CONFIG_HOTPLUG_CPU, so fix the =
build
> error by putting this code behind the same gard.
>
> Fixes: 900612315788 ("powerpc/powernv/smp: Add busy-wait loop as fall bac=
k for CPU-Hotplug").
> Cc: <stable@vger.kernel.org> # 4.12
> Signed-off-by: Joel Stanley <joel@jms.id.au>

This was fixed upstream in commit 67d204180886, but I forgot to tag it
for stable.

https://git.kernel.org/torvalds/c/67d204180886


I've just sent mail to stable asking for it to be backported to 4.12.

cheers
