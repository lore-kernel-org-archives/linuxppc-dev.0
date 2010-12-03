Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7EDCB70A8
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 05:37:45 +1100 (EST)
Received: from mail96-db3 (localhost.localdomain [127.0.0.1])	by
	mail96-db3-R.bigfish.com (Postfix) with ESMTP id A4C716B0108	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2010 18:22:36 +0000 (UTC)
Received: from DB3EHSMHS012.bigfish.com (unknown [10.3.81.245])	by
	mail96-db3.bigfish.com (Postfix) with ESMTP id 6F33015A804D	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2010 18:22:36 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3IOY6s027348	for
	<linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 11:24:34 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB3IdOiw015615	for <linuxppc-dev@ozlabs.org>;
	Fri, 3 Dec 2010 12:39:24 -0600 (CST)
Message-ID: <4CF93566.1050601@freescale.com>
Date: Fri, 3 Dec 2010 12:22:30 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC
	Book-E watchdog driver
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
	<20101203180751.GA1903@zod.rchland.ibm.com>
In-Reply-To: <20101203180751.GA1903@zod.rchland.ibm.com>
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
> I'm confused why you can't use booke_wdt_enabled for the purposes of the
> device having been opened.  It seems the use of the wdt_is_active
> basically duplicates this functionalit (and oddly with the bit
> manipulation instead of just atomic_inc/dec).

Because the watchdog can be enabled even when the driver is not open.
booke_wdt_enabled is also initialized in setup_32.c.  So booke_wdt_enabled
represents the watchdog hardwre, whereas wdt_is_active represents the open
condition of /dev/watchdog.

However, now that I think about it, maybe that just causes confusion.  If the
watchdog is already running because of a command-line parameter, should we
prevent /dev/watchdog from ever being opened?  If you're okay with that, then I
can combine the two variables.

> If you were to keep this variable instead of just using
> booke_wdt_enabled, wouldn't it be more correct to have the clear_bit
> only done inside the #ifndef?  The timer is very much still active if
> NOWAYOUT is set...

In this case, yes.

-- 
Timur Tabi
Linux kernel developer at Freescale
