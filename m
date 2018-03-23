Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406zds0zRXzF22j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 21:04:00 +1100 (AEDT)
Subject: Re: [PATCH 03/19] powerpc: Mark variables as unused
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-4-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <32ecbb82-cecc-732c-cc57-cf7e36dc1965@c-s.fr>
Date: Fri, 23 Mar 2018 11:03:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-4-malat@debian.org>
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
> Add gcc attribute unused for two variables. Fix warnings treated as errors
> with W=1:
> 
>    arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/kernel/prom_init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index acf4b2e0530c..6a3ac4522144 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>   	const char *opt;
>   
>   	char *p;
> -	int l = 0;
> +	int l __maybe_unused = 0;
>   
>   	prom_cmd_line[0] = 0;
>   	p = prom_cmd_line;
> @@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size)
>   static void __init prom_init_mem(void)
>   {
>   	phandle node;
> -	char *path, type[64];
> +	char *path __maybe_unused, type[64];

path is only used if DEBUG_PROM is defined, so it should be enclosed 
into #ifdef DEBUG_PROM

Christophe

>   	unsigned int plen;
>   	cell_t *p, *endp;
>   	__be32 val;
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
