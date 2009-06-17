Return-Path: <daniel.ng1234@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1FB3AB7297
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 22:39:15 +1000 (EST)
Received: from mail-px0-f193.google.com (mail-px0-f193.google.com
	[209.85.216.193]) by ozlabs.org (Postfix) with ESMTP id 94B17DDDD4
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:39:14 +1000 (EST)
Received: by pxi31 with SMTP id 31so229624pxi.17
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 05:39:13 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Jun 2009 22:39:13 +1000
Message-ID: <547eba1b0906170539k46b65e08v4ba0fa0f8a4e37d7@mail.gmail.com>
Subject: Trouble porting a USB gadget serial UDC driver from 2.6.14 to 2.6.27
From: Daniel Ng <daniel.ng1234@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm having trouble porting our in-house UDC driver to 2.6.27. It
originally worked on 2.6.14 as an CDC-ACM driver. The hardware
platform is a mpc8272-based board.

I notice a lot of changes since 2.6.14. For starters, instead of the
single serial.c file, there is now f_serial.c, u_serial.c and f_acm.c.

Currently, the UDC driver in 2.6.27 seems to work if I simply plug the
USB cable in between our gadget serial Linux device and a Windows PC.
However, if I unplug, then replug the cable, the 'Out' Endpoint seems
fine, but the 'In' Endpoint doesn't seem to come up properly.

In other words, data only seems to be getting through in the direction
from the PC to the gadget serial Linux device, but not vice versa.

Is there some sort of architecture document to show how the
f_serial.c, u_serial.c and f_acm.c files all fit together? I've
searched in the Documentation directory and I've read the
usb-gadget-serial docbook document but it doesn't really tell me this.

Also, it seems that for some reason composite.c is being compiled and
used, but my CDC-ACM gadget serial driver is *not* a composite driver.
Is it possible to prevent linking with this composite driver?

Cheers,
Daniel
