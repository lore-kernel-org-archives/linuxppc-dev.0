Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E021F2C014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 18:29:35 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 7 May 2013 18:23:21 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 774882CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 18:29:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r478FURu24314048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 18:15:31 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r478TSr9023530
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 18:29:29 +1000
Message-ID: <1367915364.3083.21.camel@ThinkPad-T5421>
Subject: Re: [PATCH] powerpc: Fix  MAX_STACK_TRACE_ENTRIES too low warning
 again
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 07 May 2013 16:29:24 +0800
In-Reply-To: <1367893978.3083.13.camel@ThinkPad-T5421>
References: <1367893978.3083.13.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-05-07 at 10:32 +0800, Li Zhong wrote:
> Saw this warning again, and this time from the ret_from_fork path. 
> 
> It seems we could clear the back chain earlier in copy_thread(), which
> could cover both path, and also fix potential lockdep usage in
> schedule_tail(), or exception occurred before we clear the back chain.

Sorry, I made some mistake, please ignore this patch...
It seems clearing the back chain shouldn't use kregs->gpr[1] below, it
should be ((unsigned long*)sp)[0]. I'll send an updated version.

Thanks, Zhong

> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/entry_32.S |    2 --
>  arch/powerpc/kernel/entry_64.S |    2 --
>  arch/powerpc/kernel/process.c  |    1 +
>  3 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index e514de5..d22e73e 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -439,8 +439,6 @@ ret_from_fork:
>  ret_from_kernel_thread:
>  	REST_NVGPRS(r1)
>  	bl	schedule_tail
> -	li	r3,0
> -	stw	r3,0(r1)
>  	mtlr	r14
>  	mr	r3,r15
>  	PPC440EP_ERR42
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 3fe5259..48e8a86 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -376,8 +376,6 @@ _GLOBAL(ret_from_fork)
>  _GLOBAL(ret_from_kernel_thread)
>  	bl	.schedule_tail
>  	REST_NVGPRS(r1)
> -	li	r3,0
> -	std	r3,0(r1)
>  	ld	r14, 0(r14)
>  	mtlr	r14
>  	mr	r3,r15
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ceb4e7b..2c9fc5e 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -973,6 +973,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	 */
>  	sp -= sizeof(struct pt_regs);
>  	kregs = (struct pt_regs *) sp;
> +	kregs->gpr[1] = 0;
>  	sp -= STACK_FRAME_OVERHEAD;
>  	p->thread.ksp = sp;
>  	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
