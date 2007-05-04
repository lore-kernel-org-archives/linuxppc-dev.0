Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BF44DDDF69
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 13:13:53 +1000 (EST)
Date: Thu, 3 May 2007 22:15:15 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] powerpc: Show current speed in /proc/cpuinfo
Message-ID: <20070504031515.GA5567@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
	<200705020148.07954.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705020148.07954.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 02, 2007 at 01:48:07AM +0200, Arnd Bergmann wrote:
> On Monday 30 April 2007, Olof Johansson wrote:
> > On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> > changes. It makes sense to do the same on powerpc to keep users from
> > getting confused.
> > 
> > Change the format to three decimals, having full Hz granularity is silly
> > these days. Also specify in output if it's cpufreq or firmware-reported:
> > 
> > clock ? ? ? ? ? : 1250.000MHz (from firmware)
> > or:
> > clock ? ? ? ? ? : 2500.000MHz (actual speed)
> 
> 
> Good idea, but I'd be _very_ careful with changing any field in
> /proc/cpuinfo. Having the extra text in there can easily confuse
> parsers in poorly written user applications, maybe even in good ones ;-)
> 
> How about rather adding a new line in there for one of the fields, either

Yeah, good point. Actually, taking away the extra decimals is maybe a
bad idea as well.

I'll settle for clock/current-clock. See patch posted separately.


Thanks,

Olof
