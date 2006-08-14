Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 202C767BC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 00:00:48 +1000 (EST)
In-Reply-To: <20060814111014.4506dc19@bob.dt.e-technik.uni-dortmund.de>
References: <31155357445643c98694.1714636915.miltonm@bga.com>
	<20060814111014.4506dc19@bob.dt.e-technik.uni-dortmund.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d81b12fdf4409d827c83f98985a96822@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
Date: Mon, 14 Aug 2006 09:00:33 -0500
To: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 14, 2006, at 4:10 AM, Benjamin Heyne wrote:

> And so it came to pass, that on Fri, 11 Aug 2006 23:37:25 -0500
> Milton Miller <miltonm@bga.com> wrote as thus:
>
>> On Mon Aug  7 2006 04:46:43 AM CDT, Benjamin Heyne wrote:
>>> Peter Korsgaard <jacmet@sunsite.dk> wrote as thus:
>>>>>>>>> "David" == David H Lynch <dhlii@dlasys.net>
>>>> David>     Have you tried 2.6.18.x to see if your stuff works with 
>>>> it
>>>
>>> Well, unfortunately I am still getting the inflate error
>>> as soon as the image grows >2MB (about). Have you tried with
>>> images of this size? If the image is smaller, everything works
>>> fine...
>>
>> I think your kernel is growing larger than
>> 4MB, which is the link address of the zImage.
>
> Well - That's exactly the case. But looking into misc-embedded.c, I 
> noticed
> that the load address for gunzip is fixed to 0x400000...shouldn't this
> be dependent on CONFIG_BOOT_LOAD_BOOL and CONFIG_BOOT_LOAD?
>
> I've changed the line to
>
> #ifdef CONFIG_BOOT_LOAD_BOOL
> 	gunzip(0, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);
> #else	
> 	gunzip(0, 0x400000, zimage_start, &zimage_size);
> #endif
>
> and now it seems to work fine for big images (if CONFIG_BOOT_LOAD
> is set large enough of course...) - which wasn't the case before.

It shouldn't depend on CONFIG_BOOT_LOAD_BOOL.   CONFIG_BOOT_LOAD is
set all the time (the question is dependent on _BOOL not the variable
and the default is used).

milton
