Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSd4F5kkwzDvtG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 20:07:57 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/8xx: xmon compile fix
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20161129085654.1967-1-npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <cc525418-2763-6346-0106-325f81e6444c@c-s.fr>
Date: Tue, 29 Nov 2016 10:06:43 +0100
MIME-Version: 1.0
In-Reply-To: <20161129085654.1967-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/11/2016 à 09:56, Nicholas Piggin a écrit :
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/xmon/xmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 7605455..435f5f5 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1213,10 +1213,13 @@ bpt_cmds(void)
>  {
>  	int cmd;
>  	unsigned long a;
> -	int mode, i;
> +	int i;
>  	struct bpt *bp;
> +#ifndef CONFIG_8xx

CONFIG_8xx is deprecated (ref arch/powerpc/platforms/Kconfig.cputype).
CONFIG_PPC_8xx should be used instead.

> +	int mode;

You could also have moved this declaration inside the switch {, 
something like

	switch (cmd) {
#ifndef CONFIG_8xx
+		int mode;
	case 'd':


Christophe

>  	const char badaddr[] = "Only kernel addresses are permitted "
>  		"for breakpoints\n";
> +#endif
>
>  	cmd = inchar();
>  	switch (cmd) {
>
