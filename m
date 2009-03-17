Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A046DDF0F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 09:33:52 +1100 (EST)
Date: Wed, 18 Mar 2009 09:33:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Message-ID: <20090317223349.GA15834@yookeroo.seuss>
References: <20090316102912.10805.98764.stgit@ubuntu8041.localdomain>
	<20090316103048.10805.15368.stgit@ubuntu8041.localdomain>
	<20090317013918.GA9643@yookeroo.seuss>
	<49BF6D55.7020108@gefanuc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49BF6D55.7020108@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2009 at 09:28:53AM +0000, Martyn Welch wrote:
> David Gibson wrote:
>> On Mon, Mar 16, 2009 at 10:32:18AM +0000, Martyn Welch wrote:
>>> Support for the PPC9A VME Single Board Computer from GE Fanuc (PowerPC
>>> MPC8641D).
>>>
>>> This is the basic board support for GE Fanuc's PPC9A, a 6U single board
>>> computer, based on Freescale's MPC8641D.
>>
>> Uh.. sorry.  Should have noticed these little nitpicks the first time
>> around.
>>
>
> No problem, just a few queries.
>
>>> +	localbus@fef05000 {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <1>;
>>> +		compatible = "fsl,mpc8641-localbus", "simple-bus";
>>> +		reg = <0xfef05000 0x1000>;
>>> +		interrupts = <19 2>;
>>> +		interrupt-parent = <&mpic>;
>>> +
>>> +		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
>>> +			  1 0 0xe8000000 0x08000000	// Paged Flash 0
>>> +			  2 0 0xe0000000 0x08000000	// Paged Flash 1
>>> +			  3 0 0xfc100000 0x00020000	// NVRAM
>>> +			  4 0 0xfc000000 0x00008000	// FPGA
>>> +			  5 0 0xfc008000 0x00008000	// AFIX FPGA
>>> +			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
>>> +			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
>>> +
>>> +		/* flash@0,0 is a mirror of part of the memory in flash@1,0
>>> +		flash@0,0 {
>>> +			compatible = "cfi-flash";
>>
>> It would be nice to have the actual type of flash chips here, although
>> it's not essential.
>>
>
> Flash is a little tricky, it's paged. We haven't found a good way of dealing with this yet and as a result we currently just support the first page, which may not even match one full chip width. This is especially so for flash@0,0, which is mirrored via an FPGA, the exact region depends on some jumper settings and is access is definitely read only via this region (this region is commented out in the DTS and really there for completeness as we don't expect to ever use it or enable it from Linux and is only there to all the firmware to boot). We are currently using Spansion s29gl01gp parts, which have some tricky mechanisms for sector protection (given that the parts are paged). As a result, providing the specific chip won't be much use, if a specific driver is written for spansion flash the spansion specific mechanisms are unlikely to work.
>
> If you still want the specific chip, how about this:
>
> compatible = "spansion, s29gl01gp", "cfi-flash";

Ah, ok.  Yeah, under those circumstances I wouldn't suggest including
the flash chip type.  However, it probably would be a good idea to add
some sort of tag to the compatible so that anything that needs to be
aware of the peculiar layout can check if that's the case.

So, something like:
	compatible = "gef,ppc9a-wacky-flash-layout", "cfi-flash";

[snip]
>>> +		fpga@4,0 {
>>> +			compatible = "gef,fpga-regs";
>>
>> I don't imagine this is the only set of FPGA based control regs GE
>> Fanuc will ever make, so this should be more precise.  Including the
>> board type here is probably the way to go.
>>
>
> OK.
>
> compatible = "gef,fpga-regs-ppc9a";

Look ok.  "gef,ppc9a-fpga-regs" would perhaps be better, though it
doesn't matter that much.  Machine then device seems to be the more
common convention, at least in recent work.

>>> +			reg = <0x4 0x0 0x40>;
>>> +		};
>>> +
>>> +		wdt@4,2000 {
>>> +			compatible = "gef,fpga-wdt";
>>
>> And likewise here.
>>
>
> We only have one core that is used on all our sites current and planned boards (as far as I know). How about (idea borrowed from virtex440-ml507.dts):
>
> compatible = "gef,fpga-wdt-1.00";

I'd suggest:
	compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00";
by way of paranoia.  The idea of always listing the specific
board/SoC/whatever variant first is that if a bunch of boards have a
theoretically identical device, but one of the boards has a bug in the
implementation, it's easy to add detection/workaround code to the
driver, even if you only discover the bug some time down the road when
there's lots of boards and copies of the device tree in the field.

>>> +			reg = <0x4 0x2000 0x8>;
>>> +			interrupts = <0x1a 0x4>;
>>> +			interrupt-parent = <&gef_pic>;
>>> +		};
>>> +		/* Second watchdog available, driver currently supports one.
>>> +		wdt@4,2010 {
>>> +			compatible = "gef,fpga-wdt";
>>> +			reg = <0x4 0x2010 0x8>;
>>> +			interrupts = <0x1b 0x4>;
>>> +			interrupt-parent = <&gef_pic>;
>>> +		};
>>> +		*/
>>> +		gef_pic: pic@4,4000 {
>>> +			#interrupt-cells = <1>;
>>> +			interrupt-controller;
>>> +			compatible = "gef,fpga-pic";
>>
>> And possibly here, although in this case I imagine several boards
>> might have compatible FPGA PICs.
>
> Yes, the same design is used on all the new boards I know about. As
> with the watchdog, boards in the future may have different
> designs. Would this be acceptable?:
>
> compatible = "gef,fpga-pic-1.00";

Same comments as for the watchdog.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
