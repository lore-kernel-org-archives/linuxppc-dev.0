Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-26.bluehost.com (outbound-mail-26.bluehost.com
	[69.89.17.191]) by ozlabs.org (Postfix) with SMTP id 39A1CDDF82
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 22:51:21 +1000 (EST)
Received: from 72.25.32.200.dynamic.dejazzd.com ([72.25.32.200]
	helo=[206.223.20.150])
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <dhlii@dlasys.net>) id 1M4aP9-0008Uw-DF
	for linuxppc-dev@ozlabs.org; Thu, 14 May 2009 06:51:19 -0600
Message-ID: <4A0C13C5.90602@dlasys.net>
Date: Thu, 14 May 2009 08:51:17 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: device trees.
References: <4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
	<20090513023614.GJ24338@yookeroo.seuss>
	<4A0A6495.2050605@dlasys.net>
	<20090513062127.GU24338@yookeroo.seuss>
	<4A0B0D4A.6000405@dlasys.net>
	<20090514030829.GI1804@yookeroo.seuss>
In-Reply-To: <20090514030829.GI1804@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>>
>> It is not THE dtb, it is A dtb. Our systems support and typically use
>> multiple FPGA bit streams.
>>     
>
> Ah, ok.  And those multiple bitstreams all inhabit the same NOR flash?
> From what I read below I'm guessing not..
>   
    In my work they virtually always do, but in clusters our cards
typically do not contain CPU's or Flash.

>
>
> Ok.  But they must be using some tool to push the bitstream into the
> board yes?  Could that same tool be made to take a bitstream+dtb
> bundle and push each piece into the right section of flash?
>   
    The entire flash is treated as a FileSystem.
    Bitstreams are written to it as files.
     When a pico card is hosted it looks like a disk to the host.
    Whne it is standalone, monitor does file reads/writes/directories,
    exeutes elf's and loads new bitstreams

>> Worse still the wrong dtb will probably mostly work. If it just failed
>> they would be more likely to grasp what they got wrong.
>>
>> I need/want the device tree welded to the bitstream. That means creating
>> it dynamically or welding it to the bitstream.
>> Anything else wil be a support nightmare.
>>     
>
> Right.  I guess it's all a question of what constitutes "welded" given
> the tool setup that's typically used by your clients.  I'm trying to
> understand enough about your system to make practical suggestions of
> how to achieve weldedness.
>   

    It is not just about a system, it is a family of systems, that are
similar but not identical.
    And are used for an extremely wide variety of purposes.
    My personal focus is Pico cards as embedded systems. That is about
1/3 of our market.
    1/3 is clusters, and 1/3 is custom systems that are designed similar
to our cards but
    are produced in volume for the specific needs of the client. These
typically do not have an OS
    and this is one of the places the spartans show up.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
