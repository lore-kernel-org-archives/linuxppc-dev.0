Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E9A7DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Sep 2007 01:11:20 +1000 (EST)
Date: Tue, 25 Sep 2007 10:11:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
Message-ID: <20070925151112.GB15739@ld0162-tx32.am.freescale.net>
References: <46F6C9DC.90008@scram.de> <46F7DE85.7000401@freescale.com>
	<46F7EE95.1040509@scram.de> <46F80049.2030509@freescale.com>
	<46F8FA5F.3050907@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46F8FA5F.3050907@scram.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 02:09:03PM +0200, Jochen Friedrich wrote:
> In cpm_uart_core.c, the operation "pinfo->rx_bd_base - DPRAM_BASE" is 
> used to calculate the DPRAM offset. So DPRAM_BASE must be relative to 
> dpram_vbase in commproc.c as well. However, cpm_uart_cpm1.h uses cpmp in 
> commproc.c to initialize DPRAM_BASE.
> 
> On ARCH=ppc, cpmp is a physical address with 1:1 virtual mapping ("well 
> known address"). On ARC=powerpc, this is an address obtained by 
> ioremap(), however it's a different ioremap() call than dpram_vbase is 
> obtained from, so noone can guarantee
> cpmp is always the same as dpram_vbase even on ARCH=powerpc.

I have patches submitted in which they're from the same ioremap, but
I agree that using cpm_dpram_addr(0) is a more robust way.

-Scott
