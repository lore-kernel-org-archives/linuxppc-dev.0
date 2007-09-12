Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7285DDF70
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:10:02 +1000 (EST)
In-Reply-To: <1DE5CB62-9EF1-42BA-93F3-CE15DD94F5DD@kernel.crashing.org>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
	<20070911141711.GE1932@ld0162-tx32.am.freescale.net>
	<1DE5CB62-9EF1-42BA-93F3-CE15DD94F5DD@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6b92503d73565f8add983e64ad5d5d39@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 15:20:25 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		l2-cache-controller@20000 {
>>> +			compatible = "fsl,8572-l2-cache-controller";
>>> +			reg = <20000 1000>;
>>> +			cache-line-size = <20>;	// 32 bytes
>>> +			cache-size = <80000>;	// L2, 512K
>>> +			interrupt-parent = <&mpic>;
>>> +			interrupts = <10 2>;
>>> +		};
>>
>> Should this node be referenced by an l2-cache property in the cpu
>> node?
>
> No, its a front side cache.

What is a "front side cache"?  What exactly does it cache?  If it's
a cache for one CPU only, that fact should be shown in the device
tree somehow.

>>> +			device_type = "pci";
>>> +			#interrupt-cells = <1>;
>>> +			#size-cells = <2>;
>>> +			#address-cells = <3>;
>>> +			reg = <8000 1000>;
>>> +			bus-range = <0 ff>;
>>> +			ranges = <02000000 0 80000000 80000000 0 20000000
>>> +				  01000000 0 00000000 ffc00000 0 00010000>;
>>
>> No prefetchable mem space?
>
> we haven't normally provided prefetch on 85xx/86xx.. will deal with
> this later.

If you don't set up prefetchable memory regions on the PCI from
the firmware, this code is fine, sure.  It would be a good plan
to do map all BARs that say they are prefetchable in some
prefetchable PCI window, it gives a nice speed boost, even when
the kernel accesses it as simple non-cacheable space: the PCI
bridges in between can streamline loads from these areas.

In any case, the device tree should be in synch with how the
firmware set up the PCI hardware, and it seems that's what you
have now, so all is fine.


Segher
