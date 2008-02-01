Return-Path: <galak@kernel.crashing.org>
Message-Id: <FF018A8D-21AC-4F05-887B-66B99A0D444C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080201075408.GC18684@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/10] sbc8560: Add v1 device tree source for Wind River
	SBC8560 board
Date: Fri, 1 Feb 2008 08:46:32 -0600
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
	<7107e511a0f989ad55335855fa0f241f09eff52f.1201217172.git.paul.gortmaker@windriver.com>
	<20080201075408.GC18684@localhost.localdomain>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 1, 2008, at 1:54 AM, David Gibson wrote:

> On Thu, Jan 24, 2008 at 06:41:24PM -0500, Paul Gortmaker wrote:
>> This adds a v1 device tree source for the Wind River SBC8560  
>> board.  The
>> biggest difference between this and the MPC8560ADS reference platform
>> dts is the use of an external 16550 compatible UART instead of the  
>> CPM2.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> [snip]
>> +/dts-v1/;
>> +
>> +/ {
>> +	model = "SBC8560";
>> +	compatible = "SBC8560";
>
> This is not the conventional format for board-level compatible
> entries, which should generally be "vendor,model" and all in lower
> case.
>
> [snip]
>> +		enet0: ethernet@24000 {
>> +			cell-index = <0>;
>> +			device_type = "network";
>> +			model = "TSEC";
>> +			compatible = "gianfar";
>
> This looks like the old dodgy gianfar binding, and needs updating
> (mdio node will probably also need changes).
>
> [snip]
>> +	localbus@ff705000 {
>> +		compatible = "fsl,mpc8560-localbus";
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		reg = <0xff705000 0x100>;	// BRx, ORx, etc.
>> +
>> +		ranges = <
>> +			0x0 0x0 0xff800000 0x0800000	// 8MB boot flash
>> +			0x1 0x0 0xe4000000 0x4000000	// 64MB flash
>> +			0x3 0x0 0x20000000 0x4000000	// 64MB SDRAM
>> +			0x4 0x0 0x24000000 0x4000000	// 64MB SDRAM
>> +			0x5 0x0 0xfc000000 0x0c00000	// EPLD
>> +			0x6 0x0 0xe0000000 0x4000000	// 64MB flash
>> +			0x7 0x0 0x80000000 0x0200000	// ATM1,2
>> +		>;
>> +
>> +		epld@5,0 {
>
> I'm not entirely convinced on this two-level representation.  I think
> the FSL people need to get together and define a binding (or set of
> bindings) for their various chipselect style external bus bridges.

It seems reasonable if you had a FPGA off of the localbus to have a  
two level representation.  One for the localbus controller on the FSL  
part and the child to describe the FPGA.

What are you expecting beyond what we have today?  I guess I'm asking  
what's missing from the localbus nodes we have?

- k
