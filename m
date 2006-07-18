Return-Path: <horms@betty.vergenet.net>
Received: from betty.vergenet.net (betty.vergenet.net [64.85.198.114])
	by ozlabs.org (Postfix) with ESMTP id BECC467A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 05:57:07 +1000 (EST)
Date: Tue, 18 Jul 2006 15:13:48 -0400
From: Horms <horms@verge.net.au>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Message-ID: <20060718191345.GE20141@verge.net.au>
References: <31687.FP.7244@verge.net.au> <200607180027.51986.ak@suse.de>
	<20060717231056.GC12463@verge.net.au>
	<20060717172341.6d49f109.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060717172341.6d49f109.akpm@osdl.org>
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

On Mon, Jul 17, 2006 at 05:23:41PM -0700, Andrew Morton wrote:
> On Mon, 17 Jul 2006 19:10:59 -0400
> Horms <horms@verge.net.au> wrote:
> 
> > On Tue, Jul 18, 2006 at 12:27:51AM +0200, Andi Kleen wrote:
> > > On Monday 17 July 2006 18:17, Horms wrote:
> > > ...
> > > Keeping the delay might be actually useful so that you can see the panic
> > > before system reboots when reboot on panic is enabled. I would just use a loop
> > > of mdelays(1) with touch_nmi_watchdog/touch_softirq_watchdog()s
> > > inbetween.
> > 
> > Ok, I will look into making that happen. I agree that the pause is
> > quite useful.
> 
> It's kind-of already implemented, via pause_on_oops.  Perhaps doing
> something like 
> 
> 	if (panic_on_oops)
> 		pause_on_oops = max(pause_on_oops, 5*HZ);
> 
> would be sufficient.

Thanks, that may well be sufficient. And I assume that it is nicely out
of the arch-dependant code in die(). I will poke around a bit more.

-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
