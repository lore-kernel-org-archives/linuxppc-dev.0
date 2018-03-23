Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072Ws2JnVzF1Tk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:14:00 +1100 (AEDT)
Subject: Re: [PATCH 11/19] powerpc/powermac: Move pmac_pfunc_base_install
 prototype to header file
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-12-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <fd5993b4-0b0a-3c65-65a8-b26445d0d440@c-s.fr>
Date: Fri, 23 Mar 2018 13:13:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-12-malat@debian.org>
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
> The pmac_pfunc_base_install prototype was declared in powermac/smp.c since
> function was used there, move it to pmac_pfunc.h header to be visible in
> pfunc_base.c. Fix a warning treated as error with W=1:
> 
>    arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previous prototype for ‘pmac_pfunc_base_install’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/include/asm/pmac_pfunc.h | 1 +
>   arch/powerpc/platforms/powermac/smp.c | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/pmac_pfunc.h b/arch/powerpc/include/asm/pmac_pfunc.h
> index 73bd8f28f2a8..99f7a288789a 100644
> --- a/arch/powerpc/include/asm/pmac_pfunc.h
> +++ b/arch/powerpc/include/asm/pmac_pfunc.h
> @@ -245,6 +245,7 @@ extern void pmf_put_function(struct pmf_function *func);
>   
>   extern int pmf_call_one(struct pmf_function *func, struct pmf_args *args);
>   
> +extern int pmac_pfunc_base_install(void);


extern keyword is not needed

Christophe

>   
>   /* Suspend/resume code called by via-pmu directly for now */
>   extern void pmac_pfunc_base_suspend(void);
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index 95275e0e2efa..447da6db450a 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -65,7 +65,6 @@
>   #endif
>   
>   extern void __secondary_start_pmac_0(void);
> -extern int pmac_pfunc_base_install(void);
>   
>   static void (*pmac_tb_freeze)(int freeze);
>   static u64 timebase;
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
