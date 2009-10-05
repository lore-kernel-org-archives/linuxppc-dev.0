Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6C4BB7BB5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 05:12:21 +1100 (EST)
Date: Mon, 5 Oct 2009 13:12:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
Message-ID: <20091005181233.GA3576@loki.buserror.net>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 05, 2009 at 02:16:33PM +0200, Joakim Tjernlund wrote:
> Here are my latest code to fixup 8xx's TLB code.
> This code needs some serious testing before it
> can be commited.
> The "8xx, fault: Add some debug code to do_page_fault()" is
> purely a debug check and will be removed/disabled when
> this series appear stable.
> 
> Scott and Rex, please disregard other patches from me and
> try these out instead.

I'm not sure which tree you based this on, but I got some conflicts
in pte-8xx.h using Ben's merge branch.

After resolving the conflict, without adding tlbil_va in do_page_fault(), I
get the same stuck behavior as before.  With tlbil_va, I get this (not sure
if it's related to using the wrong base tree):

INIT: version 2.85 booting
Mounting /proc and /sys
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   173 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   174 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   175 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   176 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   177 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   178 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   179 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   180 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   181 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 24:   182 Segmentation fault      /etc/rc.d/init.d/$i $mode
dcbz: address:1, dar:30020000!
/etc/rc.d/rcS: line 37:   183 Segmentation fault      /etc/rc.d/rc.local $mode
INIT: Entering runlevel: 1
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
dcbz: address:1, dar:30020000!
INIT: Id "l1" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel

-Scott
