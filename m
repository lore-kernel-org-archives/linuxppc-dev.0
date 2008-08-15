Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (mail.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 9D441DDF21
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 06:00:42 +1000 (EST)
Subject: Re: Possible init bug in ibm_newemac/core.c
From: Darcy Watkins <dwatkins@tranzeo.com>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20080815174821.GK10829@codiert.org>
References: <1218819785.3465.190.camel@localhost>
	<20080815174821.GK10829@codiert.org>
Content-Type: text/plain
Date: Fri, 15 Aug 2008 13:00:40 -0700
Message-Id: <1218830440.3465.201.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ben,

Thanks for the pointer the the thread.  What they did was exactly what I
did (and then later reverted).  I guess my "lame hack attempt" wasn't so
lame after all.

It works fine on my "mule" board with more memory and two Ethernet
ports, but fails on the production board having less memory and only one
Ethernet port.

This probably means that I need to look into something else.

In our setup, the DTS always says two Ethernet ports.  It may be that
the failure of the probe in the case of the non-existent Ethernet port
causes the kernel panic when the order of execution of those two
functions are reversed.

Thanks again.  This gives me a few more leads to chase down.

Darcy


On Fri, 2008-08-15 at 10:48 -0700, Benjamin Krill wrote:
> Hi Darcy,
> 
> >The bug normally goes unnoticed until you turn on spinlock and/or
> >rtmutex debuggging in the kernel config - then the debugging magic
> >checks will catch it during boot.
> 
> Have a look at thread:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061631.html
> 
> cheers
>  ben
> 

-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
