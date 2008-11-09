Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE481474C2
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 05:48:25 +1100 (EST)
Date: Sun, 9 Nov 2008 19:40:00 +0100
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
	[take 3]
Message-ID: <20081109194000.6bc30e0c@vitb-lp>
In-Reply-To: <Pine.LNX.4.44L0.0811030951001.2454-100000@iolanthe.rowland.org>
References: <20081103010620.46454456@vitb-lp>
	<Pine.LNX.4.44L0.0811030951001.2454-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Mon, 3 Nov 2008 09:51:55 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> пишет:

> On Mon, 3 Nov 2008, Vitaly Bordug wrote:
> 
> > A published errata for ppc440epx states, that when running Linux
> > with both EHCI and OHCI modules loaded, the EHCI module experiences
> > a fatal error when a high-speed device is connected to the USB2.0,
> > and functions normally if OHCI module is not loaded.
> > 
> > There used to be recommendation to use only hi-speed or full-speed
> > devices with specific conditions, when respective module was
> > unloaded. Later, it was observed that ohci suspend is enough to
> > keep things going, and it was turned into workaround, as explained
> > below.
> 
> Please fix this patch so that it does not cause a build error on
> non-PowerPC architectures.
Sorry for the late reply, I was travelling last week.

The latest patch was of course compile-tested with x86 and across
different powerpcs, and apparently inlined patch was not the latest one,
differing in that one little hunk. That was me confusing branches in
a hurry- big thanks for catching this.

Proper code (with explicit nop in non-ppc case) will follow right away.


-Vitaly
