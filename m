Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F7D2DDED6
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 05:00:19 +1000 (EST)
Date: Thu, 1 May 2008 14:01:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Ronald Madrid <ron_madrid@hotmail.com>
Subject: Re: NAND command line partiions
Message-ID: <20080501190104.GA2645@loki.buserror.net>
References: <1410.216.70.248.131.1209657620.squirrel@mechanicalanarchy.com>
	<BAY114-W26E8656DD55138DB5CC3A6F4DB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY114-W26E8656DD55138DB5CC3A6F4DB0@phx.gbl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 01, 2008 at 11:24:35AM -0700, Ronald Madrid wrote:
> I am using u-boot-1.3.1 in order to boot linux 2.6.25 on a custom MPC8313
> based board.  In past versions of the kernel I was able to pass the NAND
> partition information to the kernel with this line: root=/dev/mtdblock2
> rootfstype=jffs2 rw console=ttyS0,115200
> mtdparts=nand0:1M(u-boot),3M(kernel),-(jffs2).  In this latest version the
> kernel will not mount the partitions because the name that is parsed from
> the command line (nand0) is different from that of the name of the NAND
> that comes from ./drivers/mtd/nand/nand_ids.c (NAND 256MiB 3,3V 8-bit).

This is fixed in the current mtd tree (commit 9ebed3e60f9, fsl_elbc_nand:
fix mtd name).

> I have tried to change the name of the NAND that is passed in via the
> command line, but u-boot does not seem to like the format of the name that
> linux compares against.  It doesn't like the ,(comma) in 3,3V.

Why would u-boot care about the format of the kernel command line?

-Scott
