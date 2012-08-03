Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8AEA82C034D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 23:17:24 +1000 (EST)
Subject: Re: [PATCH 2/4] powerpc/booke: Merge the 32 bit e5500/e500mc cpu
 setup code.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341838701-17089-1-git-send-email-Varun.Sethi@freescale.com>
Date: Fri, 3 Aug 2012 11:34:28 -0500
Message-Id: <27CB83E1-41F1-40E3-80A3-95D5B96D88B6@kernel.crashing.org>
References: <1341838701-17089-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2012, at 7:58 AM, Varun Sethi wrote:

> Merge the 32 bit cpu setup code for e500mc/e5500 and define the =
"cpu_restore"
> routine (for e5500/e6500) only for the 64 bit case. The cpu_restore =
routine
> is used in the 64 bit case for setting up the secondary cores.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    1 +
> arch/powerpc/kernel/cputable.c            |    4 ++++
> 2 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S =
b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index a55d028..5e87737 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -75,6 +75,7 @@ _GLOBAL(__setup_cpu_e500v2)
> 	mtlr	r4
> 	blr
> _GLOBAL(__setup_cpu_e500mc)
> +_GLOBAL(__setup_cpu_e5500)

This is a bit confusing, as we now have duplicated __setup_cpu_e5500() =
between the ppc32 and ppc64 cases.

If you build this patch for corenet32_smp_defconfig it fails.

I'll fixup and add the proper #ifdef's to handle this.
---

applied to next

- k=
