Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2lV25l0zzDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 13:40:42 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so9501013pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 20:40:42 -0700 (PDT)
Date: Mon, 1 Aug 2016 13:40:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Scott Wood
 <oss@buserror.net>, Alessio Igor Bogani <alessio.bogani@elettra.eu>, Paul
 Mackerras <paulus@samba.org>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/3] powerpc: Factor out common code in setup-common.c
Message-ID: <20160801134031.7dcb7c82@roar.ozlabs.ibm.com>
In-Reply-To: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Jul 2016 16:07:16 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Factor out a small bit of common code in machine_restart(),
> machine_power_off() and machine_halt().
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> No changes compared to v1.
> 
>  arch/powerpc/kernel/setup-common.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c
> b/arch/powerpc/kernel/setup-common.c index 714b4ba..5cd3283 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -130,15 +130,22 @@ void machine_shutdown(void)
>  		ppc_md.machine_shutdown();
>  }
>  
> +static void machine_hang(void)
> +{
> +	pr_emerg("System Halted, OK to turn off power\n");
> +	local_irq_disable();
> +	while (1)
> +		;
> +}

What's the intended semantics of this function? A default power
off handler when the platform supplies none? Would ppc_power_off()
be a good name? Should the smp_send_stop() call be moved here?

It seems like a reasonable cleanup though.

Thanks,
Nick
