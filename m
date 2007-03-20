Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E8642DDF0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 06:15:00 +1100 (EST)
In-Reply-To: <001e01c76b20$4a97b410$3a0d10ac@Radstone.Local>
References: <001e01c76b20$4a97b410$3a0d10ac@Radstone.Local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <5C40F14F-81A8-4134-99A9-2B62BBD3AF05@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Question about oprofile
Date: Tue, 20 Mar 2007 14:13:33 -0500
To: Ilya Lipovsky <lipovsky@cs.bu.edu>
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


On Mar 20, 2007, at 13:47, Ilya Lipovsky wrote:

> Hi,
>
>
>
> I am trying to understand how oprofile works, and so far I have a =20
> question:
>
> When rfi=92ing back into user context the PMM is cleared. However, if =20=

> PMM is cleared and then a context switch happens (say, to another =20
> CPU-local thread) the counters keep getting incremented. Is that =20
> right?
>
>
>
> If this is the case, then the PMC statistics account not just for =20
> the current user thread, but also for other ones as well and thus =20
> are not =93pure.=94

oprofile does not support counting just on one thread.  The PMM bit =20
is only used to make it so that the interrupt handler and setup code =20
are not counted.  In order to count in one thread, you would need to =20
modify the context switch code to allow the PMM bit to stay set on =20
marked threads, and you would need to modify the oprofile code in =20
arch/powerpc to only count when the mark bit is set (rather than when =20=

it is cleared).

Andy
