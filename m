Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 03EC267B21
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 07:25:05 +1100 (EST)
Message-ID: <44230481.5040500@ovro.caltech.edu>
Date: Thu, 23 Mar 2006 12:26:41 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com><204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org><4422D6E3.1010407@ovro.caltech.edu>	<CCA437BF-E204-4652-9E6D-25388225EFE8@kernel.crashing.org>
	<00be01c64ea1$4c6e0e20$6401a8c0@CHUCK2>
	<4422E0CB.8080701@ovro.caltech.edu>
	<00c701c64eb3$c23b0c40$6401a8c0@CHUCK2>
In-Reply-To: <00c701c64eb3$c23b0c40$6401a8c0@CHUCK2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Mark,

> Ok, I should be a little more specific.

Ok :)

> Yes, I/O space is little endian, and any configuration
> registers and such are little endian.  But memory space
> is strictly 32 bit as far as PCI is concerned.
> (forgetting 64 bit PCI for the moment) The two lower
> bits of address are not used, and there is no required 
> correlation of byte enables to those missing address bits.
> 
> So, the point is, Freescale swaps bytes between its internal
> bus and PCI.  Other processors (like TI DSPs) do not.  I
> don't know that one method is necessarily right, but the fact
> that we have this discussion periodically suggests that Freescale's 
> method is not the best.

Hmm, I'd have to look on the PCI bus with the analyzer to
confirm this ... but I do recall seeing a mapping of
the 128-bit PLB to PCI bus in the 440EP manual, so
you're probably right.

The PLX PCI-9054 has an 'endianness' option like this too.
I believe its so you can use a PPC on the local bus, and
swap bytes when the are written onto the PCI bus.
Sounds like the Freescale SoC bridges have just hardcoded
that type of implementation.

> This might be an academic point, but I think it does help to
> see the distinction.  To talk to a device over PCI you must
> know how both ends map their internal buss(es) to PCI,
> and it's not directly a big/little endian issue.

Its nice to be aware of these subtle differences.

Thanks for the discussion.

Dave
