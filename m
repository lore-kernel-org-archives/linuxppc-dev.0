Return-Path: <minyard@acm.org>
Received: from rwcrmhc12.comcast.net (rwcrmhc13.comcast.net [216.148.227.118])
	by ozlabs.org (Postfix) with ESMTP id 19350683B6
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Oct 2005 01:16:53 +1000 (EST)
Message-ID: <433D557C.4020301@acm.org>
Date: Fri, 30 Sep 2005 10:10:52 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
References: <20050929183221.GA17292@i2.minyard.local>
	<20050929203647.GA6597@mag.az.mvista.com>
In-Reply-To: <20050929203647.GA6597@mag.az.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: MV64x60 watchdog timer driver updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:

>On Thu, Sep 29, 2005 at 01:32:21PM -0500, Corey Minyard wrote:
>  
>
>>James looked at an earlier version and said it was ok, and suggested
>>a few changes.  This has been tested against 2.6.14-rc2 on a Katana.
>>
>>Note that the bus_clk value from the platform information seems to
>>be in MHZ, but the actual frequency is generally 133,333,333, not
>>133,000,000.  I don't think the inaccuracy matters here, but it seems
>>a little odd.
>>    
>>
>
>Yes, it makes more sense to me to pass the actual frequency and not do
>the '* 1000000'.
>  
>
The only trouble is if  you go over 4GHZ...  Maybe it should be in KHZ 
instead of MHZ?  or 64-bits?  Or maybe we don't worry about >4GHZ busses?

Also, how would one go about changing this?  Would you need something like:

if (bus_clk < 1000)
  bus_clk *= 1000000

for backwards compatability?

>Also--I should have thought of this earlier--there should probably be a
>patch to add a default platform_data entry in arch/ppc/syslib/mv64x60.c
>and a patch for katana.c if the defaults in mv64x60.c aren't correct
>for the katana.  At least, that's how things are done now.
>  
>
I'm not sure I understand completely.  How would you go about setting 
the platform data?

Thanks,

-Corey
