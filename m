Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFtcv5xMdzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 16:40:15 +1000 (AEST)
Message-ID: <1471588815.5780.121.camel@neuling.org>
Subject: Re: [PATCH v3 03/21] powerpc: Add check_if_tm_restore_required() to
 giveup_all()
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 wei.guo.simon@gmail.com
Cc: anton@samba.org
Date: Fri, 19 Aug 2016 16:40:15 +1000
In-Reply-To: <20160817034323.23053-4-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
 <20160817034323.23053-4-cyrilbur@gmail.com>
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

On Wed, 2016-08-17 at 13:43 +1000, Cyril Bur wrote:
> giveup_all() causes FPU/VMX/VSX facilitities to be disabled in a

facilities.

> threads MSR. If this thread was transactional this should be recorded
> as reclaiming/recheckpointing code will need to know.

Can you expand on this?=C2=A0=C2=A0It's not clear to me how this relates to=
 the code.

Mikey

> Fixes: c208505 ("powerpc: create giveup_all()")
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> =C2=A0arch/powerpc/kernel/process.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index cdf2d20..82308fd 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -445,6 +445,7 @@ void giveup_all(struct task_struct *tsk)
> =C2=A0		return;
> =C2=A0
> =C2=A0	msr_check_and_set(msr_all_available);
> +	check_if_tm_restore_required(tsk);
> =C2=A0
> =C2=A0#ifdef CONFIG_PPC_FPU
> =C2=A0	if (usermsr & MSR_FP)
