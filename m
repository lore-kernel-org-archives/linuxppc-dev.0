Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP0813vSLzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 03:14:09 +1000 (AEST)
Subject: Re: [PATCH 3/3] powerpc/8xx: xmon compile fix
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170511151522.4772-1-npiggin@gmail.com>
 <20170511151522.4772-3-npiggin@gmail.com>
Cc: Scott Wood <oss@buserror.net>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <b84f2d89-fc2f-d25f-1871-8fcd7b133fcf@c-s.fr>
Date: Thu, 11 May 2017 19:14:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170511151522.4772-3-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/05/2017 à 17:15, Nicholas Piggin a écrit :
> Cc: Scott Wood <oss@buserror.net>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/xmon/xmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index f11f65634aab..ec420b0e6e88 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1242,10 +1242,13 @@ bpt_cmds(void)
>  {
>  	int cmd;
>  	unsigned long a;
> -	int mode, i;
> +	int i;
>  	struct bpt *bp;
> +#ifndef CONFIG_8xx

Would be better to use CONFIG_PPC_8xx

As stated in arch/powerpc/platform/Kconfig.cputype, CONFIG_8xx is temp 
to handle compat with arch/ppc, and we are trying to get rid of it

Christophe



> +	int mode;
>  	const char badaddr[] = "Only kernel addresses are permitted "
>  		"for breakpoints\n";
> +#endif
>
>  	cmd = inchar();
>  	switch (cmd) {
>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
