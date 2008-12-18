Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id B70BDDDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:05:56 +1100 (EST)
Date: Thu, 18 Dec 2008 10:04:48 -0800
Subject: Re: [PATCH v2] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and
	Interrupt Info
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Stefan Roese <sr@denx.de>
Message-ID: <C56FD0C0.1386E%gerickson@nuovations.com>
In-Reply-To: <20081218175643.GB18201@yoda.jdub.homelinux.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/18/08 9:56 AM, Josh Boyer wrote:
> On Thu, Dec 18, 2008 at 09:04:23AM +0100, Stefan Roese wrote:
>> On Thursday 18 December 2008, Grant Erickson wrote:
>>> diff --git a/arch/powerpc/boot/dts/haleakala.dts
>>> b/arch/powerpc/boot/dts/haleakala.dts index 513bc43..64880ab 100644
>>> --- a/arch/powerpc/boot/dts/haleakala.dts
>>> +++ b/arch/powerpc/boot/dts/haleakala.dts
>>> @@ -89,8 +89,14 @@
>>> clock-frequency = <0>; /* Filled in by U-Boot */
>>> 
>>> SDRAM0: memory-controller {
>>> -   compatible = "ibm,sdram-405exr";
>>> +   compatible = "ibm,sdram-405exr", "ibm,sdram-4xx-ddr2";
>>> dcr-reg = <0x010 0x002>;
>>> +   #interrupt-cells = <1>;
>>> +   interrupt-parent = <&SDRAM0>;
>>> +   interrupts = <0x0 0x1>;
>>> +   interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
>>> +      /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
>>> +   interrupt-map-mask = <0xffffffff>;
>> 
>> When all interrupts are mapped the same parent, this should do as well:
>> 
>> interrupt-parent = <&UIC2>;
>> interrupts = <0x5 0x4 /* ECCDED Error */
>>      0x6 0x4>; /* ECCSEC Error */
>> 
>> Other than this:
>> 
>> Acked-by: Stefan Roese <sr@denx.de>
> 
> Yeah, I agree.  Adding an interrupt map when it's not needed is
> just complexity that doesn't need to be there.

Stefan and Josh:

>From a programmatic perspective, does the above still allow the code to
index virtual interrupt indices 0 and 1 rather than 5 and 6 when calling
irq_of_parse_and_map()?

Regards,

Grant
