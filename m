Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24FE5B70A8
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 06:06:58 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3J2Hs3015642
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:02:17 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB3J6jDu092212
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:06:46 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB3J6ix8010959
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:06:45 -0700
Date: Fri, 3 Dec 2010 14:05:56 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to
	PowerPC Book-E watchdog driver
Message-ID: <20101203190556.GB1903@zod.rchland.ibm.com>
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
	<20101203180751.GA1903@zod.rchland.ibm.com>
	<4CF93566.1050601@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CF93566.1050601@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 03, 2010 at 12:22:30PM -0600, Timur Tabi wrote:
>Josh Boyer wrote:
>> I'm confused why you can't use booke_wdt_enabled for the purposes of the
>> device having been opened.  It seems the use of the wdt_is_active
>> basically duplicates this functionalit (and oddly with the bit
>> manipulation instead of just atomic_inc/dec).
>
>Because the watchdog can be enabled even when the driver is not open.
>booke_wdt_enabled is also initialized in setup_32.c.  So booke_wdt_enabled
>represents the watchdog hardwre, whereas wdt_is_active represents the open
>condition of /dev/watchdog.

Doh!  The big fat comment right above the variable would have told me
that had I bothered to read it.

(As an aside, the "For E500 cpus.." part of that comment also applies to
4xx.)

>However, now that I think about it, maybe that just causes confusion.  If the
>watchdog is already running because of a command-line parameter, should we
>prevent /dev/watchdog from ever being opened?  If you're okay with that, then I
>can combine the two variables.

No, you definitely want to allow something to open it.  If it's running
and nothing opens the device and calls write, then you have no way of
preventing the watchdog from just resetting your board every time.

I had a driver for a different mechanism that would do the equivalent of
booke_wdt_ping internally to the kernel until somthing opened the
device.  That way you could have the watchdog active during bootup and
allow userspace to takeover control when it was ready.  Then NOWAYOUT
dictated what happened if the userspace process exited or died (or
otherwise closed the device).  I'm not sure we want to do that for this
hardware, but it does illustrate the main use of a watchdog on a number
of boards.

I guess I don't really care either way if multiple processes have the
device open, as long as none of them can "disable" the watchdog if
NOWAYOUT is set.

>
>> If you were to keep this variable instead of just using
>> booke_wdt_enabled, wouldn't it be more correct to have the clear_bit
>> only done inside the #ifndef?  The timer is very much still active if
>> NOWAYOUT is set...
>
>In this case, yes.

ok.

josh
