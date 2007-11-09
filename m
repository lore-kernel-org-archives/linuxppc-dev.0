Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 383EFDDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 01:22:59 +1100 (EST)
Message-ID: <47346D35.1090303@semihalf.com>
Date: Fri, 09 Nov 2007 15:22:45 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 12/13] [POWERPC] Promess Motion-PRO DTS
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200634.10913.6248.stgit@hekate.izotz.org>
	<20071106224200.GE31367@localhost.localdomain>
In-Reply-To: <20071106224200.GE31367@localhost.localdomain>
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
> On Tue, Nov 06, 2007 at 09:06:34PM +0100, Marian Balakowicz wrote:
>> Add device tree source file for Motion-PRO board.
> [snip]
>> +		motionpro-statusled@660 {	// Motion-PRO status LED
>> +			compatible = "promess,motionpro-statusled";
>> +			reg = <660 10>;
>> +			interrupts = <1 f 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +			blink-delay = <64>; // 100 msec
>> +		};
>> +
>> +		motionpro-readyled@670 {	// Motion-PRO ready LED
>> +			compatible = "promess,motionpro-readyled";
>> +			reg = <670 10>;
>> +			interrupts = <1 10 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +		};
> 
> Is there actually any difference in behaviour betweeen the two LEDs?
> If not, they should probably have the same compatible value, and
> perhaps a "label" property or some such to associate them with a
> particular LED.

In fact they are identical, so I have used the same compatible
property and added label property do distinguish them.

> [snip]
>> +		spi@f00 {
>> +			device_type = "spi";
> 
> No device_type!

Removed.

>> +			compatible = "mpc5200b-spi","mpc5200-spi";
>> +			reg = <f00 20>;
>> +			interrupts = <2 d 0 2 e 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +		};
>> +
>> +		usb@1000 {
>> +			device_type = "usb-ohci-be";
> 
> Nor here.

Removed.


> [snip]
>> +		// PSC2 in spi master mode 
>> +		spi@2200 {		// PSC2
>> +			compatible = "mpc5200b-psc-spi","mpc5200-psc-spi";
>> +			cell-index = <1>;
> 
>>From your description, this is an incorrect usage of cell-index - it
> should *only* be used to index into SoC shared registers; never for
> logical numbering.

Again true, but the situation is similar to the one with the "serial"
node.

Cheers,
m.
