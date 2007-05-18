Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28AF2DDEFC
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:57:44 +1000 (EST)
In-Reply-To: <20070518183140.4644ffc6@hyperion.delvare>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<8183195dad79296e3986f561bf929067@kernel.crashing.org>
	<464CADBB.9050500@freescale.com>
	<20070518172711.2db7fc92@hyperion.delvare>
	<464DCD0E.9000706@freescale.com>
	<20070518183140.4644ffc6@hyperion.delvare>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <378C4D2E-F1AA-4015-A467-218E09DFD39B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Fri, 18 May 2007 11:56:00 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: David Brownell <david-b@pacbell.net>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2007, at 11:31 AM, Jean Delvare wrote:

> On Fri, 18 May 2007 10:58:06 -0500, Scott Wood wrote:
>> Jean Delvare wrote:
>>> On Thu, 17 May 2007 14:32:11 -0500, Scott Wood wrote:
>>>
>>>> (and the
>>>> i2c code in Linux should be fixed to allow drivers to specify  
>>>> multiple
>>>> match names).
>>>
>>>
>>> Back when David proposed his new-style i2c code, I had the same
>>> objection. But we addressed the need differently. If you look at  
>>> struct
>>> i2c_board_info, you'll see two string fields, driver_name and  
>>> type. The
>>> former specifies the driver name, the second specifies the exact  
>>> device
>>> variant. For drivers which support several device variants, the
>>> platform code should fill both fields.
>>
>> But that still requires the platform to know the driver name, rather
>> than matching any driver which knows about the type.  This  
>> prevents the
>> use of OS-independent device trees (such as in Open Firmware), which
>> cannot know specific Linux driver names, without something hacky  
>> like a
>> type-to-driver table in the device tree code.
>
> Oh well, this was also the reason why I objected to David's  
> approach in
> the first place. If you dig back in the i2c list archive, you'll find
> that I was asking for exactly the same thing you do now: that each i2c
> driver would export a list of supported devices, and the i2c-core  
> would
> match a device name against that list (independent of the driver  
> name.)
> It felt more flexible, but I wondered how useful it would be in
> practice, and finally gave up and David had the last word. If you had
> shown up back then rather than now...
>
> I am not familiar with Open Firmware. How standard is it? How  
> realistic
> would it be to use their device naming in the Linux kernel? Are there
> other subsystem doing this? Are there other OSes using it, in
> particular for I2C?

OF doesn't have any particular bindings that already exist for I2C.   
If it had I might be more in favor of trying to make Linux work with it.

Here's a link to give you some idea of what bindings exist already  
for OF:

http://openbios.info/Bindings

> We have something which works now, even if that's not what you and I
> had in mind, so I don't really want to change it without solid  
> reasons.

agreed.

- k
