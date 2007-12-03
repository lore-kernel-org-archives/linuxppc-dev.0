Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13D56DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 02:30:21 +1100 (EST)
Date: Mon, 3 Dec 2007 09:30:09 -0600
From: Matt Porter <mporter@kernel.crashing.org>
To: michael.firth@bt.com
Subject: Re: Maximum ioremap size for ppc arch?
Message-ID: <20071203153009.GA30746@gate.crashing.org>
References: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
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

On Mon, Dec 03, 2007 at 09:22:06AM -0000, michael.firth@bt.com wrote:
> I'm trying to get am MPC834x system running that has 256MBytes of NOR
> flash connected.
> 
> The physmap flash driver is failing to ioremap() that amount of space,
> while on a similar system with 128Mbytes of flash, there are no
> problems.
> 
> Is this a known limitation of ioremap() on the ppc architecture, or
> specifically the MPC834x family, and is there any (hopefully easy) way
> to increase this limit?

The answer is "it depends". It depends on the amount of system memory
you have. By default, your system memory is mapped at 0xc0000000, leaving
not enough space for vmalloc allocations to grab 256MB for the
ioremap (and avoid the fixed virtual mapping in the high virtual
address area).

See the "Advanced setup" menu. Normally, you can set "Set custom kernel
base address" to 0xa0000000 safely. That will give you an additional
256MB of vmalloc space. On arch/powerpc, you'll also have to set
"Size of user task space" to 0x80000000 or 0xa0000000.

-Matt
