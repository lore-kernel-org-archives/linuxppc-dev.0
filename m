Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482211A05EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 02:21:35 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 9 Dec 2015 10:21:31 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9881D6E8053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 10:09:39 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB9FLUtI30408720
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 15:21:30 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB9FLRLJ030022
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 10:21:28 -0500
Subject: Re: [PATCH] powerpc/nvram: Fix a memory leak in err path
To: xinhui <xinhui.pan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <5667FBD5.2050206@linux.vnet.ibm.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <566846F5.2020507@linux.vnet.ibm.com>
Date: Wed, 9 Dec 2015 09:21:25 -0600
MIME-Version: 1.0
In-Reply-To: <5667FBD5.2050206@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2015 04:00 AM, xinhui wrote:
> 
> If kmemdup fails, We need kfree *buff* first then return -ENOMEM.
> Otherwise there is a memory leak.
> 
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/nvram_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index 32e2652..21a278b7 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -542,9 +542,9 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>  			time->tv_nsec = 0;
>  		}
>  		*buf = kmemdup(buff + hdr_size, length, GFP_KERNEL);
> +		kfree(buff);
>  		if (*buf == NULL)
>  			return -ENOMEM;
> -		kfree(buff);
>  
>  		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
>  			*compressed = true;
> 
