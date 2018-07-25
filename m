Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bKHG2qRJzDrHN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 01:42:33 +1000 (AEST)
Date: Wed, 25 Jul 2018 17:42:28 +0200
Message-ID: <20180725174228.Horde.-PsCOyKHj9skAHIMbqyLDg1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Simon Guo
 <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>, Nicholas
 Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>, Michael
 Ellerman <mpe@ellerman.id.au>, "Eric W . Biederman" <ebiederm@xmission.com>,
 Cyril Bur <cyrilbur@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Andrew
 Donnellan <andrew.donnellan@au1.ibm.com>, Alastair D'Silva
 <alastair@d-silva.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] powerpc/traps: Return early in show_signal_msg()
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-3-muriloo@linux.ibm.com>
In-Reply-To: <20180724192720.32417-3-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a =C3=A9crit=C2=A0:

> Modify logic of show_signal_msg() to return early, if possible.  Replace
> printk_ratelimited() by printk() and a default rate limit burst to limit
> displaying unhandled signals messages.

Can you explain more the benefits of this change ?

Christophe

>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index cbd3dc365193..4faab4705774 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -301,6 +301,13 @@ void user_single_step_siginfo(struct task_struct *ts=
k,
>  	info->si_addr =3D (void __user *)regs->nip;
>  }
>
> +static bool show_unhandled_signals_ratelimited(void)
> +{
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	return show_unhandled_signals && __ratelimit(&rs);
> +}
> +
>  static void show_signal_msg(int signr, struct pt_regs *regs, int code,
>  			    unsigned long addr)
>  {
> @@ -309,11 +316,12 @@ static void show_signal_msg(int signr, struct=20=20
>=20pt_regs *regs, int code,
>  	const char fmt64[] =3D KERN_INFO "%s[%d]: unhandled signal %d " \
>  		"at %016lx nip %016lx lr %016lx code %x\n";
>
> -	if (show_unhandled_signals && unhandled_signal(current, signr)) {
> -		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> -				   current->comm, current->pid, signr,
> -				   addr, regs->nip, regs->link, code);
> -	}
> +	if (!unhandled_signal(current, signr))
> +		return;
> +
> +	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> +	       current->comm, current->pid, signr,
> +	       addr, regs->nip, regs->link, code);
>  }
>
>  void _exception_pkey(int signr, struct pt_regs *regs, int code,
> @@ -326,7 +334,8 @@ void _exception_pkey(int signr, struct pt_regs=20=20
>=20*regs, int code,
>  		return;
>  	}
>
> -	show_signal_msg(signr, regs, code, addr);
> +	if (show_unhandled_signals_ratelimited())
> +		show_signal_msg(signr, regs, code, addr);
>
>  	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
>  		local_irq_enable();
> --
> 2.17.1
