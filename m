Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 769F0DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 07:02:22 +1100 (EST)
Message-ID: <45AFD24B.5070608@freescale.com>
Date: Thu, 18 Jan 2007 14:02:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
References: <OF27AFB204.D453295B-ON88257267.0011100B-88257267.00158710@selinc.com>
In-Reply-To: <OF27AFB204.D453295B-ON88257267.0011100B-88257267.00158710@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Bruce_Leonard@selinc.com wrote:

>>> anything in the source.  I don't want to clutter up the mailing 
>>> list with
>>> newbie questions so I'd like to get in touch with the person who 

I'm the maintainer.

> Well, okay.  I hate taking up bandwidth for something that's no doubt 
> trivial to most of you, but here goes.  I'm trying to bring up the 
> 2.6.19.1 kernel using u-boot 1.1.6 on the MPC8349ITX board and I'm having 

1.1.6 does not support the MPC8349ITX.  Try 1.2.0.  My name is listed as the 
maintainer for this board in the U-Boot MAINTAINERS file.

> problems with the open firmware part of it (which I am TOTALLY new to). 
> Short version, I don't think the *.dts file for this board is correct and 
> I'm wondering if anyone might have a newer version or good documentation 
> as to the formatting of the *.dts files?
> 
> Long version: While booting the kernel it seems to hang in the do_div() 
> call on line 933 of .../arch/powerpc/kernel/time.c (yes I know it's not 
> really a call but inline assembly) because ppc_tb_freq is zero.  The 
> get_freq() calls in generic_calibrate_decr() find the 'timebase-frequency' 
> and 'clock-frequency' entries in the device tree, but the value is zero 
> and thus ppc_tb_freq is zero.
> 
> Digging through the u-boot code, I found ft_setup() which is supposed to 
> add some stuff to the device tree passed in on the bootm command line. One 
> of the things it's supposed to do is fill in the 'timebase-frequency' 
> portion of the device tree.  When it calls ft_get_prop() to find the 
> 'timebase-frequency' node it passes in the path 
> '/cpus/PowerPC,8349@0/timebase-frequency' as what it's searching for, but 
> what ft_get_prop() finds is 
> '///cpus//cpus/PowerPC,8349@0/timebase-frequency', which of course doesn't 
> match, so it returns NULL to ft_setup() and the 'timebase-frequency' never 
> gets updated before being passed to the kernel.

This sounds like a generic bug in the U-Boot OF code, but I'll check it out. 
The DTS for the 8349ITX is defined just like the other DTSes.

> So I'm guessing the my problem is either the *.dts file or dtc, but I'm 

Hmmm, it could be the DTC.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
