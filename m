Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CE391A0B12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 17:08:48 +1100 (AEDT)
Received: by mail-pa0-x22d.google.com with SMTP id wq6so18147821pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:08:48 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Zhang Zhuoyu <hellozzy1988@126.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, tglx@linutronix.de,
 jiang.liu@linux.intel.com, zhangzhuoyu@cmss.chinamobile.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] powerpc/irq: tidy up inconsistent context in
 migrate_irqs()
In-Reply-To: <1450242896-8322-1-git-send-email-hellozzy1988@126.com>
References: <1450242896-8322-1-git-send-email-hellozzy1988@126.com>
Date: Wed, 16 Dec 2015 17:08:41 +1100
Message-ID: <878u4vapsm.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

A couple of things.

Firstly, your two email addresses don't match:

Zhang Zhuoyu <hellozzy1988@126.com> writes:
> From: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>

These lines do seem odd! Are they causing a problem?

I'd be more comfortable removing them if I understood why they were
added. But they've been around since the beginning of git history so
that could be a bit difficult.

Instead, would it be possible to make sure this doesn't break anything
by including some test results?

Thanks,
Daniel

> Remove paradoxical and unnecessary lines before disable local interrupt.
>
> Signed-off-by: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
> ---
>  arch/powerpc/kernel/irq.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 290559d..03fa686 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -454,8 +454,6 @@ void migrate_irqs(void)
>  
>  	free_cpumask_var(mask);
>  
> -	local_irq_enable();
> -	mdelay(1);
>  	local_irq_disable();
>  }
>  #endif
> -- 
> 1.8.3.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
