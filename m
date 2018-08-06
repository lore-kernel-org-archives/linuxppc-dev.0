Return-Path: <srs0=douz=kv=nxp.com=diana.craciun@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kdlL58t5zF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 23:28:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41kdlL1FbQz8tD9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 23:28:46 +1000 (AEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0081.outbound.protection.outlook.com [104.47.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41kdlH0WKzz9s4V
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2018 23:28:39 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
CC: "oss@buserror.net" <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>, Bharat
 Bhushan <bharat.bhushan@nxp.com>
Subject: Re: [PATCH v5 0/8] powerpc/fsl: Speculation barrier for NXP PowerPC
 Book3E
Date: Mon, 6 Aug 2018 13:28:35 +0000
Message-ID: <VI1PR0401MB2463CD1A5B37947DAC5FB33DFF200@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20180727230639.25413-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,=0A=
=0A=
Sorry for the late answer, I was out of the office last week.=0A=
=0A=
It looks fine to me, I have tested the patches on NXP PowerPC Book 3E=0A=
platforms and it worked well.=0A=
=0A=
Thanks,=0A=
=0A=
Diana=0A=
=0A=
On 7/28/2018 2:06 AM, Michael Ellerman wrote:=0A=
> Implement barrier_nospec for NXP PowerPC Book3E processors.=0A=
>=0A=
> Hi Diana,=0A=
>=0A=
> This series interacts with another series of mine, so I wanted to rework =
it=0A=
> slightly. Let me know if this looks OK to you.=0A=
>=0A=
> cheers=0A=
>=0A=
> Diana Craciun (6):=0A=
>   powerpc/64: Disable the speculation barrier from the command line=0A=
>   powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.=0A=
>   powerpc/64: Make meltdown reporting Book3S 64 specific=0A=
>   powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E=
=0A=
>   powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit=0A=
>     platforms=0A=
>   Documentation: Add nospectre_v1 parameter=0A=
>=0A=
> Michael Ellerman (2):=0A=
>   powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC=0A=
>   powerpc/64: Call setup_barrier_nospec() from setup_arch()=0A=
>=0A=
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++=0A=
>  arch/powerpc/Kconfig                            |  7 ++++-=0A=
>  arch/powerpc/include/asm/barrier.h              | 12 ++++++---=0A=
>  arch/powerpc/include/asm/setup.h                |  6 ++++-=0A=
>  arch/powerpc/kernel/Makefile                    |  3 ++-=0A=
>  arch/powerpc/kernel/entry_32.S                  | 10 +++++++=0A=
>  arch/powerpc/kernel/module.c                    |  4 ++-=0A=
>  arch/powerpc/kernel/security.c                  | 17 +++++++++++-=0A=
>  arch/powerpc/kernel/setup-common.c              |  2 ++=0A=
>  arch/powerpc/kernel/vmlinux.lds.S               |  4 ++-=0A=
>  arch/powerpc/lib/feature-fixups.c               | 35 +++++++++++++++++++=
+++++-=0A=
>  arch/powerpc/platforms/powernv/setup.c          |  1 -=0A=
>  arch/powerpc/platforms/pseries/setup.c          |  1 -=0A=
>  13 files changed, 94 insertions(+), 12 deletions(-)=0A=
>=0A=
=0A=
