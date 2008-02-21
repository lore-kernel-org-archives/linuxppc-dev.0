Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 03FB1DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 11:01:33 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1261995uge.0
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 16:01:32 -0800 (PST)
Date: Fri, 22 Feb 2008 02:41:36 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
Message-ID: <20080221234136.GA3545@zarina>
References: <20080221194508.GA12896@localhost.localdomain>
	<47BDD587.9060206@freescale.com>
	<20080221195918.GA14636@localhost.localdomain>
	<47BDD9E2.5050007@freescale.com>
	<20080221211343.GA24786@localhost.localdomain>
	<47BDEB0A.80706@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47BDEB0A.80706@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 03:20:10PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> > On Thu, Feb 21, 2008 at 02:06:58PM -0600, Scott Wood wrote:
> >> Current u-boots don't support device trees at all on 8xx.
> > 
> > Yes, vanilla u-boots. I assume many of us use some u-boot hacks to
> > actually boot with the device tree (no, not cuboots)... ;-)
> 
> Fine, but don't expect misbehavior from out-of-tree u-boots to be used 
> as justification for the kernel ignoring device tree content. :-)

You got me wrong, maybe I wasn't clear enough: it wasn't justification of
any kind. It's was just a remark regarding u-boot still not supporting
fdt for 8xx (20 lines of code we're lazy to cleanup, write annotation
to the patch and send it ;-).

Regarding timebase issue. This issue isn't introduced by the
u-boots. It is _Linux_ code that is buggy. I'm agree that ideally we
should get timebase-frequency from the device tree, but if we'll
start getting it from inside the current code, it will look like:

...linux setups tbfreq = cpu_clk / 16...
tbfreq = of_get_property(.."timebase-frequency"..);

You see? This is illogical, error-prone, and whatnot. :-)
I agree, to fix this right way, we should:
a) fix current u-boots;
b) rework 8xx/ Linux code; and
c) rework cuboot for compatibility;

Until that happen that tiny patch is a valid bug fix, right?

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
