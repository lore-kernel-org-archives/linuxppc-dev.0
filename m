Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id 755A0DE111
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 05:11:58 +1100 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1LhT92-0001xt-A7
	for linuxppc-dev@ozlabs.org; Wed, 11 Mar 2009 14:27:11 -0400
Message-ID: <20090311142708.olkbrtn5hws0cg8w@www.bish.net>
Date: Wed, 11 Mar 2009 14:27:08 -0400
From: Mark Bishop <mark@bish.net>
To: linuxppc-dev@ozlabs.org
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
	<A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
	<20090311120300.atgtikpneo0gos0w@www.bish.net>
	<20090311165320.GB11120@ld0162-tx32.am.freescale.net>
In-Reply-To: <20090311165320.GB11120@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Scott Wood <scottwood@freescale.com>:

> On Wed, Mar 11, 2009 at 12:03:00PM -0400, Mark Bishop wrote:
>> Yes I have actually.  I have booted a 2.6.28.6.  Same problem.
>
> I've booted many recent kernels on revA 8313ERDB; networking works fine.
> I'll try 2.6.28.6 specifically, though u-boot is acting up at the moment
> so I have to address that first. :-(
>
> Are you using the stock config and device tree from 2.6.28.6, or have you
> made any changes?
>
>> Also, is it me but at some point from 2.6.23 to 2.6.28 did they
>> started using hex numbers in the .dts file for "interrupts =3D " without
>> the 0x preamble?
>
> Yes.  dts version 0 had hex by default (with OF-like radix =20
> prefixes), and version 1 (indicated by
> /dts-v1/; at the top of the file) has decimal by default (with C-like
> radix prefixes).
>
>> I've been looking at 2.6.20, 2.6.23, and 2.6.28 .dts files for this
>> board and .28 looked way different in the interrupt section for the
>> eTSEC.
>>
>> Quoting Kumar Gala <galak@kernel.crashing.org>:
>
> Please don't top-post.
>
>> >>The boards we received didn't have SPI compiled into the kernel and
>> >>when we went to go re-compile the kernel using the 20081222 and
>> >>20080711 BSPs.  I realize that the interrupts were reversed for
>> >>eTEC1 and eTEC2 and I've made the changes in the .dtb file and I no
>> >>longer hang when I ping, etc.   But I still can't get the board on
>> >>the network.  I've verified it isn't the network settings.
>
> You're sure you're not trying to talk to the switch (which will claim
> link-up regardless of what's plugged into it)?  The non-switch ethernet
> port is eTSEC2.
>
> What *does* it do when you ping, if neither hang nor work?
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>

After remapping the IRQs, it is working now.

Any idea on what I need to do to get SPI working?  I've compiled it =20
into the kernel but don't see anything in /proc/bus
