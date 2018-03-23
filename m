Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072cq5cKHzDrKC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:18:18 +1100 (AEDT)
Subject: Re: [PATCH 13/19] powerpc/52xx: Add missing functions prototypes
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-14-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <c2b1c28c-a9f9-2284-2069-d1338f506cb3@c-s.fr>
Date: Fri, 23 Mar 2018 13:18:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-14-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/03/2018 à 21:19, Mathieu Malaterre a écrit :
> The function prototypes were declared within a `#ifdef CONFIG_PPC_LITE5200`
> block which would prevent them from being visible when compiling
> `mpc52xx_pm.c`. Move the prototypes outside of the `#ifdef` block to fix
> the following warnings treated as errors with W=1:
> 
>    arch/powerpc/platforms/52xx/mpc52xx_pm.c:58:5: error: no previous prototype for ‘mpc52xx_pm_prepare’ [-Werror=missing-prototypes]
>    arch/powerpc/platforms/52xx/mpc52xx_pm.c:113:5: error: no previous prototype for ‘mpc52xx_pm_enter’ [-Werror=missing-prototypes]
>    arch/powerpc/platforms/52xx/mpc52xx_pm.c:181:6: error: no previous prototype for ‘mpc52xx_pm_finish’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/include/asm/mpc52xx.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
> index e94cede14522..0f6b3cbb119f 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -350,14 +350,14 @@ extern struct mpc52xx_suspend mpc52xx_suspend;
>   extern int __init mpc52xx_pm_init(void);
>   extern int mpc52xx_set_wakeup_gpio(u8 pin, u8 level);
>   
> -#ifdef CONFIG_PPC_LITE5200
> -extern int __init lite5200_pm_init(void);
> -
>   /* lite5200 calls mpc5200 suspend functions, so here they are */
>   extern int mpc52xx_pm_prepare(void);
>   extern int mpc52xx_pm_enter(suspend_state_t);
>   extern void mpc52xx_pm_finish(void);
>   extern char saved_sram[0x4000]; /* reuse buffer from mpc52xx suspend */
> +
> +#ifdef CONFIG_PPC_LITE5200
> +extern int __init lite5200_pm_init(void);

extern keyword is not needed

Christophe

>   #endif
>   #endif /* CONFIG_PM */
>   
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
