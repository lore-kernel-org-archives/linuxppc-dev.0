Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27A5B67B82
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 06:56:06 +1000 (EST)
In-Reply-To: <6A1F08CA-2FAE-4BE6-82BF-30F35053483C@freescale.com>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
	<20060812001017.6186.99359.stgit@localhost.localdomain>
	<6A1F08CA-2FAE-4BE6-82BF-30F35053483C@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4EA47548-7323-4464-B088-468692AE5759@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/6] POWERPC: add support of mpc8560 eval board
Date: Thu, 17 Aug 2006 22:55:32 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +		pic@40000 {
>> +			linux,phandle = <40000>;
>> +			interrupt-controller;
>> +			#address-cells = <0>;
>> +			#interrupt-cells = <2>;
>> +			reg = <40000 20100>;
>> +			built-in;
>> +			device_type = "mpic";
>
> This is wrong.  It should be "open-pic";

Not necessarily; if not, it should have "open-pic" somewhere
in the "compatible" property though.

Best might be to have device_type = interrupt-controller,
and put "mpic,open-pic" in the "compatible" property (no
comma but a zero byte...)

Or prefix it with the name of your _exact_ interrupt controller,
even.


Segher
