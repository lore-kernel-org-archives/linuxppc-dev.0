Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY5hc4Q2jzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 22:52:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Corentin Labbe <clabbe.montjoie@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] powerpc: powernv: Fix build error on const discarding
In-Reply-To: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
References: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
Date: Thu, 17 Aug 2017 22:52:11 +1000
Message-ID: <87fucqbblw.fsf@concordia.ellerman.id.au>
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

Corentin Labbe <clabbe.montjoie@gmail.com> writes:

> When building a random powerpc kernel I hit this build error:
>   CC      arch/powerpc/platforms/powernv/opal-imc.o
> arch/powerpc/platforms/powernv/opal-imc.c: In function =C2=AB=C2=A0disabl=
e_nest_pmu_counters=C2=A0=C2=BB:
> arch/powerpc/platforms/powernv/opal-imc.c:130:13: error=C2=A0: assignment=
 discards =C2=AB=C2=A0const=C2=A0=C2=BB qualifier from pointer target type =
[-Werror=3Ddiscarded-qualifiers]
>    l_cpumask =3D cpumask_of_node(nid);
>              ^
> This patch simply add const to l_cpumask to fix this issue.

Thanks. I'm not sure why we haven't seen that.

Do you mind attaching your .config ?

cheers
