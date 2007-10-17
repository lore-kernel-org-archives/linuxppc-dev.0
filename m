Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DCDC8DDF99
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 05:15:29 +1000 (EST)
Message-ID: <47165F50.9010809@freescale.com>
Date: Wed, 17 Oct 2007 14:15:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: mpc 860 boot linux2.6.23 problem
References: <20071015233839.959F4247BB@gemini.denx.de>	<4714E44F.7030909@freescale.com>	<85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
	<47162AE7.80305@freescale.com> <47165A7E.1070206@scram.de>
In-Reply-To: <47165A7E.1070206@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> Hi Scott,
> 
>> I just pulled Wolfgang's latest u-boot tree, and I don't see any fdt 
>> or ft_ calls in cpu/mpc8xx, nor in any 8xx board that I recognize.
>>
>> I may have been unclear in that I was talking about device tree 
>> support in u-boot, not the kernel.  Obviously there's device tree 
>> support in the kernel, as evidenced by my reference to using cuImage.
>>   
> 
> Can u-boot work on dtb trees embedded in an cuImage, at all?

No.  If you want that, you need to use a normal uImage.

> How would command line arguments work without a chosen
> node?

The bad old way: argument registers and the bd_t.  The bootwrapper fills 
in /chosen/bootargs and other things based on that.

It's just for compatibility; use uImage if you can.

> I tried to boot a mpc823 using the 3 argument mboot command.
> u-boot processed the dtb and added the chosen node correctly,
> however the kernel immediately oopsed with unable to access
> virtual memory when accessing the dtb memory as this memory
> was not contained in the kernel MMU space.

Make sure your version of u-boot understands the new bindings for things 
like brg frequency, or (less preferred) set it manually in your dts.

-Scott
