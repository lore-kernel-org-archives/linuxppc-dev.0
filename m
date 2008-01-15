Return-Path: <galak@kernel.crashing.org>
Message-Id: <48889EEE-9F95-433C-AA0A-E96F7C17C54A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080110025622.GE17816@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 4/7] sbc8560: Add device tree source for Wind River
	SBC8560 board
Date: Tue, 15 Jan 2008 08:12:27 -0600
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
	<d10d083bafb978936975111f09669120201072ec.1199715362.git.paul.gortmaker@windriver.com>
	<20080110025622.GE17816@localhost.localdomain>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 8:56 PM, David Gibson wrote:

> On Mon, Jan 07, 2008 at 09:25:29AM -0500, Paul Gortmaker wrote:
>> This adds the device tree source for the Wind River SBC8560 board.   
>> The
>> biggest difference between this and the MPC8560ADS reference platform
>> dts is the use of an external 16550 compatible UART instead of the  
>> CPM2.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>> arch/powerpc/boot/dts/sbc8560.dts |  285 +++++++++++++++++++++++++++ 
>> ++++++++++
>
> [snip]
>> +	epld@fc000000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "localbus";
>
> This compatible doesn't look specific enough.  It should at least have
> a vendor prefix.
>
>> +		ranges = <0 fc000000 00c00000>;
>
> Typically, we've been doing these external bust controller type
> gadgets with address-cells = <2>, the first cell explicitly encoding
> the chipselect.  This gets us closer to the ideal of the device tree
> encoding only hardware information, not how the bridge controller is
> configured (although "ranges" will still have to contain configuration
> dependent information).
>
>
>> +
>> +		serial0: serial@700000 {
>> +			device_type = "serial";
>> +			compatible = "ns16550";
>> +			reg = <700000 100>;
>> +			clock-frequency = <1C2000>;
>> +			interrupts = <9 2>;
>> +			interrupt-parent = <&mpic>;
>> +		};
>> +
>> +		serial1: serial@800000 {
>> +			device_type = "serial";
>> +			compatible = "ns16550";
>> +			reg = <800000 100>;
>> +			clock-frequency = <1C2000>;
>> +			interrupts = <a 2>;
>> +			interrupt-parent = <&mpic>;
>> +		};
>> +
>> +		rtc@900000 {
>> +			compatible = "m48t59";
>> +			reg = <900000 2000>;
>> +		};
>> +	};
>> +};

Paul,

any updates here based on David's comments on how we are representing  
localbus nodes?

- k
