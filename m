Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cZTC10M5zF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 02:40:30 +1000 (AEST)
Date: Fri, 27 Jul 2018 18:40:23 +0200
Message-ID: <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
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
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
In-Reply-To: <20180727145811.12334-5-muriloo@linux.ibm.com>
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

> Simplify the message format by using REG_FMT as the register format.  Thi=
s
> avoids having two different formats and avoids checking for MSR_64BIT.

Are you sure it is what we want ?

Won't it change the behaviour for a 32 bits app running on a 64bits kernel =
?

Christophe


>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 4faab4705774..047d980ac776 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -311,17 +311,13 @@ static bool show_unhandled_signals_ratelimited(void=
)
>  static void show_signal_msg(int signr, struct pt_regs *regs, int code,
>  			    unsigned long addr)
>  {
> -	const char fmt32[] =3D KERN_INFO "%s[%d]: unhandled signal %d " \
> -		"at %08lx nip %08lx lr %08lx code %x\n";
> -	const char fmt64[] =3D KERN_INFO "%s[%d]: unhandled signal %d " \
> -		"at %016lx nip %016lx lr %016lx code %x\n";
> -
>  	if (!unhandled_signal(current, signr))
>  		return;
>
> -	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> -	       current->comm, current->pid, signr,
> -	       addr, regs->nip, regs->link, code);
> +	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
> +		" nip "REG_FMT" lr "REG_FMT" code %x\n",
> +		current->comm, current->pid, signr, addr,
> +		regs->nip, regs->link, code);
>  }
>
>  void _exception_pkey(int signr, struct pt_regs *regs, int code,
> --
> 2.17.1
