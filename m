Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4025D1A0735
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 12:13:25 +1100 (AEDT)
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4C24140B9A
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 12:13:24 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id x65so22737236pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 17:13:24 -0800 (PST)
Subject: Re: [PATCH 12/12] powerpc/ftrace: Disable profiling for some files
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-12-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE552D.3070606@gmail.com>
Date: Thu, 25 Feb 2016 12:13:17 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-12-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 01:28, Michael Ellerman wrote:
> From: Torsten Duwe <duwe@lst.de>
>
> Using -mprofile-kernel on early boot code not only confuses the
> checker but is also useless, as the infrastructure is not yet in
> place. Proceed like with -pg (remove it from CFLAGS), equally with
> time.o, ftrace and its helper files.
>
>   * arch/powerpc/kernel/Makefile,
>     arch/powerpc/lib/Makefile:
>     - remove -mprofile-kernel from low level, boot code and
>       code-patching objects' CFLAGS.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/Makefile | 12 ++++++------
>  arch/powerpc/lib/Makefile    |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 794f22adf99d..44667fde7ae4 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -16,14 +16,14 @@ endif
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace early boot code
> -CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
> -CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
> -CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
> -CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog -mprofile-kernel
> +CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog -mprofile-kernel
> +CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog -mprofile-kernel
> +CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog -mprofile-kernel
>  # do not trace tracer code
> -CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog -mprofile-kernel
>  # timers used by tracing
> -CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog -mprofile-kernel
>  endif
>  
>  obj-y				:= cputable.o ptrace.o syscalls.o \
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index a47e14277fd8..98e22b2d7bec 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -6,8 +6,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>  
>  ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>  
> -CFLAGS_REMOVE_code-patching.o = -pg
> -CFLAGS_REMOVE_feature-fixups.o = -pg
> +CFLAGS_REMOVE_code-patching.o = -pg -mprofile-kernel
> +CFLAGS_REMOVE_feature-fixups.o = -pg -mprofile-kernel
>  
>  obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
>  	 feature-fixups.o

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
