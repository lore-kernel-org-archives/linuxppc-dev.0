Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 05402DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 06:34:46 +1100 (EST)
Date: Wed, 7 Mar 2007 13:34:38 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Message-ID: <20070307193438.GA30721@ld0162-tx32.am.freescale.net>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 01:19:29PM -0600, Kumar Gala wrote:
> On Mar 7, 2007, at 12:49 PM, Jon Loeliger wrote:
> > From: Zhang Wei <wei.zhang@freescale.com>
> >
> > Give more IRQ numbers for MPIC IPIs and TIMERs use.
> > Added generic RTC support for MPC8641HPCN.
> >
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> Nack.
> 
> You can't call the generic set_rtc_time from the  
> ppc_md.set_rtc_time.  Take a look at:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030440.html

set_rtc_time != rtc_set_time.  The latter is the one that goes through
the drivers/rtc stuff and needs a workqueue; the former (which this patch
uses) is in asm-generic/rtc.h, and appears to be interrupt-safe.

-Scott
