Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wZJGG6NPYzDqV7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 May 2017 06:51:50 +1000 (AEST)
Date: Fri, 26 May 2017 22:51:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: mchehab@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2 1/3] EDAC: mv64x60: remove unused variable
Message-ID: <20170526205137.ktm53pf3lcn6oarm@pd.tnic>
References: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
 <20170518083135.28048-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170518083135.28048-2-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 18, 2017 at 08:31:33PM +1200, Chris Packham wrote:
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/edac/mv64x60_edac.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
> index 14b7e7b71eaa..454e1e26ee7c 100644
> --- a/drivers/edac/mv64x60_edac.c
> +++ b/drivers/edac/mv64x60_edac.c
> @@ -853,8 +853,6 @@ static struct platform_driver * const drivers[] = {
>  
>  static int __init mv64x60_edac_init(void)
>  {
> -	int ret = 0;
> -
>  	printk(KERN_INFO "Marvell MV64x60 EDAC driver " MV64x60_REVISION "\n");
>  	printk(KERN_INFO "\t(C) 2006-2007 MontaVista Software\n");
>  	/* make sure error reporting method is sane */
> -- 

Looks like the logic behind that ret variable is to catch the retval of
platform_register_drivers() and test it to return early. And then issue
the printks and assign edac_op_state only in the success case.

Please do that instead.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
