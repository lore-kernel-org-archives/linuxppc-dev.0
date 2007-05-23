Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 85F43DDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 10:29:15 +1000 (EST)
Message-ID: <46538AE2.6010607@mvista.com>
Date: Tue, 22 May 2007 17:29:22 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC] BOOKE watchdog and kexec
References: <46538264.2050000@mvista.com> <4653886A.30800@am.sony.com>
In-Reply-To: <4653886A.30800@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Dave Jiang wrote:
>> What would be the appropriate way to deal with the BOOKE watchdog in order to
>> properly kexec? The BOOKE watchdog cannot be disabled. With the current
>> implementation, a watchdog daemon in userland is required to poke the
>> /dev/watchdog continously in order to keep it from going off. In the kexec
>> situation, the watchdog daemon in userland goes away when the new kernel is
>> executed. It is very possible that the new kernel can potentially timeout on a
>> certain hardware device initialization (i.e. SCSI discovery/timeout) and causes
>> the watchdog to go off and reset the hardware. The reset is of course not
>> wanted in this situation.
> 
> I would think the same situation exists when the bootloader loads the first
> kernel.  If that works, then you should be able to use the same mechanism to
> get the second kernel up.
> 
> -Geoff
> 

Not really. The bootloader starts from a hardware reset. The watchdog is off
from a hardware reset. The kernel driver has to specifically turn the watchdog
on either via kernel command line or by opening the watchdog device
/dev/watchdog right now. So technically this issue already exists even without
kexec. If the watchdog is turned on via kernel parameter and we hit a device
initialization timeout that takes too long, then we will get a watchdog reset.
There is a period of uncertainty between the watchdog turning on and when the
userland watchdog daemon is started with the current implementation.

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
