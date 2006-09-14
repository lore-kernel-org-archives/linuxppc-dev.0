Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 315B167B5A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 08:02:30 +1000 (EST)
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id k8EM2R5x020933
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 15:02:28 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id k8EM2R6d029919
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 17:02:27 -0500 (CDT)
Date: Thu, 14 Sep 2006 17:02:24 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: Keith J Outwater <kjoutwater@raytheon.com>, john.bonesio@xilinx.com
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <OF1385C39A.BEB9B9E6-ON072571E9.005DAC98-072571E9.0060ABAE@mck.us.ray.com>
Message-ID: <Pine.WNT.4.61.0609141647450.2448@holyoke.labs.mot.com>
References: <OF1385C39A.BEB9B9E6-ON072571E9.005DAC98-072571E9.0060ABAE@mck.us.ray.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> << The Xilinx approach of overwriting the source tree just feels wrong,
>> and
>> no one seems to want to do it that way.>>
>>
>> I am in the group that has control over how this is done. What would you
>> propose be done different? Keep in mind that we are trying to support a
>> process where someone builds a hardware design and the later changes it
>> with new peripherals or perhaps makes minor tweaks. We want to make the
>> updating of the Linux kernel to reflect these hardware changes easy for
>> people.
>
> A noble goal, and clearly the right thing to do from a user-success point
> of view, but do the hardware peripherals (i.e. the IP cores) change that
> much?

Driver-per-version (i.e. separate drivers for 'xilinx_emac_1_00_b', 1_00_c,
etc.) is the most obvious but unlikely to be accepted, and it would lead to
lots of duplicated code.  How about having a single driver that supports
all versions of xilinx_emac, and adding the specific IP version info in the
kernel config?  So we would have, for example, CONFIG_XILINX_ENET_1_00_C,
or whatever, in addition to or in place of CONFIG_XILINX_ENET.  The neces-
sary adjustments would generally be made via conditionally compiled code in
the driver source, or in the driver's Makefile when the version differences
are larger in scope.

>From what I've seen this is pretty consistent with The Kernel Way...  And
it'd force the kernel builder to be aware of what IP version(s) are in
their hardware.

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
