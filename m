Return-Path: <rientjes@google.com>
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com
 [IPv6:2607:f8b0:4001:c05::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 750981A0357
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:25:30 +1000 (EST)
Received: by mail-ig0-f173.google.com with SMTP id r2so3627913igi.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 18:25:26 -0700 (PDT)
Date: Mon, 16 Jun 2014 18:25:24 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] powerpc: Fix build warning
In-Reply-To: <1402677499-28289-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.DEB.2.02.1406161824340.21018@chino.kir.corp.google.com>
References: <1402677499-28289-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 13 Jun 2014, Guenter Roeck wrote:

> If compiled with W=1, the following warning is seen in powerpc builds.
> 
> arch/powerpc/kernel/smp.c:750:18: warning:
> 	type qualifiers ignored on function return type
> static const int powerpc_smt_flags(void)
>                  ^
> 
> This is caused by a function returning 'const int', which doesn't
> make sense to gcc. Drop 'const' to fix the problem.
> 
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: David Rientjes <rientjes@google.com>

Although it's strange you report this happening on line 750 in the 
changelog but the patch shows it differently.

> ---
>  arch/powerpc/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 10ffffe..49d5d4e 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -768,7 +768,7 @@ int setup_profiling_timer(unsigned int multiplier)
>  
>  #ifdef CONFIG_SCHED_SMT
>  /* cpumask of CPUs with asymetric SMT dependancy */
> -static const int powerpc_smt_flags(void)
> +static int powerpc_smt_flags(void)
>  {
>  	int flags = SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES;
>  
