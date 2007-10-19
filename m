Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B8D5DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:22:46 +1000 (EST)
In-Reply-To: <20071018222927.GA1475@zarina>
References: <2eed9d85d53305b2b0d6e8f8287148f7a600ad19.1192730268.git.avorontsov@ru.mvista.com>
	<20071018180104.GB16748@localhost.localdomain>
	<C2A61B74-FDB4-4571-A2F4-F0B7317FD7C7@kernel.crashing.org>
	<20071018222927.GA1475@zarina>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7D255D6-D30B-4457-898D-1FC601F35A4B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Date: Fri, 19 Oct 2007 08:23:19 -0500
To: cbou@mail.ru
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 5:29 PM, Anton Vorontsov wrote:

> On Thu, Oct 18, 2007 at 02:58:25PM -0500, Kumar Gala wrote:
> [...]
>>> +
>>> +		flash@0,0 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
>>> +			reg = <0 0 2000000>;
>>> +			bank-width = <2>;
>>> +			device-width = <1>;
>>> +
>>
>> Are you basing the partition map on something or making it up?
>> Clearly hrcw & u-boot are at fixed offsets, wondering about kernel &
>> rootfs?
>
> I'm making it up. From the brief look at the u-boot* git sources,
> there is no `flashboot` yet, thus I'm free to make this up...
>
> I've partitioned this flash based on these thoughts:
>
> 1. HRCW - whole sector, to not wear out it, plus it's impossible to
>    create just 64 bytes partition;

this makes sense.

> 2. Kernel - 2MB, should be enough for bootup kernels?

seems reasonable.

> 3. Rootfs - the rest up to...

do we need a small section for the device tree?

> 4. U-Boot at the end.

can we reorder partitions?  not sure if there is any value in having  
the things we know will always be there like hrcw & u-boot at fixed  
mtd0, mtd1, etc.

>
> I'm not saying that it's best map ever, I'm open to suggestions. ;-)
>
> * Unfortunately I didn't look at the stock Freescale u-boot, maybe
>   there was flashboot, most probably.. I'll find the CD to look this
>   up.

Yeah I have no idea what we ship w/regards to the BSPs.

- k
