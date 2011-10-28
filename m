Return-Path: <xenidis@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
 [209.85.160.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CB9EFB6F7F
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2011 06:37:40 +1100 (EST)
Received: by gyd5 with SMTP id 5so4176059gyd.15
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2011 12:37:37 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [4/4] powerpc/booke: Re-organize debug code
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1317905621-5537-4-git-send-email-galak@kernel.crashing.org>
Date: Fri, 28 Oct 2011 14:37:34 -0500
Message-Id: <5EF5AFC4-C852-4D1C-9019-D1CBAE1157EA@pobox.com>
References: <1317905621-5537-4-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>,
 Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 5, 2011, at 9:53 PM, Kumar Gala wrote:

> * set_dabr/do_dabr are no longer used when CNFIG_PPC_ADV_DEBUG_REGS is =
set
>  refactor code a bit such that we only build the dabr code for
>  !CONFIG_PPC_ADV_DEBUG_REGS and removed some CONFIG_PPC_ADV_DEBUG_REGS
>  code in set_dabr that would never get built.
>=20
> * Move do_send_trap into traps.c as its only used there
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> ---
> arch/powerpc/include/asm/system.h |    5 +--
> arch/powerpc/kernel/process.c     |   97 =
+++++++++++++-----------------------
> arch/powerpc/kernel/traps.c       |   17 +++++++
> 3 files changed, 53 insertions(+), 66 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/system.h =
b/arch/powerpc/include/asm/system.h
> index e30a13d..1dc5d9c 100644
> --- a/arch/powerpc/include/asm/system.h
> +++ b/arch/powerpc/include/asm/system.h
> @@ -111,11 +111,8 @@ static inline int debugger_dabr_match(struct =
pt_regs *regs) { return 0; }
> static inline int debugger_fault_handler(struct pt_regs *regs) { =
return 0; }
> #endif
>=20
> +#ifndef CONFIG_PPC_ADV_DEBUG_REGS
> extern int set_dabr(unsigned long dabr);
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -extern void do_send_trap(struct pt_regs *regs, unsigned long address,
> -			 unsigned long error_code, int signal_code, int =
brkpt);
> -#else


This part of the patch breaks xmon.c
Naively I simply wrapped the xmon call:

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f08836a..b5911b2 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -738,8 +738,10 @@ static void insert_bpts(void)
=20
 static void insert_cpu_bpts(void)
 {
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
 	if (dabr.enabled)
 		set_dabr(dabr.address | (dabr.enabled & 7));
+#endif
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
@@ -767,7 +769,9 @@ static void remove_bpts(void)
=20
 static void remove_cpu_bpts(void)
 {
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
 	set_dabr(0);
+#endif
 	if (cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, 0);
 }

-JX


> extern void do_dabr(struct pt_regs *regs, unsigned long address,
> 		    unsigned long error_code);
> #endif
> diff --git a/arch/powerpc/kernel/process.c =
b/arch/powerpc/kernel/process.c
> index 269a309..989e574 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -251,50 +251,6 @@ void discard_lazy_cpu_state(void)
> #endif /* CONFIG_SMP */
>=20
> #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -void do_send_trap(struct pt_regs *regs, unsigned long address,
> -		  unsigned long error_code, int signal_code, int =
breakpt)
> -{
> -	siginfo_t info;
> -
> -	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> -			11, SIGSEGV) =3D=3D NOTIFY_STOP)
> -		return;
> -
> -	/* Deliver the signal to userspace */
> -	info.si_signo =3D SIGTRAP;
> -	info.si_errno =3D breakpt;	/* breakpoint or watchpoint id =
*/
> -	info.si_code =3D signal_code;
> -	info.si_addr =3D (void __user *)address;
> -	force_sig_info(SIGTRAP, &info, current);
> -}
> -#else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
> -void do_dabr(struct pt_regs *regs, unsigned long address,
> -		    unsigned long error_code)
> -{
> -	siginfo_t info;
> -
> -	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> -			11, SIGSEGV) =3D=3D NOTIFY_STOP)
> -		return;
> -
> -	if (debugger_dabr_match(regs))
> -		return;
> -
> -	/* Clear the DABR */
> -	set_dabr(0);
> -
> -	/* Deliver the signal to userspace */
> -	info.si_signo =3D SIGTRAP;
> -	info.si_errno =3D 0;
> -	info.si_code =3D TRAP_HWBKPT;
> -	info.si_addr =3D (void __user *)address;
> -	force_sig_info(SIGTRAP, &info, current);
> -}
> -#endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
> -
> -static DEFINE_PER_CPU(unsigned long, current_dabr);
> -
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> /*
>  * Set the debug registers back to their default "safe" values.
>  */
> @@ -357,16 +313,7 @@ static void switch_booke_debug_regs(struct =
thread_struct *new_thread)
> 			prime_debug_regs(new_thread);
> }
> #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
> -#ifndef CONFIG_HAVE_HW_BREAKPOINT
> -static void set_debug_reg_defaults(struct thread_struct *thread)
> -{
> -	if (thread->dabr) {
> -		thread->dabr =3D 0;
> -		set_dabr(0);
> -	}
> -}
> -#endif /* !CONFIG_HAVE_HW_BREAKPOINT */
> -#endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
> +static DEFINE_PER_CPU(unsigned long, current_dabr);
>=20
> int set_dabr(unsigned long dabr)
> {
> @@ -376,19 +323,45 @@ int set_dabr(unsigned long dabr)
> 		return ppc_md.set_dabr(dabr);
>=20
> 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -	mtspr(SPRN_DAC1, dabr);
> -#ifdef CONFIG_PPC_47x
> -	isync();
> -#endif
> -#elif defined(CONFIG_PPC_BOOK3S)
> 	mtspr(SPRN_DABR, dabr);
> -#endif
> -
>=20
> 	return 0;
> }
>=20
> +void do_dabr(struct pt_regs *regs, unsigned long address,
> +		    unsigned long error_code)
> +{
> +	siginfo_t info;
> +
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) =3D=3D NOTIFY_STOP)
> +		return;
> +
> +	if (debugger_dabr_match(regs))
> +		return;
> +
> +	/* Clear the DABR */
> +	set_dabr(0);
> +
> +	/* Deliver the signal to userspace */
> +	info.si_signo =3D SIGTRAP;
> +	info.si_errno =3D 0;
> +	info.si_code =3D TRAP_HWBKPT;
> +	info.si_addr =3D (void __user *)address;
> +	force_sig_info(SIGTRAP, &info, current);
> +}
> +
> +#ifndef CONFIG_HAVE_HW_BREAKPOINT
> +static void set_debug_reg_defaults(struct thread_struct *thread)
> +{
> +	if (thread->dabr) {
> +		thread->dabr =3D 0;
> +		set_dabr(0);
> +	}
> +}
> +#endif /* !CONFIG_HAVE_HW_BREAKPOINT */
> +#endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
> +
> #ifdef CONFIG_PPC64
> DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
> #endif
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index db733d3..edc1108 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1184,6 +1184,23 @@ void SoftwareEmulation(struct pt_regs *regs)
> #endif /* CONFIG_8xx */
>=20
> #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> +static void do_send_trap(struct pt_regs *regs, unsigned long address,
> +		  unsigned long error_code, int signal_code, int =
breakpt)
> +{
> +	siginfo_t info;
> +
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) =3D=3D NOTIFY_STOP)
> +		return;
> +
> +	/* Deliver the signal to userspace */
> +	info.si_signo =3D SIGTRAP;
> +	info.si_errno =3D breakpt;	/* breakpoint or watchpoint id =
*/
> +	info.si_code =3D signal_code;
> +	info.si_addr =3D (void __user *)address;
> +	force_sig_info(SIGTRAP, &info, current);
> +}
> +
> static void handle_debug(struct pt_regs *regs, unsigned long =
debug_status)
> {
> 	int changed =3D 0;
