Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03AC6DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 05:12:45 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1GICgeD011856
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 11:12:43 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n1GICfh7026283
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 12:12:42 -0600 (CST)
Date: Mon, 16 Feb 2009 12:12:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: open-pic device tree node and subnodes for additional
	functionality?
Message-ID: <20090216181241.GB18069@ld0162-tx32.am.freescale.net>
References: <59D5800B-309D-4A4E-AD1F-CEC8E2D1BE5B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59D5800B-309D-4A4E-AD1F-CEC8E2D1BE5B@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2009 at 10:58:42AM -0600, Kumar Gala wrote:
> On Freescale open-pic controllers we have a number of additional  
> features not spec'd per openpic.  (additional timers, perf mon, PCIe  
> msi, message interrupts, ...).  The problem is how to identify these  
> features in the device tree.

How about adding compatible = "fsl,CHIP-mpic", "fsl,mpic" (or something
similar) to the mpic node?

> For example we have:
> 
>                 msi@41600 {
>                         compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
>                         reg = <0x41600 0x80>;
>                         msi-available-ranges = <0 0x100>;
>                         interrupts = <
>                                 0xe0 0
>                                 0xe1 0
>                                 0xe2 0
>                                 0xe3 0
>                                 0xe4 0
>                                 0xe5 0
>                                 0xe6 0
>                                 0xe7 0>;
>                         interrupt-parent = <&mpic>;
>                 };

How much of that node's content is going to differ from one Freescale
MPIC to another?

-Scott
