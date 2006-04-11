Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 9EB9267A5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 13:54:36 +1000 (EST)
Message-ID: <443B27E6.8070607@ovro.caltech.edu>
Date: Mon, 10 Apr 2006 20:52:06 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Subject: Re: Create permanent mapping from PCI bus to region of physical memory
References: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B0718.3050001@ovro.caltech.edu>
	<91B22F93A880FA48879475E134D6F0BE386FBC@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B1EE9.5030104@ovro.caltech.edu>
	<91B22F93A880FA48879475E134D6F0BE386FBD@CA1EXCLV02.adcorp.kla-tencor.com>
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE386FBD@CA1EXCLV02.adcorp.kla-tencor.com>
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



> Not if you're tight on routing resouces and/or design time ;-)

Yep, understood.

> Dave, I appreciate your input but scatter/gather just isn't
> an option here for a variety of reasons.  Bandwidth/complexity/
> latency/time to design/time to debug/FPGA density all
> factor into this decision.  BTW we're talking 66/64 PCI-X;
> 33/32 PCI isn't nearly fast enough.

No problem.

> Nope, I disagree.  The MMU isn't involved here at all.  I'm
> talking about setting up the PIM (PCI Inbound Map) via
> a system call as opposed to just writing it directly.

The MMU is involved since its responsible for all memory,
i.e., Linux is told that all physical memory is under
its control. I haven't looked at the PCI inbound map,
but I would assume that it can be setup to say map all
of the incoming PCI addresses to all of the SDRAM
addresses, or some block thereof. So the FPGA can see physical
pages that Linux is busy swapping data into and out of.
What you are wanting to do is tell Linux to lay-off
managing a block of SDRAM, but make it visible to the
kernel as a memory area.

So, you need the kernel to setup page tables that map
to those physical addresses and you need to tell Linux
not to treat them like it does the rest of SDRAM.

So I believe the MMU/page tables are involved.

> I really can't go into detail about my application for a
> variety of reasons (both technical and legal) but suffice
> it to say that 16 MB is just the starting point.

No sweat, it never hurts to ask.

> I guess I'll dig a little deeper into the source to see
> where the kernel does the PIM mapping.  Re-architecting
> our app at this stage just isn't a practical consideration.

You always have the hack of reserving a block of memory
at the top of SDRAM, i.e., lie to Linux and tell it it
has less memory. It sounds like that might be the least
effort. Rubini has an example of how to do that.

Dave
