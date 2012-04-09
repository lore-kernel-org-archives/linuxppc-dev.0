Return-Path: <sshtylyov@mvista.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4D54B6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2012 20:14:20 +1000 (EST)
Received: by bkwj10 with SMTP id j10so3156960bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2012 03:14:17 -0700 (PDT)
Message-ID: <4F82B61D.8010502@mvista.com>
Date: Mon, 09 Apr 2012 14:12:45 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
In-Reply-To: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 03-04-2012 14:12, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
[...]

> diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
> index cfa23bf..803fda6 100644
> --- a/arch/powerpc/boot/dts/bluestone.dts
> +++ b/arch/powerpc/boot/dts/bluestone.dts
> @@ -155,6 +155,27 @@
>   					/*RXDE*/  0x5 0x4>;
>   		};
>
> +		/* SATA DWC devices */
> +		SATA0: sata@bffd1000 {
> +			compatible = "amcc,sata-apm821xx";
> +			reg =<4 0xbffd1000 0x800   /* SATA0 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=<0>;
> +			interrupt-parent =<&UIC0>;
> +			interrupts =<26 4    /* SATA0 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +
> +		SATA1: sata@bffd1800 {
> +			compatible = "amcc,sata-apm821xx";
> +			reg =<4 0xbffd1800 0x800   /* SATA1 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=<1>;
> +			interrupt-parent =<&UIC0>;
> +			interrupts =<27 4    /* SATA1 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +

    So, this is dual SATA controller, not dual port SATA controller?
BTW, it's wrong to have the same AHBDMA resource in two device nodes I think.

MBR, Sergei
