Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bKRK242dzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 01:49:33 +1000 (AEST)
Date: Wed, 25 Jul 2018 17:49:27 +0200
Message-ID: <20180725174927.Horde.Sfg4oyTmcaLgHIJr3Gf-oQ1@messagerie.si.c-s.fr>
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
Subject: Re: [PATCH 6/7] powerpc/traps: Print signal name for unhandled signals
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-7-muriloo@linux.ibm.com>
In-Reply-To: <20180724192720.32417-7-muriloo@linux.ibm.com>
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

> This adds a human-readable name in the unhandled signal message.
>
> Before this patch, a page fault looked like:
>
>     Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled=20=20
>=20signal 11 at 00000000100007d0 nip 000000001000061c lr=20=20
>=2000007fff93c55100 code 2 in pandafault[10000000+10000]
>
> After this patch, a page fault looks like:
>
>     Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault=20=20
>=20(11) at 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100=20=20
>=20code 2 in pandafault[13a2a0000+10000]
>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index e6c43ef9fb50..e55ee639d010 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
>  #define TM_DEBUG(x...) do { } while(0)
>  #endif
>
> +static const char *signames[SIGRTMIN + 1] =3D {
> +	"UNKNOWN",
> +	"SIGHUP",			// 1
> +	"SIGINT",			// 2
> +	"SIGQUIT",			// 3
> +	"SIGILL",			// 4
> +	"unhandled trap",		// 5 =3D SIGTRAP
> +	"SIGABRT",			// 6 =3D SIGIOT
> +	"bus error",			// 7 =3D SIGBUS
> +	"floating point exception",	// 8 =3D SIGFPE
> +	"illegal instruction",		// 9 =3D SIGILL
> +	"SIGUSR1",			// 10
> +	"segfault",			// 11 =3D SIGSEGV
> +	"SIGUSR2",			// 12
> +	"SIGPIPE",			// 13
> +	"SIGALRM",			// 14
> +	"SIGTERM",			// 15
> +	"SIGSTKFLT",			// 16
> +	"SIGCHLD",			// 17
> +	"SIGCONT",			// 18
> +	"SIGSTOP",			// 19
> +	"SIGTSTP",			// 20
> +	"SIGTTIN",			// 21
> +	"SIGTTOU",			// 22
> +	"SIGURG",			// 23
> +	"SIGXCPU",			// 24
> +	"SIGXFSZ",			// 25
> +	"SIGVTALRM",			// 26
> +	"SIGPROF",			// 27
> +	"SIGWINCH",			// 28
> +	"SIGIO",			// 29 =3D SIGPOLL =3D SIGLOST
> +	"SIGPWR",			// 30
> +	"SIGSYS",			// 31 =3D SIGUNUSED
> +};
> +
>  /*
>   * Trap & Exception support
>   */
> @@ -314,10 +349,10 @@ static void show_signal_msg(int signr, struct=20=20
>=20pt_regs *regs, int code,
>  	if (!unhandled_signal(current, signr))
>  		return;
>
> -	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
> -		" nip "REG_FMT" lr "REG_FMT" code %x",
> -		current->comm, current->pid, signr, addr,
> -		regs->nip, regs->link, code);
> +	pr_info("%s[%d]: %s (%d) at "REG_FMT" nip "REG_FMT \
> +		" lr "REG_FMT" code %x",
> +		current->comm, current->pid, signames[signr],
> +		signr, addr, regs->nip, regs->link, code);

Are we sure that signr is always within the limits of the table ?

Christophe
>
>  	print_vma_addr(KERN_CONT " in ", regs->nip);
>
> --
> 2.17.1
