Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36CB7B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 05:55:26 +1100 (EST)
Message-ID: <4F283913.3010001@freescale.com>
Date: Tue, 31 Jan 2012 12:55:15 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhicheng Fan <B32736@freescale.com>
Subject: Re: [PATCH 1/2 v2] powerpc/dts: Add dts for p1020rdb-pc
References: <y> <1327993614-25915-1-git-send-email-B32736@freescale.com>
In-Reply-To: <1327993614-25915-1-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2012 01:06 AM, Zhicheng Fan wrote:
> +&lbc {
> +	nor@0,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "cfi-flash";
> +		reg = <0x0 0x0 0x1000000>;
> +		bank-width = <2>;
> +		device-width = <1>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 256KB for Vitesse 7385 Switch firmware */
> +			reg = <0x0 0x00040000>;
> +			label = "NOR (RO) Vitesse-7385 Firmware";
> +			read-only;
> +		};
> +
> +		partition@40000 {
> +			/* 256KB for DTB Image */
> +			reg = <0x00040000 0x00040000>;
> +			label = "NOR (RO) DTB Image";
> +			read-only;
> +		};
> +
> +		partition@80000 {
> +			/* 3.5 MB for Linux Kernel Image */
> +			reg = <0x00080000 0x00380000>;
> +			label = "NOR (RO) Linux Kernel Image";
> +			read-only;
> +		};
> +
> +		partition@400000 {
> +			/* 11MB for JFFS2 based Root file System */
> +			reg = <0x00400000 0x00b00000>;
> +			label = "NOR (RW) JFFS2 Root File System";
> +		};
> +
> +		partition@f00000 {
> +			/* This location must not be altered  */
> +			/* 512KB for u-boot Bootloader Image */
> +			/* 512KB for u-boot Environment Variables */
> +			reg = <0x00f00000 0x00100000>;
> +			label = "NOR (RO) U-Boot Image";
> +			read-only;
> +		};
> +	};
> +
> +	nand@1,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,p1020-fcm-nand",
> +			     "fsl,elbc-fcm-nand";
> +		reg = <0x1 0x0 0x40000>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 1MB for u-boot Bootloader Image */
> +			reg = <0x0 0x00100000>;
> +			label = "NAND (RO) U-Boot Image";
> +			read-only;
> +		};
> +
> +		partition@100000 {
> +			/* 1MB for DTB Image */
> +			reg = <0x00100000 0x00100000>;
> +			label = "NAND (RO) DTB Image";
> +			read-only;
> +		};
> +
> +		partition@200000 {
> +			/* 4MB for Linux Kernel Image */
> +			reg = <0x00200000 0x00400000>;
> +			label = "NAND (RO) Linux Kernel Image";
> +			read-only;
> +		};
> +
> +		partition@600000 {
> +			/* 4MB for Compressed Root file System Image */
> +			reg = <0x00600000 0x00400000>;
> +			label = "NAND (RO) Compressed RFS Image";
> +			read-only;
> +		};
> +
> +		partition@a00000 {
> +			/* 7MB for JFFS2 based Root file System */
> +			reg = <0x00a00000 0x00700000>;
> +			label = "NAND (RW) JFFS2 Root File System";
> +		};
> +
> +		partition@1100000 {
> +			/* 15MB for JFFS2 based Root file System */
> +			reg = <0x01100000 0x00f00000>;
> +			label = "NAND (RW) Writable User area";
> +		};
> +	};

Please remove (RO) and (RW) -- this duplicates information provided by
the read-only property.

Please only mark partitions read-only when they could brick the board if
overwritten.  Things like the Linux kernel, RFS, and DTB should not be
read-only.

> +/include/ "p1020rdb-pc.dts"
> +
> +/ {
> +	model = "fsl,P1020RDB-PC";
> +	compatible = "fsl,P1020RDB-PC", "fsl,MPC85XXRDB-CAMP";

Eliminate fsl,MPC85XXRDB-CAMP.  Specify pic-no-reset on the mpic node
instead.

-Scott
