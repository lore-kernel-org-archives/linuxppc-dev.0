Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A466DDFF4
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 05:55:56 +1000 (EST)
Message-ID: <48CC1AC3.7090406@garzik.org>
Date: Sat, 13 Sep 2008 15:55:47 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@gmx.de>
Subject: Re: [PATCH 1/2] ehea: Fix DLPAR memory handling
References: <200809051636.26545.hannes.hering@gmx.de>
In-Reply-To: <200809051636.26545.hannes.hering@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hannes Hering wrote:
> The ehea busmap must be allocated only once in the first of many calls of the
> ehea_create_busmap_callback.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>
> ---
> 
> diff -Nurp -X dontdiff linux-2.6.27-rc5/drivers/net/ehea/ehea_qmr.c patched_kernel/drivers/net/ehea/ehea_qmr.c
> --- linux-2.6.27-rc5/drivers/net/ehea/ehea_qmr.c	2008-08-29 00:52:02.000000000 +0200
> +++ patched_kernel/drivers/net/ehea/ehea_qmr.c	2008-09-05 15:31:30.000000000 +0200
> @@ -595,7 +595,8 @@ static int ehea_create_busmap_callback(u
>  	end_section = start_section + ((nr_pages * PAGE_SIZE) / EHEA_SECTSIZE);
>  	mr_len = *(unsigned long *)arg;
>  
> -	ehea_bmap = kzalloc(sizeof(struct ehea_bmap), GFP_KERNEL);
> +	if (!ehea_bmap)
> +		ehea_bmap = kzalloc(sizeof(struct ehea_bmap), GFP_KERNEL);
>  	if (!ehea_bmap)
>  		return -ENOMEM;

applied
