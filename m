Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE6AFDDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 15:47:53 +1000 (EST)
Date: Mon, 23 Jun 2008 23:18:26 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-ID: <20080624051826.GC19434@colo.lackof.org>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Cc: chris@zankel.net, dev-etrax@axis.com, ysato@users.sourceforge.jp,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@linux-mips.org, cooloney@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Roland McGrath <roland@redhat.com>,
	gerg@uclinux.org, Andrew Morton <akpm@linux-foundation.org>,
	yasutake.koichi@jp.panasonic.com, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 08:48:09PM +0300, Adrian Bunk wrote:
> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
>   - cris
>   - frv
>   - powerpc
>   - x86
> - don't expose function prototypes and macros to userspace:
>   - arm
>   - blackfin
>   - cris
>   - mn10300
>   - parisc
...
> diff --git a/include/asm-parisc/ptrace.h b/include/asm-parisc/ptrace.h
> index 93f990e..3e94c5d 100644
> --- a/include/asm-parisc/ptrace.h
> +++ b/include/asm-parisc/ptrace.h
> @@ -33,7 +33,6 @@ struct pt_regs {
>  	unsigned long ipsw;	/* CR22 */
>  };
>  
> -#define task_regs(task) ((struct pt_regs *) ((char *)(task) + TASK_REGS))
>  /*
>   * The numbers chosen here are somewhat arbitrary but absolutely MUST
>   * not overlap with any of the number assigned in <linux/ptrace.h>.
> @@ -43,8 +42,11 @@ struct pt_regs {
>   * since we have taken branch traps too)
>   */
>  #define PTRACE_SINGLEBLOCK	12	/* resume execution until next branch */
> +
>  #ifdef __KERNEL__
>  
> +#define task_regs(task) ((struct pt_regs *) ((char *)(task) + TASK_REGS))
> +
>  /* XXX should we use iaoq[1] or iaoq[0] ? */
>  #define user_mode(regs)			(((regs)->iaoq[0] & 3) ? 1 : 0)
>  #define user_space(regs)		(((regs)->iasq[1] != 0) ? 1 : 0)

Looks fine to me.
Acked-by: Grant Grundler <grundler@parisc-linux.org>
