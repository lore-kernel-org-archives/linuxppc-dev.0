Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71CF2DE238
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:53:26 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2BGrL8D010715
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:53:21 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2BGrKBv015285
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:53:21 -0500 (CDT)
Date: Wed, 11 Mar 2009 11:53:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mark Bishop <mark@bish.net>
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
Message-ID: <20090311165320.GB11120@ld0162-tx32.am.freescale.net>
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
	<A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
	<20090311120300.atgtikpneo0gos0w@www.bish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090311120300.atgtikpneo0gos0w@www.bish.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 12:03:00PM -0400, Mark Bishop wrote:
> Yes I have actually.  I have booted a 2.6.28.6.  Same problem.

I've booted many recent kernels on revA 8313ERDB; networking works fine. 
I'll try 2.6.28.6 specifically, though u-boot is acting up at the moment
so I have to address that first. :-(

Are you using the stock config and device tree from 2.6.28.6, or have you
made any changes?

> Also, is it me but at some point from 2.6.23 to 2.6.28 did they  
> started using hex numbers in the .dts file for "interrupts = " without  
> the 0x preamble?

Yes.  dts version 0 had hex by default (with OF-like radix prefixes), and version 1 (indicated by
/dts-v1/; at the top of the file) has decimal by default (with C-like
radix prefixes).

> I've been looking at 2.6.20, 2.6.23, and 2.6.28 .dts files for this  
> board and .28 looked way different in the interrupt section for the  
> eTSEC.
> 
> Quoting Kumar Gala <galak@kernel.crashing.org>:

Please don't top-post.

> >>The boards we received didn't have SPI compiled into the kernel and  
> >>when we went to go re-compile the kernel using the 20081222 and  
> >>20080711 BSPs.  I realize that the interrupts were reversed for  
> >>eTEC1 and eTEC2 and I've made the changes in the .dtb file and I no  
> >>longer hang when I ping, etc.   But I still can't get the board on  
> >>the network.  I've verified it isn't the network settings.

You're sure you're not trying to talk to the switch (which will claim
link-up regardless of what's plugged into it)?  The non-switch ethernet
port is eTSEC2.

What *does* it do when you ping, if neither hang nor work?

-Scott
