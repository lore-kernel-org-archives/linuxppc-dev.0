Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19B5DDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:46:20 +1000 (EST)
In-Reply-To: <17992.64515.797925.855510@cargo.ozlabs.ibm.com>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
	<17992.64515.797925.855510@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <66b16b11858147b8790b70416fd3833a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Date: Tue, 15 May 2007 06:33:51 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> This is wrong -- there are systems with ISA that
>> also have PCI devices that require 16-bit legacy
>> I/O windows (e.g., systems with the AMD8111 chip,
>> like Maple).
>
> If they are PCI devices and their drivers use a pci_dev's resources
> to get to the device's I/O resources, then they are fine.
>
> The only reason for reserving the low 64k is to cater for drivers that
> use a hard-coded port number, e.g. video drivers using the VGA port
> numbers.  We have been gradually getting rid of the hard coded port
> numbers in drivers but I don't think they're all gone yet.

Yes, I misunderstood (that teaches me for reading the
patch description only, not the patch itself :-) ).

Ben, can we have a config option to _not_ create a
mapping for the legacy hardcoded stuff, even if there
is an "isa" device node?  Some platforms do not need
it or want it, and it can help find the remaining
drivers that do this x86 nastiness.


Segher
