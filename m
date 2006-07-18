Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B512667BAC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 10:24:24 +1000 (EST)
Date: Mon, 17 Jul 2006 17:23:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Horms <horms@verge.net.au>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Message-Id: <20060717172341.6d49f109.akpm@osdl.org>
In-Reply-To: <20060717231056.GC12463@verge.net.au>
References: <31687.FP.7244@verge.net.au> <200607180027.51986.ak@suse.de>
	<20060717231056.GC12463@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: chris@zankel.net, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	discuss@x86-64.org, ak@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Jul 2006 19:10:59 -0400
Horms <horms@verge.net.au> wrote:

> On Tue, Jul 18, 2006 at 12:27:51AM +0200, Andi Kleen wrote:
> > On Monday 17 July 2006 18:17, Horms wrote:
> > ...
> > Keeping the delay might be actually useful so that you can see the panic
> > before system reboots when reboot on panic is enabled. I would just use a loop
> > of mdelays(1) with touch_nmi_watchdog/touch_softirq_watchdog()s
> > inbetween.
> 
> Ok, I will look into making that happen. I agree that the pause is
> quite useful.

It's kind-of already implemented, via pause_on_oops.  Perhaps doing
something like 

	if (panic_on_oops)
		pause_on_oops = max(pause_on_oops, 5*HZ);

would be sufficient.
