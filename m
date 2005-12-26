Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25E9D68936
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Dec 2005 16:46:58 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200512252304.32830.dtor_core@ameritech.net>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 16:46:36 +1100
Message-Id: <1135575997.14160.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-12-25 at 23:04 -0500, Dmitry Torokhov wrote:
> On Sunday 25 December 2005 16:20, Michael Hanselmann wrote:
> > This patch adds a basic input hook support to usbhid because the quirks
> > method is outrunning the available bits. A hook for the Fn and Numlock
> > keys on Apple PowerBooks is included.
> 
> Well, we have used 11 out of 32 available bits so there still some
> reserves. My concern is that your implementation allows only one
> hook to be installed while with quirks you can have several of them
> active per device.

I haven't looked at the details so I can't comment much there, though
the hook has the interest of making it possible to have it in a module
that gets separately loaded if necessary, no ? Maybe the driver could
maintain a list of hooks ?

> As far as the hook itself - i have that feeling that it should not be
> done in kernel but via a keymap.

While I understand your feeling, it's a bit annoying in this specific
case because previous models did this in hardware and all mac keymaps
already account for that. Knowing how nasty it has been to get mac
keymaps updated and in a good shape, and to get distros to properly get
them, it makes a lot of sense to have this small hook in the kernel that
makes the USB keyboard behave exactly like the older ADB couterparts.

Ben.
