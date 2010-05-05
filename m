Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86001B7D5E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 03:38:55 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o45HcpMf020396 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 5 May 2010 10:38:52 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o45Hcu5q023875
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 5 May 2010 12:38:56 -0500 (CDT)
Date: Wed, 5 May 2010 12:38:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: xiaokun <xiaokun@sf-auto.com>
Subject: Re: question about cpm_uart_cpm2.c "Section mismatch in reference
	from the function cpm_uart_allocbuf"
Message-ID: <20100505173851.GA13294@schlenkerla.am.freescale.net>
References: <022701caec44$cd936280$9c1cbcc0@sfdomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <022701caec44$cd936280$9c1cbcc0@sfdomain.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 05, 2010 at 07:19:18PM +0800, xiaokun wrote:
> I am using MPC8272ADS_20080623-ltib.iso from freescale
> 
> The Linux Kernel is 2.6.25.
> 
> When I make uImage, the error message is :
> 
> WARNING: vmlinux.o(.text+0x159450): Section mismatch in reference from the function cpm_uart_allocbuf() to the function .init.text:__alloc_bootmem()
> The function cpm_uart_allocbuf() references
> the function __init __alloc_bootmem().
> This is often because cpm_uart_allocbuf lacks a __init
> annotation or the annotation of __alloc_bootmem is wrong.

That is expected, ignore it.

The function is called early enough to need to use bootmem, and called again
too late for __init.  It determines which to use based on whether it was
called to set up the console or not.

Note that the problem no longer exists in current kernels because kmalloc is
usable earlier.

-Scott
