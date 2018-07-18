Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VsWW0DZDzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 19:37:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Mathieu
 Malaterre <malat@debian.org>, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: remove linux,stdout-package property
In-Reply-To: <20180712171904.18971-1-muriloo@linux.ibm.com>
References: <20180712171904.18971-1-muriloo@linux.ibm.com>
Date: Wed, 18 Jul 2018 19:37:37 +1000
Message-ID: <87a7qoq3z2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Murilo,

Thanks for the patch.

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> This property was added in 2004 by
>
>     https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6
>
> and the only use of it, which was already inside `#if 0`, was removed a month
> later by
>
>     https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7
>
> Fixes: https://github.com/linuxppc/linux/issues/125

That is going to confuse some scripts that are expecting that to be a
"Fixes: <some commit>" tag :)

The proper tag to use there would be "Link:".

But, I'd prefer we didn't add github issue links to the history, as I'm
not sure they won't bit-rot eventually. Not because I'm a anti-Microsoft
conspiracy person but just because it's a repo I set up and manage and
there's no long term plan for it necessarily.

> ---
>  arch/powerpc/kernel/prom_init.c | 2 --
>  1 file changed, 2 deletions(-)

Including the link here would be ideal, as it means it doesn't end up in
the commit history, but it does end up in the mail archive. So if we
ever really need to find it, it should be there.

cheers

> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5425dd3d6a9f..c45fb463c9e5 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2102,8 +2102,6 @@ static void __init prom_init_stdout(void)
>  	stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
>  	if (stdout_node != PROM_ERROR) {
>  		val = cpu_to_be32(stdout_node);
> -		prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
> -			     &val, sizeof(val));
>  
>  		/* If it's a display, note it */
>  		memset(type, 0, sizeof(type));
> -- 
> 2.17.1
