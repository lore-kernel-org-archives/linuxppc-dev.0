Return-Path: <srs0=irka=bt=gmail.com=breno.debian@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJPBQ582jzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 22:45:50 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yJPBQ4FhLz8t9N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 22:45:50 +1100 (AEDT)
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yJPBQ0RbVz9t69
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2017 22:45:49 +1100 (AEDT)
Received: by mail-qt0-f196.google.com with SMTP id z28so18023627qtz.13
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2017 04:45:49 -0700 (PDT)
Date: Fri, 20 Oct 2017 09:45:40 -0200
From: Breno Leitao <leitao@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, stewart@linux.vnet.ibm.com, mikey@neuling.org,
 cyrilbur@gmail.com
Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
Message-ID: <20171020114539.piyh4wmby5gz7qnb@gmail.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikey, Cyril,

On Thu, Oct 12, 2017 at 09:17:16PM +1100, Michael Ellerman wrote:
> From: Cyril Bur <cyrilbur@gmail.com>
> 
> Currently the kernel relies on firmware to inform it whether or not the
> CPU supports HTM and as long as the kernel was built with
> CONFIG_PPC_TRANSACTIONAL_MEM=y then it will allow userspace to make
> use of the facility.
> 
> There may be situations where it would be advantageous for the kernel
> to not allow userspace to use HTM, currently the only way to achieve
> this is to recompile the kernel with CONFIG_PPC_TRANSACTIONAL_MEM=n.
> 
> This patch adds a simple commandline option so that HTM can be
> disabled at boot time.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> [mpe: Simplify to a bool, move to prom.c, put doco in the right place.
>  Always disable, regardless of initial state, to avoid user confusion.]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/powerpc/kernel/prom.c                      | 31 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 05496622b4ef..ef03e6e16bdb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3185,6 +3185,10 @@
>  			allowed (eg kernel_enable_fpu()/kernel_disable_fpu()).
>  			There is some performance impact when enabling this.
>  
> +	ppc_tm=		[PPC]
> +			Format: {"off"}
> +			Disable Hardware Transactional Memory
> +
>  	print-fatal-signals=
>  			[KNL] debug: print fatal signals
>  
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index f83056297441..d9bd6555f980 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -658,6 +658,35 @@ static void __init early_reserve_mem(void)
>  #endif
>  }
>  
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +static bool tm_disabled __initdata;

I think the name 'tm_disabled' might cause more confusion on the TM
code. Mainly because we already have tm_enable() and tm_enabled()
functions which are related to the MSR register and TM bit, and, with
your new variable, tm_enabled() and tm_disabled are not going to be
exclusionary. Neither tm_enable() with be able to toggle the tm_disabled
value.

Anyway, just my 2 cents.
