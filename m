Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA251DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:34:14 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBIIXFOd025409
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 13:33:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBIIY7vh169892
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 13:34:07 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBIIXVUD001146
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 13:33:31 -0500
Date: Thu, 18 Dec 2008 13:34:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v2] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and
	Interrupt Info
Message-ID: <20081218183402.GC23637@localhost.localdomain>
References: <20081218175643.GB18201@yoda.jdub.homelinux.org>
	<C56FD0C0.1386E%gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C56FD0C0.1386E%gerickson@nuovations.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 10:04:48AM -0800, Grant Erickson wrote:
>On 12/18/08 9:56 AM, Josh Boyer wrote:
>> On Thu, Dec 18, 2008 at 09:04:23AM +0100, Stefan Roese wrote:
>>> On Thursday 18 December 2008, Grant Erickson wrote:
>>>> diff --git a/arch/powerpc/boot/dts/haleakala.dts
>>>> b/arch/powerpc/boot/dts/haleakala.dts index 513bc43..64880ab 100644
>>>> --- a/arch/powerpc/boot/dts/haleakala.dts
>>>> +++ b/arch/powerpc/boot/dts/haleakala.dts
>>>> @@ -89,8 +89,14 @@
>>>> clock-frequency = <0>; /* Filled in by U-Boot */
>>>> 
>>>> SDRAM0: memory-controller {
>>>> -   compatible = "ibm,sdram-405exr";
>>>> +   compatible = "ibm,sdram-405exr", "ibm,sdram-4xx-ddr2";
>>>> dcr-reg = <0x010 0x002>;
>>>> +   #interrupt-cells = <1>;
>>>> +   interrupt-parent = <&SDRAM0>;
>>>> +   interrupts = <0x0 0x1>;
>>>> +   interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
>>>> +      /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
>>>> +   interrupt-map-mask = <0xffffffff>;
>>> 
>>> When all interrupts are mapped the same parent, this should do as well:
>>> 
>>> interrupt-parent = <&UIC2>;
>>> interrupts = <0x5 0x4 /* ECCDED Error */
>>>      0x6 0x4>; /* ECCSEC Error */
>>> 
>>> Other than this:
>>> 
>>> Acked-by: Stefan Roese <sr@denx.de>
>> 
>> Yeah, I agree.  Adding an interrupt map when it's not needed is
>> just complexity that doesn't need to be there.
>
>Stefan and Josh:
>
>From a programmatic perspective, does the above still allow the code to
>index virtual interrupt indices 0 and 1 rather than 5 and 6 when calling
>irq_of_parse_and_map()?

Yes.  The index parameter to irq_of_parse_and_map is just an index into
the interrupts property.  So index 0 will use the first set of numbers
that matches the required #interrupt-cells.  In this case it's two, one
for the hardware irq number and one for the level/edge/polarity settings.

josh
