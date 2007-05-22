Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id BC136DE1FF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 09:53:01 +1000 (EST)
Received: from [10.50.1.77] (blade.az.mvista.com [10.50.1.77])
	by hermes.mvista.com (Postfix) with ESMTP id A6CAC1D480
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 16:53:00 -0700 (PDT)
Message-ID: <46538264.2050000@mvista.com>
Date: Tue, 22 May 2007 16:53:08 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC] BOOKE watchdog and kexec
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What would be the appropriate way to deal with the BOOKE watchdog in order to
properly kexec? The BOOKE watchdog cannot be disabled. With the current
implementation, a watchdog daemon in userland is required to poke the
/dev/watchdog continously in order to keep it from going off. In the kexec
situation, the watchdog daemon in userland goes away when the new kernel is
executed. It is very possible that the new kernel can potentially timeout on a
certain hardware device initialization (i.e. SCSI discovery/timeout) and causes
the watchdog to go off and reset the hardware. The reset is of course not
wanted in this situation.

Several solutions comes into mind:
1. Have the kernel timer poke the watchdog. This would ensure situation
described above would never happen. I think x86 does this with NMI watchdog.

2. Have the watchdog driver spawn a kernel thread to poke the watchdog at a
periodic time. Or perhaps use the delayed-work mechanism to do that.

3. Set the highest bit of the watchdog register so that it does not expire for
2^32 ticks.

IMHO, #2 seems to be a reasonable approach. Comments please?

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
