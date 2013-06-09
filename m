Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 380922C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 16:44:10 +1000 (EST)
Message-ID: <1370760236.3766.481.camel@pasglop>
Subject: Re: [PATCH v2 2/2] powerpc/hibernate: PPC64 fix user threads access
 to kernel space
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng <dongsheng.wang@freescale.com>
Date: Sun, 09 Jun 2013 16:43:56 +1000
In-Reply-To: <1370755352-29901-1-git-send-email-dongsheng.wang@freescale.com>
References: <1370755352-29901-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, johannes@sipsolutions.net, anton@enomsg.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-09 at 13:22 +0800, Wang Dongsheng wrote:
> If PID is used in the TLB, after hibernation resume, the user
> threads will access to kernel space.

 .../...

I think the explanation is way more convoluted and confusing
here than anything else.

Simply say that upon resume from hibernation, the MMU context
needs to be restored (this includes the PID register today
it might include more if we decided to pre-set some MAS for example
etc...) and be done with it.

Note that switch_mmu_context() used the way you do is quite "full on",
it will do a whole pile of stuff that are probably completely
unnecessary, and in addition might still miss the need to completely
flush the TLB anyway.

I would suggest that instead, somebody adds the necessary routine
to tlb_nohash.c, something like restore_mmu_context() which will
do that.

Cheers,
Ben.

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
>  arch/powerpc/kernel/swsusp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
> index eae33e1..1930e44 100644
> --- a/arch/powerpc/kernel/swsusp.c
> +++ b/arch/powerpc/kernel/swsusp.c
> @@ -32,7 +32,5 @@ void save_processor_state(void)
>  
>  void restore_processor_state(void)
>  {
> -#ifdef CONFIG_PPC32
>  	switch_mmu_context(current->active_mm, current->active_mm);
> -#endif
>  }
