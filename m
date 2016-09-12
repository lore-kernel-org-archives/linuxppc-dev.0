Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXs315v57zDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 01:21:16 +1000 (AEST)
Subject: Re: [PATCH] powerpc/32: add missing \n at end of printk warning
 message
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Kevin Hao <haokexin@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org
References: <20160912101224.24877-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fcc50e93-5009-496d-3251-b2d7ef820224@c-s.fr>
Date: Mon, 12 Sep 2016 17:21:10 +0200
MIME-Version: 1.0
In-Reply-To: <20160912101224.24877-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/09/2016 à 12:12, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
>
> The message is missing a \n, add it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/powerpc/mm/init_32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 448685f..b532dd9 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -137,7 +137,7 @@ void __init MMU_init(void)
>  	if (memblock.memory.cnt > 1) {
>  #ifndef CONFIG_WII
>  		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
> -		printk(KERN_WARNING "Only using first contiguous memory region");
> +		printk(KERN_WARNING "Only using first contiguous memory region\n");

This line was already 81 characters long. It is now 83.
I would suggest to use pr_warn() instead in order to shorten the line.

Christophe

>  #else
>  		wii_memory_fixups();
>  #endif
>
