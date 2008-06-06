Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26A51DE2E8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 23:59:56 +1000 (EST)
Message-Id: <A261F367-1C5F-4197-92FD-07E7AD1D21FC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <48490CF7.6050205@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2 1/4] [POWERPC] 85xx: add board support for the	TQM8548
	modules
Date: Fri, 6 Jun 2008 08:59:45 -0500
References: <4847AC75.8080405@grandegger.com>
	<71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
	<20080605225215.GF30980@yookeroo.seuss>
	<48490CF7.6050205@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2008, at 5:09 AM, Wolfgang Grandegger wrote:

> David Gibson wrote:
>> On Thu, Jun 05, 2008 at 08:43:51AM -0500, Kumar Gala wrote:
>>> On Jun 5, 2008, at 4:05 AM, Wolfgang Grandegger wrote:
>> [snip]
>>>> +			timebase-frequency = <0>;	// from U-Boot
>>>> +			bus-frequency = <0>;	// from U-Boot
>>>> +			clock-frequency = <0>;	// from U-Boot
>>> u-boot will add this for us so no need for them.
>>
>> I think it's worth including them (with the comments) for
>> documentation purposes though.  Plus allowing the bootloader and
>> bootwrapper to just replace property values without resizing or
>> inserting is somewhat worthwhile of itself.
>
> I understand your point and while testing the new blob, I realized  
> that
> the DTB image created with
>
> $ make ARCH=powerpc tqm8548.dtb
>
> does not work because work space is missing:
>
>  ## Flattened Device Tree blob at 00900000
>     Booting using the fdt blob at 0x900000
>     Loading Device Tree to 007fe000, end 007ff8e0 ... OK
>  WARNING: could not create /chosen FDT_ERR_NOSPACE.
>  ERROR: /chosen node create failed - must RESET the board to recover.
>
> As I see it, I have to define DTS_FLAGS manually
>
>  $ export DTS_FLAGS="-R4 -S0x3000"
>  $ make ARCH=powerpc tqm8548.dtb
>
> to get a working blob. Is that the intended behavior?

this is normal.  Andy Fleming has posted a patch to u-boot to help  
improve the situation.  I'm not sure if WD has picked it up for 1.3.4  
yet.

- k
