Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44674B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 15:29:23 +1000 (EST)
Subject: Re: [PATCH v9 11/13] powerpc: select HAVE_SECCOMP_FILTER and
	provide seccomp_execve
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Drewry <wad@chromium.org>
In-Reply-To: <1308875813-20122-11-git-send-email-wad@chromium.org>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
	<1308875813-20122-11-git-send-email-wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 15:28:03 +1000
Message-ID: <1314682083.2488.73.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, fweisbec@gmail.com, scarybeasts@gmail.com,
	djm@mindrot.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, segoon@openwall.com, tglx@linutronix.de,
	Paul Mackerras <paulus@samba.org>, kees.cook@canonical.com,
	jmorris@namei.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-23 at 19:36 -0500, Will Drewry wrote:
> Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
> system call numbering for execve and selecting HAVE_SECCOMP_FILTER.
> 
> v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf
> 
> Signed-off-by: Will Drewry <wad@chromium.org>

Seen these around for a while ... :-)

I don't see a harm in the patches per-se tho I haven't reviewed the
actual seccomp filter stuff and it's good (or bad) behaviour on ppc.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.

> ---
>  arch/powerpc/Kconfig               |    1 +
>  arch/powerpc/include/asm/seccomp.h |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2729c66..030d392 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -129,6 +129,7 @@ config PPC
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>  	select HAVE_GENERIC_HARDIRQS
>  	select HAVE_SPARSE_IRQ
> +	select HAVE_SECCOMP_FILTER
>  	select IRQ_PER_CPU
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_IRQ_SHOW_LEVEL
> diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
> index 00c1d91..3cb9cc1 100644
> --- a/arch/powerpc/include/asm/seccomp.h
> +++ b/arch/powerpc/include/asm/seccomp.h
> @@ -7,10 +7,12 @@
>  #define __NR_seccomp_write __NR_write
>  #define __NR_seccomp_exit __NR_exit
>  #define __NR_seccomp_sigreturn __NR_rt_sigreturn
> +#define __NR_seccomp_execve __NR_execve
>  
>  #define __NR_seccomp_read_32 __NR_read
>  #define __NR_seccomp_write_32 __NR_write
>  #define __NR_seccomp_exit_32 __NR_exit
>  #define __NR_seccomp_sigreturn_32 __NR_sigreturn
> +#define __NR_seccomp_execve_32 __NR_execve
>  
>  #endif	/* _ASM_POWERPC_SECCOMP_H */
