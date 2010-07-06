Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8AF4B6EF2
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jul 2010 06:21:15 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o66KLCNi008650
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jul 2010 13:21:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o66KXoMV026112
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jul 2010 15:33:50 -0500 (CDT)
Date: Tue, 6 Jul 2010 15:21:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
Message-ID: <20100706152110.4f25e96b@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 5 Jul 2010 00:23:45 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> Hi,
> 
> I'm debugging the kernel (2.6.33.5) ported for a MPC870 board. The
> changes are mostly based on the board adder875. The first thing I want
> to test is the serial port. So I enabled CONFIG_PPC_EARLY_DEBUG and
> CONFIG_PPC_EARLY_DEBUG_CPM, and changed
> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR to 0xfa202008. My IMMR is 0xfa200000.
> However the kernel seems to stuck at udbg_putc_cpm(). The most
> significant bit at 0xfa202008 never changed to zero.

Hmm... try 0xfa203bf8 (assuming your muram/data node has reg = <0
0x1c00>). It looks like commit c2dd3529f35de9e2f51eba9bbf9969f5dc8382d4
changed the bootwrapper's cpm-serial driver to allocate from the end of
MURAM instead of the beginning, but updated
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR to match only on CPM2, not CPM1.

> 2. When the execution was interrupted, it stopped at __delay(). And
> the kernel seems not able to get out of this __delay() function.

Could the kernel have crashed, and is waiting the 180 seconds to
reboot?  Try doing a stack trace, and/or dumping the kernel's log
buffer.

> There was even no symbols for local variables. Why?

Optimized away.

> Next I set the breakpoint at probe_machine(). The gdb session is shown
> below. Again a couple of frustrating observations.
> 1. The kernel seems not able to get into the for loop. The breakpoint
> set inside the for loop never got hit.

Check the actual assembly code, see if the breakpoint is at an address
that makes sense.

-Scott
