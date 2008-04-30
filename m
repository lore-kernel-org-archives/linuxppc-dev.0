Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 178F7DDF5C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 03:26:58 +1000 (EST)
Message-ID: <4818ABDD.2010608@grandegger.com>
Date: Wed, 30 Apr 2008 19:26:53 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 6/6] [POWERPC] booting-without-of: add FHCI USB, FSL	MCU,
	FSL UPM and GPIO LEDs bindings
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190057.GF21203@polina.dev.rtsoft.ru>
	<48182FA6.5010900@grandegger.com>
	<20080430111656.GA14148@polina.dev.rtsoft.ru>
	<481871E9.5000101@grandegger.com>
	<20080430140742.GA789@polina.dev.rtsoft.ru>
In-Reply-To: <20080430140742.GA789@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Wed, Apr 30, 2008 at 03:19:37PM +0200, Wolfgang Grandegger wrote:
>> Anton Vorontsov wrote:
>>> On Wed, Apr 30, 2008 at 10:36:54AM +0200, Wolfgang Grandegger wrote:
>>>> Hi Anton,
>>> [...]
>>>>> +	upm@1,0 {
>>>>> +		#address-cells = <0>;
>>>>> +		#size-cells = <0>;
>>>>> +		compatible = "fsl,upm-nand";
>>>>> +		reg = <1 0 1>;
>>>>> +		fsl,upm-addr-offset = <16>;
>>>>> +		fsl,upm-cmd-offset = <8>;
>>>>> +		gpios = <&qe_pio_e 18 0>;
>>>>> +
>>>>> +		flash {
>>>>> +			#address-cells = <1>;
>>>>> +			#size-cells = <1>;
>>>>> +			compatible = "stmicro,NAND512W3A2BN6E";
>>>>> +
>>>>> +			partition@0 {
>>>>> +				...
>>>>> +			};
>>>>> +		};
>>>>> +	};
>>>> Where can I find the code for that binding? fsl_upm_nand.c from
>>>> http://patchwork.ozlabs.org/linuxppc/patch?q=upm&id=17306 does not parse
>>>> OF partitions. Are there any plans to push the fsl_upm_nand driver
>>>> upstream?
>>> David already pushed UPM NAND driver upstream, but true, it was an "old"
>>> version, i.e. without approved bindings. I'll send the update (inlining
>>> here) if/when these bindings will be applied to the powerpc tree.
>> OK, thanks a lot.
>>
>>> - - - -
>>> From: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> Subject: [NAND] update FSL UPM NAND driver for the new OF bindings
>>>
>>> - get rid of fsl,wait-pattern and fsl,wait-write. I think this isn't
>>>   chip-specific, and we should always do waits. I saw one board that
>>>   didn't need fsl,wait-pattern, but I assume it was exception that
>>>   proves general rule;
>>> - get rid of chip-delay. Today there are no users for this, and if
>>>   anyone really need this they should push the OF bindings beforehand;
>>> - Now flash chips should be child nodes of the FSL UPM nand controller;
>>> - Implement OF partition parsing.
>> On what hardware did you test the NAND-UPM driver? Unfortunately, the
>> TQM8548 does not support the R/B pin and therefore GPIO support is not
>> needed but a chip delay. Furthermore some "asm sync" are required when
>> executing the run pattern:
> 
> Too bad you need this. Oh well, you need to discuss property name with
> the OF guys, or think out some other way to deliver the chip delay
> value.

OK.

>>   static inline int fsl_upm_run_pattern(struct fsl_upm *upm,
>>                                         void __iomem *io_base, u32 mar)
>>   {
>>         int ret = 0, i;
>>         unsigned long flags;
>>
>>         spin_lock_irqsave(&fsl_lbc_lock, flags);
>>
>>         out_be32(&fsl_lbc_regs->mar, mar << (32 - upm->width));
>>
>>         asm("sync; isync; msync");
>>
>>         switch (upm->width) {
>>         case 8:
>>                 out_8(io_base, 0x0);
>>                 break;
>>         case 16:
>>                 out_be16(io_base, 0x0);
>>                 break;
>>         case 32:
>>                 out_be32(io_base, 0x0);
>>                 break;
>>         default:
>>                 ret = -EINVAL;
>>                 break;
>>         }
>>
>>         asm("sync; isync; msync");
>>
>>         spin_unlock_irqrestore(&fsl_lbc_lock, flags);
>>
>>         return ret;
>>   }
>>
>>
>> Is this a known problem with the MPC85xx? How do we handle it?
> 
> I did test this driver on MPC8555 and MPC8360 UPMs. They didn't need
> these syncs.. quite suspicious syncs, I must say. Maybe you should
> check TLB setup, for the UPM NAND it should be non-cacheable and
> guarded, IIRC.

I have that. Are you sure about the e500 CPUs. I have not seen any
MPC85xx board in U-Boot or Linux BSP using FSL UPM. Sometimes these
magic sync instructions seem to be needed, e.g., in the MPC8548 manual I
find:

  "Also, an msync assembly instruction must be executed after each I2C
   register read/write access to guarantee in-order execution."

Can somebody (from freescale?) sched some light on that issue?

TIA.

Wolfgang.
