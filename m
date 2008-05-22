Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38C6FDDFCF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 20:27:23 +1000 (EST)
Message-ID: <48354A7E.5070105@garzik.org>
Date: Thu, 22 May 2008 06:27:10 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 4/6] drivers/net/fs_enet: remove null pointer dereference
References: <Pine.LNX.4.64.0805121537590.3694@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0805121537590.3694@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The following code appears in the function fs_init_instance in the file drivers/net/fs_enet/fs_enet-main.c.
> 
> 	if (fep->ops == NULL) {
> 		printk(KERN_ERR DRV_MODULE_NAME
> 		       ": %s No matching ops found (%d).\n",
> 		       ndev->name, fpi->fs_no);
> 		err = -EINVAL;
> 		goto err;
> 	}
> 
> This code implies that at the point of err, fep->ops can be NULL, so an
> extra test is needed before dereferencing this value.
> 
> 
> This problem was found using the following semantic match
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @@
> expression E, E1;
> identifier f;
> statement S1,S2,S3;
> @@
> 
> * if (E == NULL)
> {
>   ... when != if (E == NULL) S1 else S2
>       when != E = E1
> * E->f
>   ... when any
>   return ...;
> }
> else S3
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

applied
