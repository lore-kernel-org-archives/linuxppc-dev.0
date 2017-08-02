Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMbxH4LXrzDrjD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 12:00:19 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id l64so4787977pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 19:00:19 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (203-219-56-202.tpgi.com.au.
 [203.219.56.202])
 by smtp.gmail.com with ESMTPSA id w66sm59141341pfi.63.2017.08.01.19.00.14
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Aug 2017 19:00:16 -0700 (PDT)
Date: Wed, 2 Aug 2017 12:00:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] powerpc: add irq accounting for system reset
 interrupts
Message-ID: <20170802120006.3081061c@roar.ozlabs.ibm.com>
In-Reply-To: <20170801120054.3447-4-npiggin@gmail.com>
References: <20170801120054.3447-1-npiggin@gmail.com>
 <20170801120054.3447-4-npiggin@gmail.com>
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

On Tue,  1 Aug 2017 22:00:53 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index b67f8b03a32d..4b9a567c9975 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -204,6 +204,9 @@ void soft_nmi_interrupt(struct pt_regs *regs)
>  		return;
>  
>  	nmi_enter();
> +
> +	__this_cpu_inc(irq_stat.soft_nmi_irqs);
> +
>  	tb = get_tb();
>  	if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {
>  		per_cpu(wd_timer_tb, cpu) = tb;

Sorry, this hunk leaked into patch 3. Should be in patch 4.
