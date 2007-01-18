Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id B82BEDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 14:55:21 +1100 (EST)
In-Reply-To: <71718296-E8FC-48B0-9A8E-F2F54373C94E@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
MIME-Version: 1.0
Message-ID: <OF27AFB204.D453295B-ON88257267.0011100B-88257267.00158710@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 17 Jan 2007 19:55:08 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 01/17/2007 
07:42:09 AM:

> 
> On Jan 17, 2007, at 12:27 AM, Bruce_Leonard@selinc.com wrote:
> 
> > anything in the source.  I don't want to clutter up the mailing 
> > list with
> > newbie questions so I'd like to get in touch with the person who 
> 
> Ask the questions on the list, thus they are around for others to 
> learn from if need by.
> 
> - kumar
> 
Well, okay.  I hate taking up bandwidth for something that's no doubt 
trivial to most of you, but here goes.  I'm trying to bring up the 
2.6.19.1 kernel using u-boot 1.1.6 on the MPC8349ITX board and I'm having 
problems with the open firmware part of it (which I am TOTALLY new to). 
Short version, I don't think the *.dts file for this board is correct and 
I'm wondering if anyone might have a newer version or good documentation 
as to the formatting of the *.dts files?

Long version: While booting the kernel it seems to hang in the do_div() 
call on line 933 of .../arch/powerpc/kernel/time.c (yes I know it's not 
really a call but inline assembly) because ppc_tb_freq is zero.  The 
get_freq() calls in generic_calibrate_decr() find the 'timebase-frequency' 
and 'clock-frequency' entries in the device tree, but the value is zero 
and thus ppc_tb_freq is zero.

Digging through the u-boot code, I found ft_setup() which is supposed to 
add some stuff to the device tree passed in on the bootm command line. One 
of the things it's supposed to do is fill in the 'timebase-frequency' 
portion of the device tree.  When it calls ft_get_prop() to find the 
'timebase-frequency' node it passes in the path 
'/cpus/PowerPC,8349@0/timebase-frequency' as what it's searching for, but 
what ft_get_prop() finds is 
'///cpus//cpus/PowerPC,8349@0/timebase-frequency', which of course doesn't 
match, so it returns NULL to ft_setup() and the 'timebase-frequency' never 
gets updated before being passed to the kernel.

So I'm guessing the my problem is either the *.dts file or dtc, but I'm 
not sure which since I'm so new to this and I'm not sure if the *.dts file 
I've got is properly formatted.  I suppose it's possible that 
ft_get_prop() in u-boot is wrong, but for now I'm betting it's right and 
my *.dts file is formatted wrong.  (FYI, I'm using 
.../arch/powerpc/boot/dts/mpc8349emitx.dts from the 2.6.19.1 kernel tree.)

Thanks for listening and for your feedback.

Bruce
