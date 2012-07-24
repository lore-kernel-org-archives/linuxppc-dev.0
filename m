Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D9502C0084
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 04:32:48 +1000 (EST)
Message-ID: <500EEA46.6030807@freescale.com>
Date: Tue, 24 Jul 2012 13:32:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500EE4C3.40707@freescale.com>
In-Reply-To: <500EE4C3.40707@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2012 01:09 PM, Timur Tabi wrote:
> Scott Wood wrote:
>> On 07/24/2012 11:42 AM, Timur Tabi wrote:
>>> +/* controller at 0x200000 */
>>> +&pci0 {
>>> +	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
>>
>> p5040 has PCIe v2.4.
> 
> Then it's broken on the SDK as well.

Yes.  There was internal discussion about this over the last few days.

>> Note that there is a version register, so perhaps we should drop the
>> version number from the compatible (and mention the version register in
>> the binding).
>>
>> Might want to double check the other version numbers in this file too.
>>
>>> +	bus-range = <0x0 0xff>;
>>
>> Do we really need this?
>>
>>> +	clock-frequency = <33333333>;
>>
>> I doubt this is accurate.
> 
> Almost all of this is copy-paste from the P5020, so if it's broken here,
> it's either broken on the P5020 or also broken on the SDK.

Now's as good a time as any to fix it.

>>> +/dts-v1/;
>>> +/ {
>>> +	compatible = "fsl,P5040";
>>
>> When would we not override this?
> 
> I don't understand.

I was wondering why we put these chip-based toplevel compatibles in the
dtsi, when we'll always overwrite it with a board-based toplevel compatible.

>>> +		spi@110000 {
>>> +			flash@0 {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <1>;
>>> +				compatible = "spansion,s25sl12801";
>>> +				reg = <0>;
>>> +				spi-max-frequency = <40000000>; /* input clock */
>>> +				partition@u-boot {
>>> +					label = "u-boot";
>>> +					reg = <0x00000000 0x00100000>;
>>> +					read-only;
>>> +				};
>>> +				partition@kernel {
>>> +					label = "kernel";
>>> +					reg = <0x00100000 0x00500000>;
>>> +					read-only;
>>> +				};
>>> +				partition@dtb {
>>> +					label = "dtb";
>>> +					reg = <0x00600000 0x00100000>;
>>> +					read-only;
>>> +				};
>>> +				partition@fs {
>>> +					label = "file system";
>>> +					reg = <0x00700000 0x00900000>;
>>> +				};
>>
>> Why are kernel/dtb read only?
> 
> Because that's how it is on the P5020!

This is a copy-and-paste meme that I've probably complained about a few
dozen times by now. :-)

>>> +#ifdef CONFIG_SMP
>>> +		/*
>>> +		 * Disable the timebase sync operations because we can't write
>>> +		 * to the timebase registers under the hypervisor.
>>> +		  */
>>> +		smp_85xx_ops.give_timebase = NULL;
>>> +		smp_85xx_ops.take_timebase = NULL;
>>> +#endif
>>
>> Why are they getting set in the first place?
> 
> This is how the structure is defined in smp.c:
> 
> struct smp_ops_t smp_85xx_ops = {
> 	.kick_cpu = smp_85xx_kick_cpu,
> #ifdef CONFIG_KEXEC
> 	.give_timebase	= smp_generic_give_timebase,
> 	.take_timebase	= smp_generic_take_timebase,
> #endif
> };
> 
> This code has not changed in years.

There was a patch to fix this, but I guess it hasn't been merged yet.

> I'm not sure what you think is wrong
> with it.

We should never be using smp_generic_take/give_timebase.  We have a
better way of synchronizing for the few cases where we need to.

-Scott
