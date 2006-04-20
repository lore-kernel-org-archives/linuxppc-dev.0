Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 784D0679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 04:00:35 +1000 (EST)
Message-ID: <4447CC3B.7030000@am.sony.com>
Date: Thu, 20 Apr 2006 11:00:27 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
References: <4447C3BA.6050709@am.sony.com>
	<200604201937.10667.arnd.bergmann@de.ibm.com>
In-Reply-To: <200604201937.10667.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 20 April 2006 19:24, Geoff Levand wrote:
>> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
>> but it is defined inside "#ifdef __KERNEL__".
>> 
>> This moves the PAGE_SIZE definition outside of "#ifdef __KERNEL__".
>> 
>> From: Hiroaki Fuse
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Nack.
> 
> It's a little harder unfortunately. First of all, the patch moves
> more parts outside of __KERNEL__, like the  #include <linux/config.h>,
> which does not get installed into /usr/include/linux/.
> 
> More importantly, the page size is no longer constant on powerpc
> across kernel builds. User space relying on a fixed size is broken.
> 
> Please look into the sysconf(3) and getpagesize(2) man pages for
> how to do it correctly.
> 
> Which version of procps are you referring to anyway? This bug seems
> to have been fixed back in 2001, but maybe it got reintroduced now.
> 

Sorry, procps-2.0.14.  Seems the latest is at procps-3.2.6.  I'll
check it.

-Geoff
