Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id 38D01DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 01:09:56 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so793939nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:09:55 -0700 (PDT)
Message-ID: <fa686aa40707200809n635d4203j719c26c3258b8da9@mail.gmail.com>
Date: Fri, 20 Jul 2007 09:09:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] powerpc: mpc5200 low power mode, .globl fix
In-Reply-To: <20070720105550.GA1385@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11847043512142-git-send-email-tnt@246tNt.com>
	<20070720105550.GA1385@moe.telargo.com>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/20/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> flush_data_cache doesn't need to be global, and can cause problems.
> Thanks to Milton Miller for noticing this.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Paulus, can you pick this up please?

> ---
>  arch/powerpc/platforms/52xx/lite5200_sleep.S |    1 -
>  1 file changed, 1 deletion(-)
>
> Index: work-powerpc.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/platforms/52xx/lite5200_sleep.S
> +++ work-powerpc.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
> @@ -400,7 +400,6 @@ restore_regs:
>   * Flush data cache
>   * Do this by just reading lots of stuff into the cache.
>   */
> -        .globl flush_data_cache
>  flush_data_cache:
>         lis     r3,CONFIG_KERNEL_START@h
>         ori     r3,r3,CONFIG_KERNEL_START@l
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
