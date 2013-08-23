Return-Path: <RA8135@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 03B9F2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 09:41:11 +1000 (EST)
Date: Fri, 23 Aug 2013 18:40:59 -0500
From: James Yang <James.Yang@freescale.com>
To: James Yang <James.Yang@freescale.com>
Subject: Re: [PATCH] powerpc/ppc64: remove __volatile__ in  get_current()
In-Reply-To: <1376110162-3462-1-git-send-email-James.Yang@freescale.com>
Message-ID: <alpine.LRH.2.00.1308231832570.4940@ra8135-ec1.am.freescale.net>
References: <1376110162-3462-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 10 Aug 2013, James Yang wrote:

> Uses of get_current() that normally get optimized away still result in
> a load instruction of the current pointer in 64-bit because the inline
> asm uses __volatile__.  This patch removes __volatile__ so that nop-ed
> uses of get_current() don't actually result in a load of the pointer.
> 
> Signed-off-by: James Yang <James.Yang@freescale.com>
> ---
>  arch/powerpc/include/asm/current.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/current.h
> index e2c7f06..bb250c8 100644
> --- a/arch/powerpc/include/asm/current.h
> +++ b/arch/powerpc/include/asm/current.h
> @@ -19,7 +19,7 @@ static inline struct task_struct *get_current(void)
>  {
>  	struct task_struct *task;
>  
> -	__asm__ __volatile__("ld %0,%1(13)"
> +	__asm__ ("ld %0,%1(13)"
>  	: "=r" (task)
>  	: "i" (offsetof(struct paca_struct, __current)));


Hello, 

Scott's been able to put enough doubt in me to think that this is not 
entirely safe, even though the testing and code generation show it to 
work.  Please reject this patch.

I think there is still value in getting the unnecessary loads to be 
removed since it would also allow unnecessary conditional branches to 
be removed.  I'll think about alternate ways to do this.

Regards,

--James
