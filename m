Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF06B1A0A44
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 16:01:54 +1100 (AEDT)
Message-ID: <1426741314.4866.100.camel@neuling.org>
Subject: Re: [PATCH 1/3] powerpc/tm: Abort syscalls in active transactions
From: Michael Neuling <mikey@neuling.org>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 19 Mar 2015 16:01:54 +1100
In-Reply-To: <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: azanella@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-19 at 15:43 +1100, Sam Bobroff wrote:
> This patch changes the syscall handler to doom (tabort) active
> transactions when a syscall is made and return immediately without
> performing the syscall.
>=20
> Currently, the system call instruction automatically suspends an
> active transaction which causes side effects to persist when an active
> transaction fails.
>=20
> This does change the kernel's behaviour, but in a way that was
> documented as unsupported. It doesn't reduce functionality because
> syscalls will still be performed after tsuspend. It also provides a
> consistent interface and makes the behaviour of user code
> substantially the same across powerpc and platforms that do not
> support suspended transactions (e.g. x86 and s390).
>=20
> Performance measurements using
> http://ozlabs.org/~anton/junkcode/null_syscall.c
> indicate the cost of a system call increases by about 0.5%.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Thanks Sam!

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
>  Documentation/powerpc/transactional_memory.txt |   33 ++++++++++++------=
------
>  arch/powerpc/include/uapi/asm/tm.h             |    2 +-
>  arch/powerpc/kernel/entry_64.S                 |   19 ++++++++++++++
>  3 files changed, 37 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentati=
on/powerpc/transactional_memory.txt
> index 9791e98..4167bc2 100644
> --- a/Documentation/powerpc/transactional_memory.txt
> +++ b/Documentation/powerpc/transactional_memory.txt
> @@ -74,22 +74,23 @@ Causes of transaction aborts
>  Syscalls
>  =3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Performing syscalls from within transaction is not recommended, and can =
lead
> -to unpredictable results.
> -
> -Syscalls do not by design abort transactions, but beware: The kernel cod=
e will
> -not be running in transactional state.  The effect of syscalls will alwa=
ys
> -remain visible, but depending on the call they may abort your transactio=
n as a
> -side-effect, read soon-to-be-aborted transactional data that should not =
remain
> -invisible, etc.  If you constantly retry a transaction that constantly a=
borts
> -itself by calling a syscall, you'll have a livelock & make no progress.
> -
> -Simple syscalls (e.g. sigprocmask()) "could" be OK.  Even things like wr=
ite()
> -from, say, printf() should be OK as long as the kernel does not access a=
ny
> -memory that was accessed transactionally.
> -
> -Consider any syscalls that happen to work as debug-only -- not recommend=
ed for
> -production use.  Best to queue them up till after the transaction is ove=
r.
> +Syscalls made from within an active transaction will not be performed an=
d the
> +transaction will be doomed by the kernel with the failure code TM_CAUSE_=
SYSCALL
> +| TM_CAUSE_PERSISTENT.
> +
> +Syscalls made from within a suspended transaction are performed as norma=
l and
> +the transaction is not explicitly doomed by the kernel.  However, what t=
he
> +kernel does to perform the syscall may result in the transaction being d=
oomed
> +by the hardware.  The syscall is performed in suspended mode so any side
> +effects will be persistent, independent of transaction success or failur=
e.  No
> +guarantees are provided by the kernel about which syscalls will affect
> +transaction success.
> +
> +Care must be taken when relying on syscalls to abort during active trans=
actions
> +if the calls are made via a library.  Libraries may cache values (which =
may
> +give the appearence of success) or perform operations that cause transac=
tion
> +failure before entering the kernel (which may produce different failure =
codes).
> +Examples are glibc's getpid() and lazy symbol resolution.
> =20
>=20
>  Signals
> diff --git a/arch/powerpc/include/uapi/asm/tm.h b/arch/powerpc/include/ua=
pi/asm/tm.h
> index 5d836b7..5047659 100644
> --- a/arch/powerpc/include/uapi/asm/tm.h
> +++ b/arch/powerpc/include/uapi/asm/tm.h
> @@ -11,7 +11,7 @@
>  #define TM_CAUSE_RESCHED	0xde
>  #define TM_CAUSE_TLBI		0xdc
>  #define TM_CAUSE_FAC_UNAV	0xda
> -#define TM_CAUSE_SYSCALL	0xd8  /* future use */
> +#define TM_CAUSE_SYSCALL	0xd8
>  #define TM_CAUSE_MISC		0xd6  /* future use */
>  #define TM_CAUSE_SIGNAL		0xd4
>  #define TM_CAUSE_ALIGNMENT	0xd2
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index d180caf2..85bf81d 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -34,6 +34,7 @@
>  #include <asm/ftrace.h>
>  #include <asm/hw_irq.h>
>  #include <asm/context_tracking.h>
> +#include <asm/tm.h>
> =20
>  /*
>   * System calls.
> @@ -145,6 +146,24 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
>  	bne	syscall_dotrace
>  .Lsyscall_dotrace_cont:
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +BEGIN_FTR_SECTION
> +	b	1f
> +END_FTR_SECTION_IFCLR(CPU_FTR_TM)
> +	extrdi.	r11, r12, 1, (63-MSR_TS_T_LG) /* transaction active? */
> +	beq+	1f
> +
> +	/* Doom the transaction and don't perform the syscall: */
> +	mfmsr	r11
> +	li	r12, 1
> +	rldimi	r11, r12, MSR_TM_LG, 63-MSR_TM_LG
> +	mtmsrd	r11, 0
> +	li	r11, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
> +	tabort. r11
> +
> +	b	.Lsyscall_exit
> +1:
> +#endif
>  	cmpldi	0,r0,NR_syscalls
>  	bge-	syscall_enosys
> =20
