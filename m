Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6DFCDDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 01:52:57 +1100 (EST)
In-Reply-To: <000001c74988$ea7d7960$6405a8c0@absolut>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
	<001101c746e3$5b8dab00$6405a8c0@absolut>
	<A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
	<000001c74988$ea7d7960$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE4BEEDF-4C34-418D-9AEC-A4A200DDDAF5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8360 : PCI resource allocate error
Date: Tue, 6 Feb 2007 08:51:43 -0600
To: <rmcguire@videopresence.com>
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


On Feb 5, 2007, at 6:51 PM, Russell McGuire wrote:

>
> I think I might be getting someplace on this debugging of the PCI  
> slots.
>
> I solved the erratic SLOT 3 issue, it was a hardware problem. A net  
> was
> unconnected, I should shoot the designer. Anyway, this was fixed  
> that so all
> slots are 100% consistent.
>
> I think general issue is probably a setup problem with the PCI  
> bridge chip.
> Though I do not know how U-boot and Linux set up the bridge.
>
> But after reading through the Bridge documentation, I have learned  
> that each
> bus must have the memory map declared in it, for all three memory  
> spaces.
> I.e. the base and the upper limit for each mem, mmio, and IO space.
>
> When I boot into Linux, with PCI cards plugged in, and I read these
> registers it looks as if the base address is correct, but the upper  
> limit is
> actually set one byte below the base address. To me this effectively
> prevents all access to the memory region, halting it at the bridge  
> chip.
> Would explain why the only region I can seem to read is the  
> configuration
> space.
>
> I guess the question is, does Linux only enable these ranges if a  
> card is
> actively using them. Or is BIOS supposed to have these enabled  
> before the OS
> gets access to the bridge?

In theory Linux should be able to handle this, in practice its easier  
to have u-boot setup the bridges.

I'd ask around on the u-boot list about how to use the u-boot  
mechanisms to preconfigure devices (if its not obvious from the code).

- k
