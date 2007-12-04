Return-Path: <news@alea.gnuu.de>
Received: from uucp.gnuu.de (banki.eumelnet.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id 61B43DDF3D
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:07:22 +1100 (EST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>) id 1Izg8V-0004iY-LZ
	for linuxppc-dev@ozlabs.org; Tue, 04 Dec 2007 23:21:03 +0100
To: linuxppc-dev@ozlabs.org
From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH v2] Fix hardware IRQ time accounting problem.
Date: Tue, 4 Dec 2007 22:21:03 +0000 (UTC)
Message-ID: <slrnflbkmf.6uo.joerg@alea.gnuu.de>
References: <20071204055144.GR24243@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@alea.gnuu.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo Tony,

Tony Breeds <tony@bakeyournoodle.com> wrote:
> The commit fa13a5a1f25f671d084d8884be96fc48d9b68275 (sched: restore
> deterministic CPU accounting on powerpc), unconditionally calls
> update_process_tick() in system context.  In the deterministic accounting case
> this is the correct thing to do.  However, in the non-deterministic accounting
> case we need to not do this, and results in the time accounted as hardware irq
> time being artificially elevated.
>
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 41e13f4..b9d8837 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -350,7 +350,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	local_irq_save(flags);
>  
>  	account_system_vtime(current);
> -	account_process_tick(current, 0);
> +	account_process_vtime(current);
>  	calculate_steal_time();

This patch works for me. The high hardware interrupt load is gone. Thanks.

Bye, Jörg.
-- 
Der Klügere gibt so lange nach bis er der Dumme ist.
