Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A44DA67BA3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:32:31 +1100 (EST)
Date: Fri, 10 Feb 2006 18:23:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: atul.sabharwal@exgate.tek.com
Subject: RE: kernel startup
In-Reply-To: <4A062D477D842B4C8FC48EA5AF2D41F201BA2089@us-bv-m23.global.tektronix.net>
Message-ID: <Pine.LNX.4.44.0602101823290.31619-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 10 Feb 2006 atul.sabharwal@exgate.tek.com wrote:

> >>I'm not that familiar with 8xx, but can't you move IMMR?
> 
> Not much choice with IMMR as it can be 0x0 or 0x00f00000 or 0xFF000000
> Or 0xFFF00000.  
> 
> Flash is from 0xfe000000 thru 0xffffffff.  Now on POR,
> Processor goes to offset 0x100 on CS0.  So, if IMMR is overlapping with
> flash, it might not boot.
> 
> On 870, it seems that reset value for BR0/OR0 is undefined.
> Data fetch goes on CS0 and then in cpu_init_f BR0 & OR0
> Are remapped.  So, I could put flash at a non-standard address like
> 0xDE000000 and move IMMR to 0xFF000000.
> 
> The problem this creates is that I can set IIP to 0 or 1. So, exception
> Vector prefix can be 0 or 0xfff.  Since no flash at 0xfff00000 base 
> Address I cannot have any exceptions in my code till the u-boot code
> has relocated to RAM.  Which should be acceptable as what can I do
> if there is exception so early in the system. 
> 
> Unless there is a better design ?

It sounds like you should move this discussion to the u-boot list since it 
has very little to do with the kernel.

- k
