Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <d16e868937a1f77cbf080754f5742ad9@bga.com>
References: <20070905192116.GH32113@ld0162-tx32.am.freescale.net>,
	<20070907005803.GJ26079@localhost.localdomain>
	<d16e868937a1f77cbf080754f5742ad9@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <43ccd497fa7fa1f647ea2e3ca8168793@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Date: Mon, 10 Sep 2007 23:17:00 +0200
To: Milton Miller <miltonm@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +static inline void disable_irq(void)
>>> +{
>>> +       int dummy;
>>> +       asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0"
>>> :
>>> +                    "=r" (dummy) : : "memory");
>>> +}
>
> This will fail (mtmsr illegal instruction) on 64 bit processors that do
> not implement the bridge facility (POWER4, 5, 6, PPC970, ...)

The latest ISA lists mtmsr as non-optional, not part of the bridge
facility.  That suggests that all CPUs do in fact implement it.

970 does implement the 64-bit bridge facility, btw (well, "most of it").


Segher
