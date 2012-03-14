Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92DDEB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 05:50:56 +1100 (EST)
Received: from mail41-am1 (localhost [127.0.0.1])	by mail41-am1-R.bigfish.com
 (Postfix) with ESMTP id 854A64404AC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 14 Mar 2012 18:50:52 +0000 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.233])	by
 mail41-am1.bigfish.com (Postfix) with ESMTP id 1E15B340069	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 18:50:26 +0000 (UTC)
Message-ID: <4F60E86C.7000603@freescale.com>
Date: Wed, 14 Mar 2012 13:50:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <Chang-Ming.Huang@freescale.com>
Subject: Re: [PATCH 4/4] powerpc/85xx: add the P1020UTM-PC DTS support
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-3-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-4-git-send-email-Chang-Ming.Huang@freescale.com>
In-Reply-To: <1331716110-25545-4-git-send-email-Chang-Ming.Huang@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2012 04:08 AM, Chang-Ming.Huang@freescale.com wrote:
> +&lbc {
> +	nor@0,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "cfi-flash";
> +		reg = <0x0 0x0 0x2000000>;
> +		bank-width = <2>;
> +		device-width = <1>;
> +
> +		partition@0 {
> +			/* 256KB for DTB Image */
> +			reg = <0x0 0x00040000>;
> +			label = "NOR (RO) DTB Image";
> +			read-only;
> +		};
> +
> +		partition@40000 {
> +			/* 3.75 MB for Linux Kernel Image */
> +			reg = <0x00040000 0x003c0000>;
> +			label = "NOR (RO) Linux Kernel Image";
> +			read-only;
> +		};
> +
> +		partition@400000 {
> +			/* 27MB for Root file System */
> +			reg = <0x00400000 0x01b00000>;
> +			label = "NOR (RW) Root File System";
> +		};
> +
> +		partition@1f00000 {
> +			/* This location must not be altered  */
> +			/* 512KB for u-boot Bootloader Image */
> +			/* 512KB for u-boot Environment Variables */
> +			reg = <0x01f00000 0x00100000>;
> +			label = "NOR (RO) U-Boot Image";
> +			read-only;
> +		};

Don't put (RW) or (RO) in the label; that information is already there
in the read-only property.

The DTB and kernel image should not be read-only.

-Scott
