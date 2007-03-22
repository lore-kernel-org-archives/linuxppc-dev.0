Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00CEADDFA8
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:41:35 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
References: <1174573524.6595.509.camel@ld0161-tx32>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <534C64AB-878B-4F35-B178-D4EDCC7B0391@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Date: Thu, 22 Mar 2007 10:40:57 -0500
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 22, 2007, at 10:32 AM, Yoder Stuart-B08248 wrote:

>
>> +		mpic: pic@40000 {
>> +			clock-frequency = <0>;
>> +			interrupt-controller;
>> +			#address-cells = <0>;
>> +			#interrupt-cells = <2>;
>> +			reg = <40000 40000>;
>> +			built-in;
>> +			compatible = "chrp,open-pic";
>> +			device_type = "open-pic";
>> +			big-endian;
>> +			interrupts = <
>> +			18 2 49 2 19 2
>> +			2a 2 2b 2 4a 1
>> +			1d 2 1e 2 22 2
>> +			23 2 24 2 28 2
>> +			>;
>> +		};
>> +	};
>> +};
>
> I think using the 'interrupts' property in this way is bad.  It's
> being used to tell the pic which interrupts belong to it.
>
> The problem is that the interrupts property is being overloaded
> and used for a completely different purpose than that which
> it was originally intended and documented.  Interrupt controllers
> should not have an interrupts property.
>
> The only reason I can see to do this is as a convenience to avoid
> walking the device tree.   The pic code should walk the device tree
> to determine the irq numbers the running core.

We could just add a flag to skip the initialization of these regs @  
mpic_init and let set_irq_type do it.

- k
