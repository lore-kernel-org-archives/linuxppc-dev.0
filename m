Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rlFp4CQpzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 21:57:50 +1000 (AEST)
Message-ID: <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
Subject: Re: [PATCH v2 1/4] powerpc/tm: Remove msr_tm_active()
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 16 Aug 2018 09:46:03 +1000
In-Reply-To: <1529362784-14194-1-git-send-email-leitao@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
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

On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
> Currently msr_tm_active() is a wrapper around MSR_TM_ACTIVE() if
> CONFIG_PPC_TRANSACTIONAL_MEM is set, or it is just a function that
> returns false if CONFIG_PPC_TRANSACTIONAL_MEM is not set.
>=20
> This function is not necessary, since MSR_TM_ACTIVE() just do the same,
> checking for the TS bits and does not require any TM facility.
>=20
> This patchset remove every instance of msr_tm_active() and replaced it
> by MSR_TM_ACTIVE().
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
>=20

Patch looks good... one minor nit below...

> =20
> -	if (!msr_tm_active(regs->msr) &&
> -		!current->thread.load_fp && !loadvec(current->thread))
> +	if (!current->thread.load_fp && !loadvec(current->thread)) {
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +		if (!MSR_TM_ACTIVE(regs->msr))
> +			return;

Can you make a MSR_TM_ACTIVE() that returns false when
!CONFIG_PPC_TRANSACTIONAL_MEM. Then you don't need this inline #ifdef.

Mikey

> +#else
>  		return;
> +#endif
> +	}
> =20
>  	msr =3D regs->msr;
>  	msr_check_and_set(msr_all_available);
