Return-Path: <sshtylyov@mvista.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F58DB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 22:49:13 +1100 (EST)
Received: by eyg24 with SMTP id 24so2360966eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 03:49:07 -0800 (PST)
Message-ID: <4D342C6E.6000608@ru.mvista.com>
Date: Mon, 17 Jan 2011 14:47:58 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Xulei <B33228@freescale.com>
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
In-Reply-To: <1295248259-14752-1-git-send-email-B33228@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jgarzik@pobox.com, kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 17-01-2011 10:10, Xulei wrote:

> In FSL sata v2 block, the snoop bit of PRDT Word3 description
> information is at bit28 instead of bit22.

> This patch adds FSL sata v2 probe and resolve this difference.

> Signed-off-by: Xulei <B33228@freescale.com>

    AFAIK, full name is required.

> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
[...]

> diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
> index 2bbecbb..9ad41dd 100644
> --- a/arch/powerpc/boot/dts/p1022ds.dts
> +++ b/arch/powerpc/boot/dts/p1022ds.dts
> @@ -475,14 +475,14 @@
>   		};
>
>   		sata@18000 {
> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>   			reg =<0x18000 0x1000>;
>   			cell-index =<1>;
>   			interrupts =<74 0x2>;
>   		};
>
>   		sata@19000 {
> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>   			reg =<0x19000 0x1000>;
>   			cell-index =<2>;
>   			interrupts =<41 0x2>;

    Please put this into the separate patch and push thru the PPC tree.

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index b0214d0..a56399a 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
[...]
> @@ -417,7 +420,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>
>   	if (qc->flags&  ATA_QCFLAG_DMAMAP)
>   		num_prde = sata_fsl_fill_sg(qc, (void *)cd,
> -					&ttl_dwords, cd_paddr);
> +					&ttl_dwords, cd_paddr,
> +					    host_priv->data_snoop);

    Please align these lines uniformly.

WBR, Sergei
