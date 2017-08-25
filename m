Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdk5l3kkbzDrJx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 11:26:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, anju@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: powernv: Fix build error on const discarding
In-Reply-To: <20170818125816.GA15998@Red>
References: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
 <87fucqbblw.fsf@concordia.ellerman.id.au> <20170818125816.GA15998@Red>
Date: Fri, 25 Aug 2017 11:26:32 +1000
Message-ID: <87h8wwv3nb.fsf@concordia.ellerman.id.au>
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

> On Thu, Aug 17, 2017 at 10:52:11PM +1000, Michael Ellerman wrote:
>> Corentin Labbe <clabbe.montjoie@gmail.com> writes:
>>=20
>> > When building a random powerpc kernel I hit this build error:
>> >   CC      arch/powerpc/platforms/powernv/opal-imc.o
>> > arch/powerpc/platforms/powernv/opal-imc.c: In function =C2=AB=C2=A0dis=
able_nest_pmu_counters=C2=A0=C2=BB:
>> > arch/powerpc/platforms/powernv/opal-imc.c:130:13: error=C2=A0: assignm=
ent discards =C2=AB=C2=A0const=C2=A0=C2=BB qualifier from pointer target ty=
pe [-Werror=3Ddiscarded-qualifiers]
>> >    l_cpumask =3D cpumask_of_node(nid);
>> >              ^
>> > This patch simply add const to l_cpumask to fix this issue.
>>=20
>> Thanks. I'm not sure why we haven't seen that.
>>=20
>> Do you mind attaching your .config ?
>>=20
>> cheers
>
> Yes

Thanks.

So the key is:

> CONFIG_PPC_POWERNV=3Dy
...
> # CONFIG_NUMA is not set


Which none of our configs have.

I'll add a test build of that.

Thanks.

cheers
