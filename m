Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 265A3B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 14:06:20 +1100 (EST)
Subject: Re: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-16-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-16-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Nov 2010 12:02:57 +1100
Message-ID: <1290992577.32570.216.camel@pasglop>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-15 at 11:05 -0700, Nishanth Aravamudan wrote:
> Without this change drivers, such as ibmvscsi, fail to load with the
> previous change.
> ---

So you broke bisection... fold the patch instead or invert them

Cheers,
Ben.

>  arch/powerpc/kernel/vio.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 3c3083f..e8d73de 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1259,6 +1259,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
>  	viodev->dev.parent = &vio_bus_device.dev;
>  	viodev->dev.bus = &vio_bus_type;
>  	viodev->dev.release = vio_dev_release;
> +        /* needed to ensure proper operation of coherent allocations
> +         * later, in case driver doesn't set it explicitly */
> +        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
>  
>  	/* register with generic device framework */
>  	if (device_register(&viodev->dev)) {
