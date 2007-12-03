Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94F31DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 06:07:44 +1100 (EST)
Date: Mon, 3 Dec 2007 13:07:23 -0600
From: Matt Porter <mporter@kernel.crashing.org>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Maximum ioremap size for ppc arch?
Message-ID: <20071203190723.GB30746@gate.crashing.org>
References: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
	<20071203153009.GA30746@gate.crashing.org>
	<475441DD.9030601@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <475441DD.9030601@ovro.caltech.edu>
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

On Mon, Dec 03, 2007 at 09:50:21AM -0800, David Hawkins wrote:
> Could you comment on a similar problem I had/have.
> 
> I have a CPU with 1GB memory, and I use about 20 cPCI boards that
> I give 8MB windows in PCI space. When I was trying to load my
> custom driver with these boards, it would give me ioremap failures.
> On a CPU that had 512MB of memory it worked fine. My 'temporary hack'
> (which is still in place) for the 1GB CPUs was to add mem=512M (or 
> whatever it is) to the kernel command line. That was a good
> enough fix at the time :)
> 
> I have figured I was running out of page table entries or something
> like that and was going to investigate one of these days ...
> 
> However, perhaps it was that I was running out of address space.
> But 0xC0000000 is at 3GB, I can't see that I would be triggering
> an address space issue:
> 
> 1GB = 0x40000000
> 20 x 8MB = 160MB
> 
> But, I figured I'd ask anyway :)

Yes, same thing. There's N ways to fix it. But I see you're talking
x86.

> PS. The CPUs in this case are x86 based, while the PCI boards use
> PLX-9054 bridges. I'm building new peripheral boards with MPC8349EAs
> so this problem is going to rear its ugly head again soon, when
> I work on the drivers for the new peripheral boards.

You should be able to do something similar on x86 but the details
are TBD. I would probably try to limit low memory to 512MB in the
x86 case.

-Matt
