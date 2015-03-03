Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACAAF1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 19:30:11 +1100 (AEDT)
Received: by wggy19 with SMTP id y19so38368877wgg.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 00:30:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 3 Mar 2015 09:30:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] seccomp: switch to using asm-generic for seccomp.h
Message-ID: <20150303083002.GA1207@gmail.com>
References: <20150302231254.GA4857@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302231254.GA4857@www.outflux.net>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, James Hogan <james.hogan@imgtec.com>,
 Laura Abbott <lauraa@codeaurora.org>, linux-s390@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Daniel Borkmann <dborkman@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kees Cook <keescook@chromium.org> wrote:

> Most architectures don't need to do anything special for the strict
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.

>  19 files changed, 27 insertions(+), 137 deletions(-)

Lovely cleanup factor.

Just to make sure, are you sure the 32-bit details are identical 
across architectures?

For example some architectures did this:

> --- a/arch/microblaze/include/asm/seccomp.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#ifndef _ASM_MICROBLAZE_SECCOMP_H
> -#define _ASM_MICROBLAZE_SECCOMP_H
> -
> -#include <linux/unistd.h>
> -
> -#define __NR_seccomp_read		__NR_read
> -#define __NR_seccomp_write		__NR_write
> -#define __NR_seccomp_exit		__NR_exit
> -#define __NR_seccomp_sigreturn		__NR_sigreturn
> -
> -#define __NR_seccomp_read_32		__NR_read
> -#define __NR_seccomp_write_32		__NR_write
> -#define __NR_seccomp_exit_32		__NR_exit
> -#define __NR_seccomp_sigreturn_32	__NR_sigreturn

others did this:

> diff --git a/arch/x86/include/asm/seccomp_64.h b/arch/x86/include/asm/seccomp_64.h
> deleted file mode 100644
> index 84ec1bd161a5..000000000000
> --- a/arch/x86/include/asm/seccomp_64.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#ifndef _ASM_X86_SECCOMP_64_H
> -#define _ASM_X86_SECCOMP_64_H
> -
> -#include <linux/unistd.h>
> -#include <asm/ia32_unistd.h>
> -
> -#define __NR_seccomp_read __NR_read
> -#define __NR_seccomp_write __NR_write
> -#define __NR_seccomp_exit __NR_exit
> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
> -
> -#define __NR_seccomp_read_32 __NR_ia32_read
> -#define __NR_seccomp_write_32 __NR_ia32_write
> -#define __NR_seccomp_exit_32 __NR_ia32_exit
> -#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
> -
> -#endif /* _ASM_X86_SECCOMP_64_H */

While in yet another case you kept the syscall mappings:

> --- a/arch/x86/include/asm/seccomp.h
> +++ b/arch/x86/include/asm/seccomp.h
> @@ -1,5 +1,20 @@
> +#ifndef _ASM_X86_SECCOMP_H
> +#define _ASM_X86_SECCOMP_H
> +
> +#include <asm/unistd.h>
> +
> +#ifdef CONFIG_COMPAT
> +#include <asm/ia32_unistd.h>
> +#define __NR_seccomp_read_32		__NR_ia32_read
> +#define __NR_seccomp_write_32		__NR_ia32_write
> +#define __NR_seccomp_exit_32		__NR_ia32_exit
> +#define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
> +#endif
> +
>  #ifdef CONFIG_X86_32
> -# include <asm/seccomp_32.h>
> -#else
> -# include <asm/seccomp_64.h>
> +#define __NR_seccomp_sigreturn		__NR_sigreturn
>  #endif
> +
> +#include <asm-generic/seccomp.h>
> +
> +#endif /* _ASM_X86_SECCOMP_H */

It might all be correct, but it's not obvious to me.

Thanks,

	Ingo
