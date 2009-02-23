Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id 3ECA6DDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 03:37:37 +1100 (EST)
Message-ID: <49A2D0A3.4020108@am.sony.com>
Date: Mon, 23 Feb 2009 08:36:51 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Lock-up on PPC64
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>	<1230165163.7292.32.camel@pasglop>	<Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
	<200901051646.03654.arnd@arndb.de>
In-Reply-To: <200901051646.03654.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, malc <av1474@comtv.ru>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 01/05/2009 07:46 AM, Arnd Bergmann wrote:
> On Sunday 28 December 2008, malc wrote:
>> Now to the Christmas cheer, i've tried v2.6.28 and couldn't help but
>> notice that the problem is gone, bisecting v2.6.27 (which funnily i
>> had to mark good) to v2.6.28 (which has to be marked bad) wasn't fun
>> but eventually converged at ab598b6680f1e74c267d1547ee352f3e1e530f89
>> 
>> commit ab598b6680f1e74c267d1547ee352f3e1e530f89
>> Author: Paul Mackerras <paulus@samba.org>
>> Date:   Sun Nov 30 11:49:45 2008 +0000
>> 
>>      powerpc: Fix system calls on Cell entered with XER.SO=1
>> 
>> Now the lock-up is gone, however the code never exercises the path
>> taken during the lock-up so i guess it, at least, deserves a better
>> look by PPC64 care takers.
> 
> 
> Yes, this change was suspected to help with Mono as well, not just
> Java, because both of them use their own syscall path rather than
> going through glibc. The reason why you see the lock-up in a different
> place is because the bug manifested in getting incorrect syscall
> return codes, which probably made mono go into a normally unused
> error handling case.

Just FYI, I looked into a problem of Mono that was reported during
its build.  During the build Mono itself is used, and it failed due
to lack of memory.  Mono kept using more and more memory until all
was consumed.  I didn't look at why, I just saw it with the Gnome
system monitor.

-Geoff
