Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 89AA5DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 02:55:42 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 6 Sep 2007 18:55:35 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
Message-ID: <20070906165535.GA11420@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 12:41:38AM +1000, Paul Mackerras wrote:
> This changes PowerPC to use the generic time infrastructure for
> gettimeofday et al.  We register a clocksource which uses the timebase
> register, or the RTC on the 601.
> 
> It also gets rid of the RTC update stuff.  IIRC we discussed removing
> this some time ago but never actually did it.

So who will be in charge of updating the RTC now? The update 
every 11 min is there to stay on x86(-64) it seems.

Removing this will have strange side effects: as an example,
your laptop clock will be good if it synchronized on NTP, 
then you put it to sleep, disconnect the network and RTC read 
on wake up returns a wrong value, giving wrong timestamps.

As someone who has a network of tens of machines using
NTP for synchornisation I think it is a very bad idea
unless we have a replacement.

	Gabriel
