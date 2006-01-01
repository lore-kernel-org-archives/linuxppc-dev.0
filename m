Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4A2E68968
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Jan 2006 13:56:21 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20051231235124.GA18506@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 13:56:47 +1100
Message-Id: <1136084207.4635.86.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
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

On Sun, 2006-01-01 at 00:51 +0100, Michael Hanselmann wrote:
> On Sun, Dec 25, 2005 at 11:04:30PM -0500, Dmitry Torokhov wrote:
> > Well, we have used 11 out of 32 available bits so there still some
> > reserves. My concern is that your implementation allows only one
> > hook to be installed while with quirks you can have several of them
> > active per device.
> 
> Below you find an implementation using quirks:

I've been using the other patch for some time now and while it's a
life-saver, it does have one annoying little issue: If you press a key
with the Fn key down and release that key with the Fn key up, your key
is stuck. That is, the patch changes the keycode for Up & Down events
separately based on the Fn state at the time of the event.

What should be done is that when you release a key, you send the key up
with the keycode that matches the Fn state at the time the key was
pressed. That can easily be done using a simple bitmap that keeps track
of the Fn state on keydown for the various keycodes.

Ben.
  
