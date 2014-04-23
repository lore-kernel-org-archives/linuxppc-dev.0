Return-Path: <Gang.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (unknown
 [207.46.163.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA11A1400A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 17:31:49 +1000 (EST)
From: "Gang.Liu@freescale.com" <Gang.Liu@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: RE: [PATCH] powerpc/rmu: Fix the error memory free parameters
Date: Wed, 23 Apr 2014 07:16:52 +0000
Message-ID: <ca1ab68874204c8d8d8468a424274bd9@BLUPR03MB407.namprd03.prod.outlook.com>
References: <1397037885-21060-1-git-send-email-Gang.Liu@freescale.com>
In-Reply-To: <1397037885-21060-1-git-send-email-Gang.Liu@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Do you have some comments about this patch,
or would you please help to apply it?

Thanks a lot!
Liu Gang

> -----Original Message-----
> From: Liu Gang [mailto:Gang.Liu@freescale.com]
> Sent: Wednesday, April 09, 2014 6:05 PM
> To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421
> Cc: Zang Roy-R61911; Liu Gang-B34182
> Subject: [PATCH] powerpc/rmu: Fix the error memory free parameters
>=20
> There are error parameters should be corrected when calling
> dma_free_coherent to free rmu rx-ring buffers in fsl_open_inb_mbox()
> function.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  arch/powerpc/sysdev/fsl_rmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rmu.c
> b/arch/powerpc/sysdev/fsl_rmu.c index 00e224a..b48197a 100644
> --- a/arch/powerpc/sysdev/fsl_rmu.c
> +++ b/arch/powerpc/sysdev/fsl_rmu.c
> @@ -881,9 +881,9 @@ fsl_open_inb_mbox(struct rio_mport *mport, void
> *dev_id, int mbox, int entries)
>  	rc =3D request_irq(IRQ_RIO_RX(mport), fsl_rio_rx_handler, 0,
>  			 "msg_rx", (void *)mport);
>  	if (rc < 0) {
> -		dma_free_coherent(priv->dev, RIO_MSG_BUFFER_SIZE,
> -			rmu->msg_tx_ring.virt_buffer[i],
> -			rmu->msg_tx_ring.phys_buffer[i]);
> +		dma_free_coherent(priv->dev,
> +			rmu->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
> +			rmu->msg_rx_ring.virt, rmu->msg_rx_ring.phys);
>  		goto out;
>  	}
>=20
> --
> 1.8.5
>=20
