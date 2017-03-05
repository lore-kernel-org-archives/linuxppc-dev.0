Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbfVN0qMXzDqFj
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 21:36:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
In-Reply-To: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
Date: Sun, 05 Mar 2017 21:36:43 +1100
Message-ID: <87mvd03t8k.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@ozlabs.org> writes:
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index adf2084..afd1c26 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -408,7 +408,8 @@ static void init_cache_info(struct ppc_cache_info *info, u32 size, u32 lsize,
>  	info->line_size = lsize;
>  	info->block_size = bsize;
>  	info->log_block_size = __ilog2(bsize);
> -	info->blocks_per_page = PAGE_SIZE / bsize;
> +	if (bsize)
> +		info->blocks_per_page = PAGE_SIZE / bsize;
  
And we should probably initialise it to zero just in case, so I added:

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index afd1c2623459..9cfaa8b69b5f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -410,6 +410,8 @@ static void init_cache_info(struct ppc_cache_info *info, u32 size, u32 lsize,
 	info->log_block_size = __ilog2(bsize);
 	if (bsize)
 		info->blocks_per_page = PAGE_SIZE / bsize;
+	else
+		info->blocks_per_page = 0;
 
 	if (sets == 0)
 		info->assoc = 0xffff;

cheers
