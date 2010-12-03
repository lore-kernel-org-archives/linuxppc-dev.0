Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D40EB70DF
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 06:43:47 +1100 (EST)
Received: from mail73-tx2 (localhost.localdomain [127.0.0.1])	by
	mail73-tx2-R.bigfish.com (Postfix) with ESMTP id 00C1EE104EC	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2010 19:43:44 +0000 (UTC)
Received: from TX2EHSMHS010.bigfish.com (unknown [10.9.14.246])	by
	mail73-tx2.bigfish.com (Postfix) with ESMTP id D5C251618055	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2010 19:43:42 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3Jhc84011307	for
	<linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:43:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3K1gL0005985	for <linuxppc-dev@ozlabs.org>;
	Fri, 3 Dec 2010 14:01:42 -0600 (CST)
Message-ID: <4CF94869.4020705@freescale.com>
Date: Fri, 3 Dec 2010 13:43:37 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC
	Book-E watchdog driver
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
	<20101203180751.GA1903@zod.rchland.ibm.com>
	<4CF93566.1050601@freescale.com>
	<20101203190556.GB1903@zod.rchland.ibm.com>
	<4CF9408A.4030506@freescale.com>
	<20101203193900.GC1903@zod.rchland.ibm.com>
In-Reply-To: <20101203193900.GC1903@zod.rchland.ibm.com>
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
> Just the moving of the clear_bit inside the #ifndef
> CONFIG_WATCHDOG_NOWAYOUT.

If I move the clear_bit() call inside the #ifndef, then when
CONFIG_WATCHDOG_NOWAYOUT is defined, after a process closes /dev/watchdog, no
process will ever be able to open it again.  Are you saying that once
wd_keepalive exits, you don't want anyone to be able to open /dev/watchdog and
ping the timer again?

-- 
Timur Tabi
Linux kernel developer at Freescale
