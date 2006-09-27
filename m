Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id E00AB67B61
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 18:20:02 +1000 (EST)
Date: Wed, 27 Sep 2006 10:18:38 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Use check_legacy_ioport() for ISAPnP
Message-ID: <20060927081838.GA5984@aepfle.de>
References: <1159341535.3309.108.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1159341535.3309.108.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 27, David Woodhouse wrote:

> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index f2e0179..3ac5b12 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -1049,6 +1049,10 @@ static int __init isapnp_init(void)
>  		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
>  		return 0;
>  	}
> +#ifdef CONFIG_PPC_MERGE
> +	if (check_legacy_ioport(_PIDXR) || check_legacy_ioport(_PNPWRP))
> +		return -EINVAL;
> +#endif
>  #ifdef ISAPNP_REGION_OK
>  	if (!request_region(_PIDXR, 1, "isapnp index")) {
>  		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n", _PIDXR);

Isnt that fixed by my other patch which was merged into -mm today?
