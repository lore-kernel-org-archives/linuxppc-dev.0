Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRZ8409cPzDr14
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 22:53:23 +1000 (AEST)
Subject: Re: block/ps3vram: Check return of ps3vram_cache_init
To: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1502135910.git.geoff@infradead.org>
 <f1d16f5ac3eb170493ca7835a7c39c1b4675a81f.1502135910.git.geoff@infradead.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5df6ae90-8b7d-8418-b2ee-15dbebfa3e95@users.sourceforge.net>
Date: Tue, 8 Aug 2017 14:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <f1d16f5ac3eb170493ca7835a7c39c1b4675a81f.1502135910.git.geoff@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -741,7 +741,11 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
>  		goto out_unmap_reports;
>  	}
>  
> -	ps3vram_cache_init(dev);
> +	error = ps3vram_cache_init(dev);
> +	if (error < 0) {
> +		goto out_unmap_reports;
> +	}
> +
>  	ps3vram_proc_init(dev);
>  
>  	queue = blk_alloc_queue(GFP_KERNEL);

I pointed a few development concerns out.
https://patchwork.ozlabs.org/patch/798575/

Will the commit subject “block/ps3vram: Check return value of ps3vram_cache_init()”
be more appropriate?

Regards,
Markus
