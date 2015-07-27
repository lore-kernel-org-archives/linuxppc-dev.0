Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDA891A1E3C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 05:00:26 +1000 (AEST)
Received: from mail-ig0-x22e.google.com (mail-ig0-x22e.google.com
 [IPv6:2607:f8b0:4001:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 464501402BA
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 05:00:26 +1000 (AEST)
Received: by igbij6 with SMTP id ij6so85016636igb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 12:00:24 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-11-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-11-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:59:35 -0700
Message-ID: <CAGXu5jLQUU5Xov+MQs7YfMEobCyjYLjOcpOZw7JG0wqvVci1yA@mail.gmail.com>
Subject: Re: [PATCH 11/11] selftests/seccomp: Add powerpc support
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 23, 2015 at 3:21 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Wire up the syscall number and regs so the tests work on powerpc.

This patch begs the question: this passes everything? (I was reminded
about syscall_restart while reading the patches. If everything passes,
it looks like powerpc exposes syscall_restart? Seems like ARM remains
the odd-arch-out on this. :P)

Thanks!

-Kees

>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 2303a8dff9a2..a004b4cce99e 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -14,6 +14,7 @@
>  #include <linux/filter.h>
>  #include <sys/prctl.h>
>  #include <sys/ptrace.h>
> +#include <sys/types.h>
>  #include <sys/user.h>
>  #include <linux/prctl.h>
>  #include <linux/ptrace.h>
> @@ -1205,6 +1206,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  # define ARCH_REGS     struct user_pt_regs
>  # define SYSCALL_NUM   regs[8]
>  # define SYSCALL_RET   regs[0]
> +#elif defined(__powerpc__)
> +# define ARCH_REGS     struct pt_regs
> +# define SYSCALL_NUM   gpr[0]
> +# define SYSCALL_RET   gpr[3]
>  #else
>  # error "Do not know how to find your architecture's registers and syscalls"
>  #endif
> @@ -1238,7 +1243,7 @@ void change_syscall(struct __test_metadata *_metadata,
>         ret = ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov);
>         EXPECT_EQ(0, ret);
>
> -#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
> +#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__) || defined(__powerpc__)
>         {
>                 regs.SYSCALL_NUM = syscall;
>         }
> @@ -1402,6 +1407,8 @@ TEST_F(TRACE_syscall, syscall_dropped)
>  #  define __NR_seccomp 383
>  # elif defined(__aarch64__)
>  #  define __NR_seccomp 277
> +# elif defined(__powerpc__)
> +#  define __NR_seccomp 358
>  # else
>  #  warning "seccomp syscall number unknown for this architecture"
>  #  define __NR_seccomp 0xffff
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
