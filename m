Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28BC81A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:05:22 +1100 (AEDT)
Date: Fri, 5 Feb 2016 15:05:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160205140517.GE3305@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160204162053.C76A7692D8@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 2016-01-25 16:29:54, Torsten Duwe wrote:
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index ef8b916..29b7014 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -28,6 +28,11 @@
>  
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && defined(CONFIG_PPC64) && \
> +  !defined(CC_USING_MPROFILE_KERNEL)
> +#error "DYNAMIC_FTRACE_WITH_REGS requires working -mprofile-kernel"
> +#endif

CONFIG_DYNAMIC_FTRACE_WITH_REGS is automatically enabled when
both CONFIG_DYNAMIC_FTRACE and HAVE_DYNAMIC_FTRACE_WITH_REGS
are enabled.

Therefore it is not possible to build kernel with broken gcc
and DYNAMIC_FTRACE.

IMHO, we need to allow to explicitely disable DYNAMIC_FTRACE_WITH_REGS
if the compiler is broken to get around this build error.

We either need to define DYNAMIC_FTRACE_WITH_REGS as a proper
bool with description, help text, ... Or we need a way to
explicitely disable HAVE_DYNAMIC_FTRACE_WITH_REGS. Or something
like this.

Best Regards,
Petr
