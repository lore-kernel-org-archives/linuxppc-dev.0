Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BDF26DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 10:18:59 +1000 (EST)
Message-ID: <4653886A.30800@am.sony.com>
Date: Tue, 22 May 2007 17:18:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [RFC] BOOKE watchdog and kexec
References: <46538264.2050000@mvista.com>
In-Reply-To: <46538264.2050000@mvista.com>
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

Dave Jiang wrote:
> What would be the appropriate way to deal with the BOOKE watchdog in order to
> properly kexec? The BOOKE watchdog cannot be disabled. With the current
> implementation, a watchdog daemon in userland is required to poke the
> /dev/watchdog continously in order to keep it from going off. In the kexec
> situation, the watchdog daemon in userland goes away when the new kernel is
> executed. It is very possible that the new kernel can potentially timeout on a
> certain hardware device initialization (i.e. SCSI discovery/timeout) and causes
> the watchdog to go off and reset the hardware. The reset is of course not
> wanted in this situation.

I would think the same situation exists when the bootloader loads the first
kernel.  If that works, then you should be able to use the same mechanism to
get the second kernel up.

-Geoff
