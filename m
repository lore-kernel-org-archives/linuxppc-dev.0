Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC146DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 03:15:27 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2RGFN4U010978
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 09:15:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2RGFMih025092
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 11:15:23 -0500 (CDT)
Date: Fri, 27 Mar 2009 11:15:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: chmhou <chmhou@sina.com>
Subject: Re: issue at the beginning of kernel booting
Message-ID: <20090327161522.GA7809@ld0162-tx32.am.freescale.net>
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 04:36:28PM +0800, chmhou wrote:
> there is something confused me, which is my kernel code is halt because of something wrong i have no hint about it.
> my bootloader is u-boot, version is 1.1.4, kernel version is 2.6.14.1, processor is MPC8247.

That is very old code; you're more likely to get help when running
something up-to-date.

> u-boot have run on the board already. bootloader booting information as follow:
> U-Boot 1.1.4 (Mar 22 2009 - 20:30:57)
> MPC8272 Reset Status: External Soft, External Hard
> MPC8272 Clock Configuration
> &nbsp;- Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq&nbsp; 25-75 , Core Freq 100-300
> &nbsp;- dfbrg 1, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
> &nbsp;- vco_out&nbsp; 400000000, scc_clk&nbsp; 100000000, brg_clk&nbsp;&nbsp; 25000000
> &nbsp;- cpu_clk&nbsp; 400000000, cpm_clk&nbsp; 200000000, bus_clk&nbsp; 100000000

This alternative was listed as text/plain.  &nbsp is not plaintext. 
Please fix your mailer (and better yet, don't send HTML at all).

> by LEDs i am sure that it surely performs in kernel. then by sequence
> early_init, mmu_off, clear_bats and flush_tlbs. at call_setup_cpu, the
> performing is halt, i get "bl call_setup_cpu" will invoke
> setup_common_caches actually. right here, enable caches for 603e by
> HID0, get HID0 register and setting DCE and ICE bit put into HID0
> register, the performing halt.

I doubt that it is actually halting here; more likely, you're just
hitting a spot in the boot sequence where it's not safe to access your
LEDs or other I/O, because you have the MMU off and the cache enabled.

You'll typically be much better off leaving the very early code alone
(it's almost never the culprit), except to ensure that you have a BAT
mapping (cache-inhibited and guarded) for the I/O you want to use for
debugging.  Then, only touch that I/O device *after* the MMU is on and
your mapping is in place.

-Scott
