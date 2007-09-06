Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 98FBDDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 17:43:15 +1000 (EST)
Message-ID: <46DFAF91.3060102@dutchspace.nl>
Date: Thu, 06 Sep 2007 09:43:13 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Problems enabling NTP on ELDK
References: <20070905184827.26859247AF@gemini.denx.de>
In-Reply-To: <20070905184827.26859247AF@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Wolfgang Denk wrote:
> In message <46DE9322.7080901@dutchspace.nl> you wrote:
>   
>> I tried enabling NTP on my embedded machine (using ELDK 4.1, ppc_85xx, 
>> kernel version 2.6.14 with Xenomai 2.3.2). After I did that I noticed 
>> that ksoftirqd/0 suddenly took almost all processor time (> 95%). What 
>> is causing this? Is there a way around this, or is this something that 
>> does not cause any problems?
>>     
>
> You probably have some poroblems in your kernel port - check the  RTC
> driver  and  related  modules like I2C etc. Of course this depends on
> the NTP configuration you use, but the only kernel interaction I  can
> think  of  that  could cause this is if you interact with the RTC. [I
> guess that normal network traffic is working fine on your board.]
>   

All other functions are working fine: no problem with network or other 
PCI devices.

I disabled all RTC and I2C devices, and the problem disappeared. After 
enabling all items one by one the cause of the problem seems to be the 
DS1375 RTC: after I enable this and start NTPD ksoftirqd goes wild 
again. I do not see any other special activity: no extra interrupts in 
/proc/interrupts, and also no other RTC related errors or messages. Also 
OpenPIC does not show any extra interrupts.
Is there a way to find out what interrupt is causing ksoftirqd to be 
triggered?

> BTW: ELDK 4.1 comes with a 2.6.19.2  kernel  -  is  there  a  special
> reason that you use such an obsoletel kernel tree?
>   

I am using an MVME3100 board together with Xenomai. This board has 
support for version 2.6.14-ppc and 2.6.20-ppc, while Xenomai/Adeos is 
supported on 2.6.14 and 2.6.19. I did not yet find time to backport the 
support to 2.6.19.

Kind regards,
    Johan Borkhuis
