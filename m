Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgr2M4R2PzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 18:59:39 +1000 (AEST)
Subject: Re: linux-next: build failure after merge of the powerpc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20160701152707.444e03b4@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <577630DB.9070401@canonical.com>
Date: Fri, 1 Jul 2016 09:59:07 +0100
MIME-Version: 1.0
In-Reply-To: <20160701152707.444e03b4@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/07/16 06:27, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> arch/powerpc/kernel/fadump.c: In function 'fadump_invalidate_dump':
> arch/powerpc/kernel/fadump.c:1014:2: error: expected ';' before '}' token
>   }
>   ^
> 
> Caused by commit
> 
>   4a03749f140c ("powerpc/fadump: Trivial fix of spelling mistake, clean up message")
> 
> I have added this fix patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 1 Jul 2016 15:19:34 +1000
> Subject: [PATCH] powerpc/fadump: add missing semicolon
> 
> Fixes: 4a03749f140c ("powerpc/fadump: Trivial fix of spelling mistake, clean up message")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/fadump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index f0664860753e..b3a663333d36 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1010,7 +1010,7 @@ static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
>  
>  	if (rc) {
>  		pr_err("Failed to invalidate firmware-assisted dump registration. Unexpected error (%d).\n", rc);
> -		return rc
> +		return rc;
>  	}
>  	fw_dump.dump_active = 0;
>  	fdm_active = NULL;
> 

Apologies for that. Thanks for fixing it up.
