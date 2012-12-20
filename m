Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 21A0B2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2012 05:41:58 +1100 (EST)
Subject: Re: [v1][PATCH 3/6] book3e/kgdb: update thread's dbcr0
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1355994510-11934-4-git-send-email-tiejun.chen@windriver.com>
Date: Thu, 20 Dec 2012 12:41:53 -0600
Message-Id: <A47C9236-0744-45BC-B25A-3DDEB05CD8A1@kernel.crashing.org>
References: <1355994510-11934-1-git-send-email-tiejun.chen@windriver.com>
 <1355994510-11934-4-git-send-email-tiejun.chen@windriver.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 20, 2012, at 3:08 AM, Tiejun Chen wrote:

> gdb always need to generate a single step properly to invoke
> a kgdb state. But with lazy interrupt, book3e can't always
> trigger a debug exception with a single step since the current
> is blocked for handling those pending exception, then we miss
> that expected dbcr configuration at last to generate a debug
> exception.
>=20
> So here we also update thread's dbcr0 to make sure the current
> can go back with that missed dbcr0 configuration.
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
> arch/powerpc/kernel/kgdb.c |   10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index c470a40..516b44b 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -426,8 +426,18 @@ int kgdb_arch_handle_exception(int vector, int =
signo, int err_code,
> 		/* set the trace bit if we're stepping */
> 		if (remcom_in_buffer[0] =3D=3D 's') {
> #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> +#ifdef CONFIG_PPC_BOOK3E

Should this really be CONFIG_PPC64 or CONFIG_PPC_BOOK3E_64?

> +			/* With lazy interrut we have to update thread =
dbcr0 here
> +			 * to make sure we can set debug properly at =
last to invoke
> +			 * kgdb again to work well.
> +			 */
> +			current->thread.dbcr0 =3D
> +				mfspr(SPRN_DBCR0) | DBCR0_IC | =
DBCR0_IDM;
> +			mtspr(SPRN_DBCR0, current->thread.dbcr0);
> +#else
> 			mtspr(SPRN_DBCR0,
> 			      mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> +#endif

Can we code this so we don't need the #else?

> 			linux_regs->msr |=3D MSR_DE;
> #else
> 			linux_regs->msr |=3D MSR_SE;
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
