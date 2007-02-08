Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 567C7DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 13:04:40 +1100 (EST)
In-Reply-To: <20070207185337.39dead9b.kim.phillips@freescale.com>
References: <20070207170602.45f9c2ee.kim.phillips@freescale.com>
	<7A666EA2-E740-42D8-9B36-1E7F6B46158F@kernel.crashing.org>
	<20070207185337.39dead9b.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F23AA6E4-9078-49F6-B0BD-03A533FEEF93@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add base support for the MPC8313E RDB
Date: Wed, 7 Feb 2007 20:03:40 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 6:53 PM, Kim Phillips wrote:

> On Wed, 7 Feb 2007 17:36:34 -0600
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On Feb 7, 2007, at 5:06 PM, Kim Phillips wrote:
>>
>>> Add support for the MPC8313E Reference Development Board (RDB).
>>> Includes dts.
>>
>> Can you give some better description about the RDB, like what
>> functionality it supports, etc..
>
> I'll respin with the details..

thanks

>>> +	soc8313@e0000000 {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		#interrupt-cells = <2>;
>>> +		device_type = "soc";
>>> +		ranges = <0 e0000000 00100000>;
>>> +		reg = <e0000000 00000200>;
>>> +		bus-frequency = <0>;
>>> +		compatible = "mpc8313\0mpc831x\0mpc83xx";
>>
>> I'm not sure what this compatible property is suppose to mean?
>>
>
> it was the part of Scott's "ioremap the entire IMMR" patch you  
> acked.  I'll take it out for now, since it should really be a part  
> of that patch.

Only acked the 'mpc8313, mpc831x' parts, not mpc83xx.
>>> +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
>>> +		usb@23000 {
>>> +			device_type = "usb";
>>> +			compatible = "fsl-usb2-dr";
>>> +			reg = <23000 1000>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			interrupt-parent = <700>;
>>> +			interrupts = <26 2>;
>>> +			phy_type = "utmi_wide";
>>
>> Does anything change because of the integrated UTMI phy?
>>
> yes, it's..
>
>>> +			control_init  = <00000280>; // UTMI ext 48 MHz clk
>>
>> What is 'control_init' ?
>>
>
> ..which selects and enables the UTMI phy interface options.

Not documented anywhere, I'd prefer a follow on patch that adds the  
doc details and code that uses it.

>>> +
>>> +		ethernet@24000 {
>>> +			device_type = "network";
>>> +			model = "TSEC";
>>
>> isn't eTSEC on 8313?
>>
> quite right, I'll change it.

ok.

- k
