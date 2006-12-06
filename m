Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B733367C71
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 08:59:49 +1100 (EST)
In-Reply-To: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
References: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9A5124B0-DA40-4994-BFBC-73ED9DB72E86@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Change the program check exception from EXC_XFER_STD
	to EXC_XFER_EE.
Date: Wed, 6 Dec 2006 15:59:37 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 6, 2006, at 3:50 PM, Scott Wood wrote:

> This patch causes interrupts to be enabled in  
> program_check_exception()
> if they were enabled in the faulting context.  This is required  
> because
> do_mathemu() calls get_user(), which can sleep, and thus triggers an
> assertion if called with interrupts disabled.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Is there any reason why ProgramCheck needs to be EXC_XFER_STD?  Has
> nobody ever used math emulation with CONFIG_DEBUG_SPINLOCK_SLEEP  
> before?

This has come up before and I think our desired solution is to use  
use local_irq_enable() in traps.c.  For some reason we didn't realize  
that we needed to fix the do_mathemu() path.

Take a look at the following threads:
http://lkml.org/lkml/2006/2/22/243
http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025016.html
http://git.kernel.org/git/?p=linux/kernel/git/paulus/ 
powerpc.git;a=commitdiff;h=cd8a5673e9abb3fde0a1c25ee63a60fe1908c6f5

- kumar
