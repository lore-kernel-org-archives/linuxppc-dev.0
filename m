Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 32964DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 22:09:37 +1000 (EST)
Message-ID: <46F8FA5F.3050907@scram.de>
Date: Tue, 25 Sep 2007 14:09:03 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
References: <46F6C9DC.90008@scram.de> <46F7DE85.7000401@freescale.com>
	<46F7EE95.1040509@scram.de> <46F80049.2030509@freescale.com>
In-Reply-To: <46F80049.2030509@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Scott,
> Yikes.  Please don't change cpm_uart_cpm1.h, as it's correct for 
> arch/powerpc, and there are numerous other places that assume cpmp is 
> virtual (including in the very same function that assigns it a 
> physical address).

I'm still not convinced cpm_uart_cpm1.h is correct:

pinfo->rx_bd_base and pinfo->tx_bd_base are both initialized with an 
address obtained by cpm_dpram_addr(). In both ppc and powerpc, this is 
an address relative to dpram_vbase in commproc.c

In cpm_uart_core.c, the operation "pinfo->rx_bd_base - DPRAM_BASE" is 
used to calculate the DPRAM offset. So DPRAM_BASE must be relative to 
dpram_vbase in commproc.c as well. However, cpm_uart_cpm1.h uses cpmp in 
commproc.c to initialize DPRAM_BASE.

On ARCH=ppc, cpmp is a physical address with 1:1 virtual mapping ("well 
known address"). On ARC=powerpc, this is an address obtained by 
ioremap(), however it's a different ioremap() call than dpram_vbase is 
obtained from, so noone can guarantee
cpmp is always the same as dpram_vbase even on ARCH=powerpc.

To me, it looks like setting DPRAM_BASE to cpm_dpram_addr(0) is the fix 
as it makes the DPRAM offset a defined result.

Thanks,
Jochen
