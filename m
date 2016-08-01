Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2lfB3hk0zDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 13:47:45 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so9062732pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 20:47:45 -0700 (PDT)
Date: Mon, 1 Aug 2016 13:47:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Scott Wood
 <oss@buserror.net>, Alessio Igor Bogani <alessio.bogani@elettra.eu>, Paul
 Mackerras <paulus@samba.org>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 2/3] powerpc: Call chained reset handlers during reset
Message-ID: <20160801134734.05eaedd1@roar.ozlabs.ibm.com>
In-Reply-To: <1469747238-17432-2-git-send-email-andrew.smirnov@gmail.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
 <1469747238-17432-2-git-send-email-andrew.smirnov@gmail.com>
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

On Thu, 28 Jul 2016 16:07:17 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Call out to all restart handlers that were added via
> register_restart_handler() API when restarting the machine.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> No changes compared to v1
> 
>  arch/powerpc/kernel/setup-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c
> b/arch/powerpc/kernel/setup-common.c index 5cd3283..205d073 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -145,6 +145,10 @@ void machine_restart(char *cmd)
>  		ppc_md.restart(cmd);
>  
>  	smp_send_stop();
> +
> +	do_kernel_restart(cmd);
> +	mdelay(1000);
> +
>  	machine_hang();
>  }
>  

Ah, I see why you don't move smp_send_stop(). 3 other architectures
call do_kernel_restart(). arm and arm64 call it with
local_irq_disabled(). arm and mips insert the 1s delay. All call it
after smp_send_stop(). I don't see the harm in the delay. Should we
call it with local interrupts disabled?
