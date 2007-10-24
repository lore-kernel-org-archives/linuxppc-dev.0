Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF011DDF3A
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 10:23:50 +1000 (EST)
Message-ID: <471E908E.8080409@pobox.com>
Date: Tue, 23 Oct 2007 20:23:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pasemi_mac: fix typo
References: <20071020191003.GB30034@lixom.net>
In-Reply-To: <20071020191003.GB30034@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Add missing &:
> 
> drivers/net/pasemi_mac.c: In function 'pasemi_mac_clean_rx':
> drivers/net/pasemi_mac.c:553: warning: passing argument 1 of 'prefetch'
> makes pointer from integer without a cast
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
> index 9f9a421..ab4d309 100644
> --- a/drivers/net/pasemi_mac.c
> +++ b/drivers/net/pasemi_mac.c
> @@ -550,7 +550,7 @@ static int pasemi_mac_clean_rx(struct pasemi_mac *mac, int limit)
>  
>  	n = mac->rx->next_to_clean;
>  
> -	prefetch(RX_RING(mac, n));
> +	prefetch(&RX_RING(mac, n));
>  
>  	for (count = 0; count < limit; count++) {
>  		macrx = RX_RING(mac, n);

applied
