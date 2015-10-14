Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0130.outbound.protection.outlook.com [157.56.111.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A2A51A072B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 07:36:26 +1100 (AEDT)
Message-ID: <1444854968.5185.205.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/fsl: Add PCI node in device tree of bsc9132qds
From: Scott Wood <scottwood@freescale.com>
To: Zhiqiang Hou <B48286@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <devicetree@vger.kernel.org>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
 <mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
 <harninder.rai@freescale.com>, <Minghuan.Lian@freescale.com>,
 <Mingkai.Hu@freescale.com>
Date: Wed, 14 Oct 2015 15:36:08 -0500
In-Reply-To: <1444735761-1510-1-git-send-email-B48286@freescale.com>
References: <1444735761-1510-1-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-13 at 19:29 +0800, Zhiqiang Hou wrote:
> From: Harninder Rai <harninder.rai@freescale.com>
> 
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Change-Id: I4355add4a92d1fcf514843aea5ecadd2e2517969
> Reviewed-on: http://git.am.freescale.net:8181/2454
> Reviewed-by: Zang Tiefei-R61911 <tie-fei.zang@freescale.com>
> Reviewed-by: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>

Get rid of the gerrit stuff.  And where is your signoff?

> diff --git a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi 
> b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> index c723071..78c8f1c 100644
> --- a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> @@ -40,6 +40,35 @@
>       interrupts = <16 2 0 0 20 2 0 0>;
>  };
>  
> +/* controller at 0xa000 */
> +&pci0 {
> +     compatible = "fsl,bsc9132-pcie", "fsl,qoriq-pcie-v2.2";
> +     device_type = "pci";
> +     #size-cells = <2>;
> +     #address-cells = <3>;
> +     bus-range = <0 255>;
> +     clock-frequency = <33333333>;
> +     interrupts = <16 2 0 0>;

This clock-frequency is not correct for PCIe.  Just remove it.

-Scott
