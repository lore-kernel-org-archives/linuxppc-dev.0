Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406z5C0ytvzF22F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 20:39:10 +1100 (AEDT)
Subject: Re: [PATCH 02/19] powerpc/powermac: Mark variable x as unused
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-3-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <ae3d5a1a-3661-30a5-4f08-de1c6ed3a3e1@c-s.fr>
Date: Fri, 23 Mar 2018 10:38:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-3-malat@debian.org>
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
> Since the value of x is never intended to be read, declare it with gcc
> attribute as unused. Fix warning treated as error with W=1:
> 
>    arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/platforms/powermac/udbg_scc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
> index d83135a9830e..c38ca406df1a 100644
> --- a/arch/powerpc/platforms/powermac/udbg_scc.c
> +++ b/arch/powerpc/platforms/powermac/udbg_scc.c
> @@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
>   	struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
>   	struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
>   	const char *path;
> -	int i, x;
> +	int i, x __maybe_unused;

You could just replace 'x = in_8(sccc)' by 'in_8(sccc)' and get rid of 
the x.

Christophe


>   
>   	escc = of_find_node_by_name(NULL, "escc");
>   	if (escc == NULL)
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
