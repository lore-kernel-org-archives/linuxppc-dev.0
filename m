Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDF96DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 01:02:23 +1000 (EST)
In-Reply-To: <200704131337.08029.arnd@arndb.de>
References: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
	<200704131337.08029.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A465F93F-3260-4B2E-B9FD-2D57623C61F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/7] Kconfig cleanup part II
Date: Fri, 13 Apr 2007 10:02:01 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 13, 2007, at 6:37 AM, Arnd Bergmann wrote:

> On Friday 13 April 2007, Kumar Gala wrote:
>> Here the second part of the Kconfig cleanup to move all the
>> platform/*/Kconfig to be sourced by platform/Kconfig.  Plus some  
>> other
>> minor cleanups.
>
> Nice patches, I had thought about doing these as well after
> I have cleaned up the CPU selection.
>
> Two questions though:
> - Is there a technical reason why we want to disallow building
>   a kernel that contains a combination of 6xx, 83xx, 86xx and
>   embedded6xx platforms, or are there only bugs that make it
>   impossible?

I don't believe there's anything technical just a matter of effort.   
There are a few things that need to happen before we get there.  For  
now, I figured we'd leave things as they are.

> - I'm still not sure whether platform selection or cpu selection
>   should come first, three options I can think of are:
>   1. CPU first, then platform:
>      you might choose to build a kernel for 970 exclusively, which
>      would allow you to select powermac, pseries and maple but no
>      other platforms.
>   2. Platform first, the CPU:
>      You might select pseries as the only platform, and then get
>      presented with the choice between power3 to power6, rs64
>      and 970, but not cell or pa6t.
>   3. platform and CPU depend on instruction set, but not on each  
> other,
>      You only choose between powerpc64, 4xx, 6xx, e200, e500 or 8xx.
>      This would allow nonworking setups though, like a 83xx platform
>      with a 601 cpu or a ps3 with power5 cpu.

I think the way we do it now with processor family makes the most  
sense.  I have to believe that most people using a kernel on pseries,  
iseries, pmac, etc aren't doing much kernel configuration.  However  
if your on the embedded side you most like know what processor you  
have and go from there.

- k
