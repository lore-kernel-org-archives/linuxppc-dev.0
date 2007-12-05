Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDBE2DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 04:46:16 +1100 (EST)
Message-ID: <4756E3E8.8090102@freescale.com>
Date: Wed, 05 Dec 2007 11:46:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: michael.firth@bt.com
Subject: Re: Maximum ioremap size for ppc arch?
References: <36D7B34A3A79F84F82FA0C154F299F2506080F6F@E03MVX1-UKDY.domain1.systemhost.net>
In-Reply-To: <36D7B34A3A79F84F82FA0C154F299F2506080F6F@E03MVX1-UKDY.domain1.systemhost.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

michael.firth@bt.com wrote:
> My main queries are: 1) Why did changing the kernel base address to
> 0x80000000 make the system unstable?

Because there's a bug somewhere. :-)

> 2) Currently IMMRBAR has the same physical and virtual address. Does 
> this need to be the case?

No, and it is not done that way in arch/powerpc.

> 3) Why the kernel is designed to run at 0xc0000000?

My guess is because it's a number that Linus pulled out of thin air back
when a gig of RAM was unimaginably large. :-P

> This seems to leave only 1GB of addressing space for all the
> physically addressable memory (RAM + ioremapped + registers), while
> reserving 3GB of space for user processes. The 3GB is presumably
> mostly unusable on a system without a large amount of swap, as the
> 1GB limit on memory will prevent much more than that being available
> for user space.

Well, it's also useful for sparse mappings, but I agree that the 3/1 
split is probably suboptimal for most workloads.

-Scott
