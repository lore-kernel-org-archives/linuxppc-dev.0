Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D7A9B70AA
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 06:51:22 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3Jdhvh010934
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:39:43 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oB3JpDQE261826
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:51:13 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB3JpBDs032287
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:51:12 -0700
Date: Fri, 3 Dec 2010 14:50:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to
	PowerPC Book-E watchdog driver
Message-ID: <20101203195023.GD1903@zod.rchland.ibm.com>
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
	<20101203180751.GA1903@zod.rchland.ibm.com>
	<4CF93566.1050601@freescale.com>
	<20101203190556.GB1903@zod.rchland.ibm.com>
	<4CF9408A.4030506@freescale.com>
	<20101203193900.GC1903@zod.rchland.ibm.com>
	<4CF94869.4020705@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CF94869.4020705@freescale.com>
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

On Fri, Dec 03, 2010 at 01:43:37PM -0600, Timur Tabi wrote:
>Josh Boyer wrote:
>> Just the moving of the clear_bit inside the #ifndef
>> CONFIG_WATCHDOG_NOWAYOUT.
>
>If I move the clear_bit() call inside the #ifndef, then when
>CONFIG_WATCHDOG_NOWAYOUT is defined, after a process closes /dev/watchdog, no
>process will ever be able to open it again.  Are you saying that once
>wd_keepalive exits, you don't want anyone to be able to open /dev/watchdog and
>ping the timer again?

Oh, good point.  No, I don't think we want that.  So in that case:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

and sorry for the hassle.

josh
