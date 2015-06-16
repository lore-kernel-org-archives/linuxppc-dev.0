Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x233.google.com (mail-yk0-x233.google.com
 [IPv6:2607:f8b0:4002:c07::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 526791A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 23:18:10 +1000 (AEST)
Received: by ykar6 with SMTP id r6so12832623yka.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 06:18:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 16 Jun 2015 08:17:47 -0500
Message-ID: <CAL_JsqK3L9Hv9bhAtwAAXVYjLJBTOG9=4ddOo-SFqnD-_KieCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
 Anton Blanchard <anton@samba.org>,
 Behan Webster <behanw@converseincode.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Paris <eparis@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>,
 Robert Richter <rric@kernel.org>,
 Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>,
 Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-hexagon@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-s390@vger.kernel.org,
 SH-Linux <linux-sh@vger.kernel.org>, linux390@de.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2015 at 11:42 AM, David Long <dave.long@linaro.org> wrote:
> From: "David A. Long" <dave.long@linaro.org>
>
> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>  feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h.
>
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/kernel/ptrace.c     | 5 -----
>  arch/powerpc/kernel/ptrace.c | 5 -----
>  arch/sh/include/asm/ptrace.h | 5 -----
>  arch/x86/kernel/ptrace.c     | 5 -----
>  include/linux/ptrace.h       | 9 +++++++++
>  5 files changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ef9119f..fb45cf1 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -59,11 +59,6 @@
>  #define BREAKINST_THUMB        0xde01
>  #endif
>
> -struct pt_regs_offset {
> -       const char *name;
> -       int offset;
> -};
> -
>  #define REG_OFFSET_NAME(r) \
>         {.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
>  #define REG_OFFSET_END {.name = NULL, .offset = 0}

Can't you also move these? ARM is complicated with the "ARM_"
prefixing, but the others appear to be the same. Maybe you can remove
the prefix or redefine the macro for ARM.

Rob
