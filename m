Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E4EAB708B
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 06:10:35 +1100 (EST)
Received: from mail162-va3 (localhost.localdomain [127.0.0.1])	by
	mail162-va3-R.bigfish.com (Postfix) with ESMTP id 299AE12284FD	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2010 19:10:29 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.254])	by
	mail162-va3.bigfish.com (Postfix) with ESMTP id D65F219E805C	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2010 19:10:16 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3JA4LR010056	for
	<linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:10:04 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3JS7tD028725	for <linuxppc-dev@ozlabs.org>;
	Fri, 3 Dec 2010 13:28:07 -0600 (CST)
Message-ID: <4CF9408A.4030506@freescale.com>
Date: Fri, 3 Dec 2010 13:10:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC
	Book-E watchdog driver
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
	<20101203180751.GA1903@zod.rchland.ibm.com>
	<4CF93566.1050601@freescale.com>
	<20101203190556.GB1903@zod.rchland.ibm.com>
In-Reply-To: <20101203190556.GB1903@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
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

Josh Boyer wrote:
> No, you definitely want to allow something to open it.  If it's running
> and nothing opens the device and calls write, then you have no way of
> preventing the watchdog from just resetting your board every time.

Now it's my turn to go Doh!  Of course you have to be able to open the driver in
order to ping the timer.

> I had a driver for a different mechanism that would do the equivalent of
> booke_wdt_ping internally to the kernel until somthing opened the
> device.  That way you could have the watchdog active during bootup and
> allow userspace to takeover control when it was ready.  Then NOWAYOUT
> dictated what happened if the userspace process exited or died (or
> otherwise closed the device).  I'm not sure we want to do that for this
> hardware, but it does illustrate the main use of a watchdog on a number
> of boards.
> 
> I guess I don't really care either way if multiple processes have the
> device open, as long as none of them can "disable" the watchdog if
> NOWAYOUT is set.

Well, this patch takes care of that problem.

So just to be clear, do you still have any issues with my patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
