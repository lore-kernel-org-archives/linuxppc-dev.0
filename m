Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6AAF367D98
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 22:36:20 +1100 (EST)
Subject: Re: Flash programming using a BDI2000 on a MPC8248 CPU
From: Adrian Cox <adrian@humboldt.co.uk>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
In-Reply-To: <200611060942.05419.laurent.pinchart@tbox.biz>
References: <200611060942.05419.laurent.pinchart@tbox.biz>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 11:11:18 +0000
Message-Id: <1162811478.16089.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 09:42 +0100, Laurent Pinchart wrote:

> [INIT]
> WREG            MSR             0x00000000
> WM32            0x00010004      0xffff2081      ; SYPCR
> WM32            0x00010024      0x00000000      ; BCR
> WM32            0x00010000      0x82240000      ; SIUMCR
> WM32            0x00010c80      0x00000001      ; SCCR
> WM32            0x000119c4      0x00000000      ; RCCR
> ; Initialize the flash memory controller
> WM32            0x00010100      0x40001001      ; BR0
> WM32            0x00010104      0xf8000834      ; OR0

It looks like your workspace is in RAM, but there's nothing in the setup
above to initialise the memory controller banks for your RAM. Check that
you can read and write the workspace locations with mm and md from the
BDI command line.

-- 
Adrian Cox <adrian@humboldt.co.uk>
