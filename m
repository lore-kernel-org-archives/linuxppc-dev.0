Return-Path: <dja@axtens.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whVT01LxLzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 08:52:35 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id u26so22205899pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 15:52:35 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/kernel: Initialize load_tm on task creation
In-Reply-To: <1496673659-18499-1-git-send-email-leitao@debian.org>
References: <1496673659-18499-1-git-send-email-leitao@debian.org>
Date: Tue, 06 Jun 2017 08:52:28 +1000
Message-ID: <87k24q11zn.fsf@linkitivity.dja.id.au>
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

Hi Breno,

Looks good to me.

> Currently tsk->thread.load_tm is not initialized in the task creation
> and can contain garbage on a new task.
>
> This is an undesired behaviour, since it affects the timing to enable
> and disable the transactional memory laziness (disabling and enabling
> the MSR TM bit, which affects TM reclaim and recheckpoint in the
> scheduling process).

Is there any chance this uninitialised memory will leak something
interesting/sensitive? (Therefore, should this go to stable?)

Regards,
Daniel


> CC: Anton Blanchard <anton@samba.org>
> Fixes: 5d176f751ee3c6eededd984ad409bff201f436a7
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index a9435397eab8..2ad725ef4368 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1687,6 +1687,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
>  	current->thread.tm_tfhar = 0;
>  	current->thread.tm_texasr = 0;
>  	current->thread.tm_tfiar = 0;
> +	current->thread.load_tm = 0;
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
>  }
>  EXPORT_SYMBOL(start_thread);
> -- 
> 2.11.0
