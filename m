Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id E6901474D4
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 04:57:07 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so472004rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 09:57:05 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 18 Dec 2008 12:56:43 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and
	Interrupt Info
Message-ID: <20081218175643.GB18201@yoda.jdub.homelinux.org>
References: <1229563900-10447-1-git-send-email-gerickson@nuovations.com>
	<200812180904.23593.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200812180904.23593.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 09:04:23AM +0100, Stefan Roese wrote:
>On Thursday 18 December 2008, Grant Erickson wrote:
>> Added additional information for type and compatibility strings and
>> interrupt information to the SDRAM0 memory-controller device tree
>> nodes for AMCC PowerPC 405EX[r]-based boards to facilitate binding
>> with the new "ibm,sdram-4xx-ddr2" EDAC memory controller adapter driver.
>>
>> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
>> ---
>> As support in the associated EDAC adapter driver is added over time,
>> similar changes will/should be made to the DTS files for boards
>> leveraging realizations of this "ibm,sdram-4xx-ddr2" controller,
>> including the 440SP, 440SPe, 460EX, 460GT and 460SX.
>>
>> Patch v2, based on review from David Gibson, removes the 'device_type'
>> field because it is only used for legacy OpenFirmware method
>> interfaces and no such compatibility is warranted here. In addition,
>> removed address- and size-cells as this node has no children.
>>
>>  arch/powerpc/boot/dts/haleakala.dts |    8 +-
>>  arch/powerpc/boot/dts/kilauea.dts   |    8 +-
>>  arch/powerpc/boot/dts/makalu.dts    |    8 +-
>>  3 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/haleakala.dts
>> b/arch/powerpc/boot/dts/haleakala.dts index 513bc43..64880ab 100644
>> --- a/arch/powerpc/boot/dts/haleakala.dts
>> +++ b/arch/powerpc/boot/dts/haleakala.dts
>> @@ -89,8 +89,14 @@
>>  		clock-frequency = <0>; /* Filled in by U-Boot */
>>
>>  		SDRAM0: memory-controller {
>> -			compatible = "ibm,sdram-405exr";
>> +			compatible = "ibm,sdram-405exr", "ibm,sdram-4xx-ddr2";
>>  			dcr-reg = <0x010 0x002>;
>> +			#interrupt-cells = <1>;
>> +			interrupt-parent = <&SDRAM0>;
>> +			interrupts = <0x0 0x1>;
>> +			interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
>> +					 /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
>> +			interrupt-map-mask = <0xffffffff>;
>
>When all interrupts are mapped the same parent, this should do as well:
>
>			interrupt-parent = <&UIC2>;
>			interrupts = <0x5 0x4	/* ECCDED Error */
>				      0x6 0x4>; /* ECCSEC Error */
>
>Other than this:
>
>Acked-by: Stefan Roese <sr@denx.de>

Yeah, I agree.  Adding an interrupt map when it's not needed is
just complexity that doesn't need to be there.

josh
