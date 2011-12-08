Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D05C01007D8
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 11:08:17 +1100 (EST)
Received: from mail115-db3 (localhost [127.0.0.1])	by
 mail115-db3-R.bigfish.com (Postfix) with ESMTP id C5BE93A02D8	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 00:08:13 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.246])	by
 mail115-db3.bigfish.com (Postfix) with ESMTP id A3BFC52023F	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 00:08:13 +0000 (UTC)
Message-ID: <4EDFFFEA.5030603@freescale.com>
Date: Wed, 7 Dec 2011 18:08:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: create 32-bit DTS for the P1022DS
References: <1323302665-26461-1-git-send-email-timur@freescale.com>
 <1323302665-26461-2-git-send-email-timur@freescale.com>
In-Reply-To: <1323302665-26461-2-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2011 06:04 PM, Timur Tabi wrote:
> +		/*
> +		 * This node is used to access the pixis via "indirect" mode,
> +		 * which is done by writing the pixis register index to chip
> +		 * select 0 and the value to/from chip select 1.  Indirect
> +		 * mode is the only way to access the pixis when DIU video
> +		 * is enabled.  Note that this assumes that the first column
> +		 * of the 'ranges' property above is the chip select number.
> +		 */
> +		board-control@0,0 {
> +			compatible = "fsl,p1022ds-indirect-pixis";
> +			reg = <0x0 0x0 1	/* CS0 */
> +			       0x1 0x0 1>;	/* CS1 */
> +		};
[snip]
> +		board-control@3,0 {
> +			compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
> +			reg = <3 0 0x30>;
> +			interrupt-parent = <&mpic>;
> +			/*
> +			 * IRQ8 is generated if the "EVENT" switch is pressed
> +			 * and PX_CTL[EVESEL] is set to 00.
> +			 */
> +			interrupts = <8 8 0 0>;
> +		};

It's not new to this patch, but... what does "8" mean in the second cell
of an mpic interrupt specifier?  And why does the indirect pixis node
not have the interrupt?

-Scott
