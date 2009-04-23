Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A16E2DDEEC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:26:34 +1000 (EST)
Date: Thu, 23 Apr 2009 21:26:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423172633.GA16375@oksana.dev.rtsoft.ru>
References: <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
	<20090423160048.GC19717@ld0162-tx32.am.freescale.net>
	<20090423165430.GA8355@oksana.dev.rtsoft.ru>
	<49F09F4A.8090506@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49F09F4A.8090506@freescale.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 12:03:06PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>> On Thu, Apr 23, 2009 at 11:00:48AM -0500, Scott Wood wrote:
>>> Even if the given change may not break the firmware, it could force an
>>> update in which a prior change breaks the firmware.
>>
>> I'm not sure I'm following here. Could you give an example?
>
[...]
> Device tree Z2 goes in kernel Y2. It 
> will break when used with u-boot X1,

This is exactly what we should try to avoid. We should not accept
any changes that might break older firmwares. That is, keep the
device tree workable with X1 and X2, by any means.

For example, if X1 looks for "/soc8323@..." name instead of
compatible entry, we'll have to live with the name forever,
but we should be free to switch Linux so that it'll use only the
"compatible" property matching.

If X1 looks for "/soc8323@..."  and X2 looks for "/soc@...", so that
Z1 and Z2 aren't compatible at all, then we're in trouble. But we're
in trouble regardless of what Linux is doing, no?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
