Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90E7467BCC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 08:27:19 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Horms <horms@verge.net.au>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Date: Tue, 18 Jul 2006 00:27:51 +0200
References: <31687.FP.7244@verge.net.au>
In-Reply-To: <31687.FP.7244@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607180027.51986.ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <chris@zankel.net>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	discuss@x86-64.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 17 July 2006 18:17, Horms wrote:
> This patch is part of an effort to unify the panic_on_oops behaviour
> across all architectures that implement it.
>
> It was pointed out to me by Andi Kleen that if an oops has occured
> in interrupt context, then calling sleep() in the oops path will only cause
> a panic, and that it would be really better for it not to be in the path at
> all.
>
> This patch removes the ssleep() call and reworks the console message
> accordinly.  I have a slght concern that the resulting console message is
> too long, feedback welcome.

Keeping the delay might be actually useful so that you can see the panic
before system reboots when reboot on panic is enabled. I would just use a loop
of mdelays(1) with touch_nmi_watchdog/touch_softirq_watchdog()s
inbetween.

-Andi
