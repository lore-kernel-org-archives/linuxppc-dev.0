Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 2D457679FA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 22:52:19 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j45Cusrn019755
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 5 May 2005 15:56:54 +0300 (EEST)
Message-ID: <427A1361.6060005@intracom.gr>
Date: Thu, 05 May 2005 15:36:49 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <4278DDBF.8080705@ru.mvista.com> <427A01B7.9090200@intracom.gr>
	<427A1423.3040509@ru.mvista.com>
In-Reply-To: <427A1423.3040509@ru.mvista.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice support
 for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> 
>> Hi Vitaly
>>
>> Since I'm also working on this, lets try to merge our work in
>> one driver.
>>
>> A few points regarding my driver.
>>
>> 1) It currently supports both 8xx FEC, 82xx FCCs.
>> 2) It will also support SCC ENETS on both 8xx & 82xx, and
>>    FECs on coldfire's & 52xx's.
>> 3) We should treat the current MII logic as temporary since
>>    Andy Flemming has a replacement by a MII bus.
>>
>> Regarding your driver, there are a couple of things it
>> does arguably better than mine.
>>
>> 1) It has more complete platformization.
>> 2) Adjustuble ring sizes.
>>
>> And here are some gripes.
>>
>> 1) I'm not a proponent of having drivers configuring pins,
>>    clocks & other things that are properties of each specific board.
>>    I'd rather have the bootloader or the platform initialization
>>    handle it once, and have the driver just use these settings.
>>    Opinions on this matter differ however :).
>> 2) There are a number of platform defines that are not needed.
>>
>> Well, what do you think?
>>
> The idea itself sounds very good.
> So, let's, as a starting point, implement mentioned things 
> (platformization and dynamic rings) within your driver (if you don't 
> mind of course).

Please go ahead.

> More specifically, I am going to add necessary platform stuff for 82xx 
> and 8xx since we have only 8272ads and 885ads to test this on.
> 
> Firmware-only board-specific stuff configuration is a good thing, but 
> IMHO it's impossible to provide a universal bootloader configuration 
> that will meet all possible requirements, and a person should recompile 
> or even modify the firmware in such cases. That is why I included clocks 
> and etc stuff to the platform_data structure, so that in board-specific 
> headers this values could be redefined if necessary. However I'm not 
> sure about PIN setup, should it also reside in the platform_data struct, 
> or in the driver (as it is in my patch).

Granted, to do that in the bootloader is very hard.
However we can definately do that in the board setup file, like
arch/ppc/platforms/pq2ads_setup.c

In my experience it's much easier to configure these things once.
Hunting down where the driver modifies pins & clocks is a nightmare, if
you ever use a non standard configuration.

The driver however can probe for it's configuration and display it so
that we can tell what is going on.


> 
> Another thing we should change in existing code is direct cpm2_immr 
> usage - the driver should be as isolated from this as possible. Dan 
> mentioned that the stuff that will offer IOport and likewise access 
> right way is almost completed so I'm looking forward some details about 
> it from him.
> 

Yes, that's another thing that must be done; please go ahead.

Regards

Pantelis
