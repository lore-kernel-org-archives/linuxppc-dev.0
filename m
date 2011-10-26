Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6F549B6F7F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 14:16:52 +1100 (EST)
Received: from mail153-tx2 (localhost.localdomain [127.0.0.1])	by
 mail153-tx2-R.bigfish.com (Postfix) with ESMTP id 0DB78BA8175	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 03:16:44 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.244])	by
 mail153-tx2.bigfish.com (Postfix) with ESMTP id E328C1C805A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 03:16:43 +0000 (UTC)
Subject: Re: [PATCH 1/5] powerpc/85xx: issue 15 EOI after core reset
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1319583246-6120-1-git-send-email-msm@freescale.com>
Date: Tue, 25 Oct 2011 22:16:44 -0500
Message-ID: <08F58B37-0825-4C07-91B3-1040A7E70528@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 25, 2011, at 5:54 PM, Matthew McClintock wrote:

> This is listed as a requirement after issuing a core reset to
> properly clear pending interrupts
>=20

Fix comment message to be more clear on 'what' this is required. [ its a =
requirement on FSL corenet series / MPIC v4.x ]

> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/sysdev/mpic.c |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 9678081..f5b83f0 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1748,6 +1748,7 @@ void mpic_reset_core(int cpu)
> 	struct mpic *mpic =3D mpic_primary;
> 	u32 pir;
> 	int cpuid =3D get_hard_smp_processor_id(cpu);
> +	int i;
>=20
> 	/* Set target bit for core reset */
> 	pir =3D mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
> @@ -1759,6 +1760,12 @@ void mpic_reset_core(int cpu)
> 	pir &=3D ~(1 << cpuid);
> 	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
> 	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
> +
> +	/* Perform 15 EOI on each reset core to clear pending interrupts =
*/
> +	for (i =3D 0; i < 15; i++) {
> +		_mpic_write(mpic->reg_type, &mpic->cpuregs[cpuid],
> +				      MPIC_CPU_EOI, 0);
> +	}
> }
> #endif /* CONFIG_SMP */
>=20
> --=20
> 1.7.6.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
