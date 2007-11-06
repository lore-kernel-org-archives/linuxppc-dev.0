Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 2C83FDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 06:51:00 +1100 (EST)
Message-ID: <4730C595.4040707@semihalf.com>
Date: Tue, 06 Nov 2007 20:50:45 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 06/12] [POWERPC] TQM5200 DTS
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235247.31906.76777.stgit@hekate.izotz.org>
	<20071105004739.GG19867@localhost.localdomain>
In-Reply-To: <20071105004739.GG19867@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Sun, Nov 04, 2007 at 12:52:47AM +0100, Marian Balakowicz wrote:
>> Add device tree source file for TQM5200 board.
> [snip]
>> +	soc5200@f0000000 {
> 
> soc@address is the new convention, I believe, but I guess you need
> compatibility with older bootstraps.

Correct, we stick with 'soc5200' due to hardcoded paths in U-boot.

> 
>> +		model = "fsl,mpc5200";
>> +		compatible = "mpc5200";
> 
> This compatible looks bogus; it should have the "fsl," at least.

Added 'fsl,'.

> [snip]
>> +		mpc5200_pic: pic@500 {
>> +			// 5200 interrupts are encoded into two levels;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			device_type = "interrupt-controller";
> 
> No device_type here.

Removed it.

> 
>> +			compatible = "mpc5200-pic";
>> +			reg = <500 80>;
>> +		};
>> +
>> +		gpt@600 {	// General Purpose Timer
>> +			compatible = "fsl,mpc5200-gpt";
>> +			cell-index = <0>;
> 
> Ok, is this actually a suitable usage for cell-index?  It should only
> be used when the cell-index number is used to program some soc-global
> register.  It should not be used just for ordering or logical-indexing
> purposes.

Rechecked that and it's not being used anywhere. Removed.

> [snip]
>> +		serial@2000 {		// PSC1
>> +			device_type = "serial";
>> +			compatible = "mpc5200-psc-uart";
>> +			port-number = <0>;  // Logical port assignment
>> +			cell-index = <0>;
> 
> Ditto w.r.t. cell-index.

Not used, removed.

> port-number also looks bogus - the device tree should not generally
> contain logical numbering information in this manner.  How and what
> uses the port-number property?

'port-number' is used by serial driver (mpc52xx_uart.c), if present it
 assigns a device number (/dev/PSC<port-number>) for given serial port.
That allows to override default auto-numbering.

>> +		sram@8000 {
>> +			compatible = "mpc5200-sram","sram";
> 
> Uh.. is there an "sram" binding?  "sram" doesn't look specific enough
> for a compatible property.

Right, removed "sram".

Thanks,
m.
