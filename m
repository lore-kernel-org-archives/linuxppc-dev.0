Return-Path: <rkuo@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C69F61A0ABE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 04:22:09 +1000 (AEST)
Date: Thu, 18 Jun 2015 13:13:05 -0500
From: rkuo <rkuo@codeaurora.org>
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
 Anton Blanchard <anton@samba.org>,
 Behan Webster <behanw@converseincode.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <Nikolay.Borisov@arm.com>,
 Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH 2/2] Consolidate redundant register/stack access code
Message-ID: <20150618181304.GA9557@codeaurora.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-3-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434386579-6045-3-git-send-email-dave.long@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2015 at 12:42:59PM -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Several architectures have identical or functionally equivalent code
> implementing parts of the HAVE_REGS_AND_STACK_ACCESS_API feature.  Move
> that code out of the architecture directories.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/include/asm/ptrace.h          |  6 ---
>  arch/arm/kernel/ptrace.c               | 67 +-------------------------------
>  arch/hexagon/include/uapi/asm/ptrace.h |  3 --
>  arch/powerpc/include/asm/ptrace.h      | 38 ------------------
>  arch/powerpc/kernel/ptrace.c           | 34 +----------------
>  arch/s390/include/asm/ptrace.h         |  3 --
>  arch/s390/kernel/ptrace.c              | 70 ++++++++++------------------------
>  arch/sh/include/asm/ptrace.h           | 39 -------------------
>  arch/sh/kernel/Makefile                |  2 +-
>  arch/sh/kernel/ptrace.c                | 33 ----------------
>  arch/sh/kernel/ptrace_32.c             |  2 +-
>  arch/sh/kernel/ptrace_64.c             |  2 +-
>  arch/x86/include/asm/ptrace.h          | 37 ------------------
>  arch/x86/kernel/ptrace.c               | 34 +----------------
>  include/linux/ptrace.h                 | 42 ++++++++++++++++++++
>  kernel/ptrace.c                        | 38 ++++++++++++++++++
>  16 files changed, 107 insertions(+), 343 deletions(-)
>  delete mode 100644 arch/sh/kernel/ptrace.c
> 

(And in some cases, the architecture didn't have the code in the first place!)

For Hexagon:

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
