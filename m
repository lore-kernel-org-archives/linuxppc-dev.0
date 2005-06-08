Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1C42067B22
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 01:34:07 +1000 (EST)
In-Reply-To: <20050607225210.A28898@cox.net>
References: <20050607225210.A28898@cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <609b05dd2d9806d7d1cd68696b1f49e2@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 8 Jun 2005 10:34:03 -0500
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][4/5] RapidIO support: ppc32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 8, 2005, at 12:52 AM, Matt Porter wrote:

> On Tue, Jun 07, 2005 at 11:43:26PM -0500, Kumar Gala wrote:
>> Two questions:
>> 1. how well does will all of this handle > 32-bit phys addr?
>
> It does and it doesn't handle > 32-bit phys addr. It depends on which
> configuration you are talking about.  If you are talking about I/O
>> 32-bit, it's no problem.  If you are talking about handling DMA
>> 32-bit,
> then we need to handle a 64-bit DMA addr in the ppc32 implementations
> and
> also extend the arch messaging interface to let callers know when an
> implementation can handle high DMA (system memory >4GB). This is all
> pretty easy to handle once we need to support such a processor. So
> far, nothing is available publicly. :)

Well 8548 is semi-public :)

> For RIO MMIO purposes (which is functionality I'm working on now),
> it has the similar issues that PCI memory space has on processors with
> I/O above 4GB.  However, on RIO our resources hold a bus address since
> a physical address doesn't make sense since address spaces our
> per-device.
> If we ever support a 66-bit address space device on 32-bit processor, 
> we
> might need a u64 resource.

I assume you mean 36-bit, what would one do with 66-bit addresses :)

>> 2. can we make any of this a platform driver?
>
> Hrm, so you would rather see RIO host bridges look like a driver
> on another "bus"?  I have seen them as a component just like PCI
> host bridges.  That is, they are instantiated by arch-code and
> then initialized by a subsys initcall. This does mean that we
> will be enumerating much later (during driver initcalls), but
> it might be a better model if we ever see a rumored PCIE->RIO
> bridge. Supporting that as a RIO master port would require driver
> time init of the RIO fabric. There's some ordering issues that we'd
> have to see about working out. None of this is needed right now,
> though.
>
>> I would prefer if we could have the memory offsets and irq's not be
>> straight from the #define's
>
> I think this and #2 are separate issues. We can pass the mpc85xx
> rio init code some parameters to abstract things to different
> parts. This is similar to how we init different SoC's PCI host
> bridges with some common code on PPC32 (marvell, 85xx, etc).
>
> I was just looking at doing this to support RIO on the 8548. At
> the time I wrote this 85xx support there wasn't any info on the
> 8548 available, but it's an easy thing to extend.

Agreed, they are separate issues, I'm cool on waiting to see what 
happens with RIO <-> PCIE bridges in the future.  For now if you can 
look at abstracting the offset, irq info that would be good (especially 
since 8548 does msg'g a bit differently).

- kumar
