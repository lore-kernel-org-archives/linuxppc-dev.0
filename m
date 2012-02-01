Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A3D21007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 07:28:53 +1100 (EST)
Message-ID: <4F29A072.9050203@windriver.com>
Date: Wed, 1 Feb 2012 15:28:34 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Define cpus_in_crash only for SMP kernels
References: <20120201185510.GA8542@linux.vnet.ibm.com>
In-Reply-To: <20120201185510.GA8542@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 ben@decadent.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12-02-01 01:55 PM, Paul E. McKenney wrote:
> The variable cpus_in_crash gets a defined-but-not-used warning when
> CONFIG_SMP=n, so fix by placing the variable under ifdef.

I think Ben already merged a similar fix.

http://patchwork.ozlabs.org/patch/136549/

P.

> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 28be345..eb3384e 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -46,7 +46,9 @@
>  
>  /* This keeps a track of which one is the crashing cpu. */
>  int crashing_cpu = -1;
> +#ifdef CONFIG_SMP
>  static atomic_t cpus_in_crash;
> +#endif /* #ifdef CONFIG_SMP */
>  static int time_to_dump;
>  
>  #define CRASH_HANDLER_MAX 3
> 
