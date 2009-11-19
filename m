Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E8D7B6F04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 04:45:49 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAJHjlm4027872
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 10:45:47 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAJHjmsd013696
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 11:45:48 -0600 (CST)
Date: Thu, 19 Nov 2009 11:45:46 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Message-ID: <20091119174546.GB6845@b07421-ec1.am.freescale.net>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-3-git-send-email-vivek.mahajan@freescale.com>
	<181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
	<2B43D645-7977-4C24-A3EF-C55A392228B4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2B43D645-7977-4C24-A3EF-C55A392228B4@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2009 at 08:29:19AM -0600, Kumar Gala wrote:
> >>+config FSL_85XX_CACHE_SRAM_BASE
> >>+	hex
> >>+	depends on FSL_85XX_CACHE_SRAM
> >>+	default "0xfff00000"
> >>+
> >
> >I really don't like setting the physical address this way, can we  
> >not do this via the device tree?
> 
> At a high level I think we should add something like the following in  
> the .dts:
> 
> sram@fff00000 {
> 	fsl,sram-ctrl-handle = <&L2>;
> 	reg = <0xfff00000 0xNNNN>;
> 	compatible = "fsl,mpc85xx-l2-sram";
> }
> 
> the NNNN can be the size the sram is configured as.

I don't see why this needs to go in the device tree, if it's the kernel
that is setting it up.  The kernel can pick any address and size it
wants.

-Scott
