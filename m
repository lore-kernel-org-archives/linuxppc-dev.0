Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 643D9DE5B5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 03:03:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] Linux Device Driver for Xilinx LL TEMAC 10/100/1000
	EthernetNIC
Date: Mon, 18 Aug 2008 10:01:41 -0700
In-Reply-To: <48A7B01C.2070403@dlasys.net>
References: <48A7B01C.2070403@dlasys.net>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>,
	<netdev@vger.kernel.org>
Message-ID: <20080818170334.E5B99153006F@mail59-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> +static struct platform_driver temac_device_driver =3D {
> +	.probe		=3D temac_device_probe,
> +	.remove		=3D __devexit_p(temac_device_remove),
> +	.suspend	=3D NULL,
> +	.resume		=3D NULL,
> +	.driver		=3D {
> +		.name	=3D DRV_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +};

I understand you're probably still using arch/ppc, but you'll need to
implement the of bindings as well.  This can be done relatively easily
in parallel with a platform_device binding. (and you can probably get
alot of the code out of the xilinx LLTEMAC driver.

> diff --git a/include/linux/xilinx_devices.h
b/include/linux/xilinx_devices.h
> index 41ad421..79ca491 100755
> --- a/include/linux/xilinx_devices.h
> +++ b/include/linux/xilinx_devices.h
> @@ -94,7 +94,7 @@ struct xtemac_platform_data {
>  #define XTEMAC_DMA_SGDMA	3	/* scatter gather DMA */
>  #endif
> =

> -#if defined(CONFIG_XILINX_LLTEMAC)
> +#if defined(CONFIG_XILINX_LLTEMAC) || defined(CONFIG_XPS_LLTEMAC)
>  /* LLTEMAC platform data */
>  struct xlltemac_platform_data {
>  	u8 tx_csum;

You probably want to generate patches against mainline in the future...

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
