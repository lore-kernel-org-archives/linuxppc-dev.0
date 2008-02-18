Return-Path: <hjk@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91C47DDF90
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 01:03:36 +1100 (EST)
Date: Mon, 18 Feb 2008 14:09:33 +0100
From: =?UTF-8?B?SGFucy1Kw7xyZ2Vu?= Koch <hjk@linutronix.de>
To: ndroogh@cadlink.com
Subject: Re: Does anyone have a simple UIO driver that uses an interrupt
	handler?
Message-ID: <20080218140933.23812526@dilbert.local>
In-Reply-To: <47B8BF83.2070907@cadlink.com>
References: <47B8BF83.2070907@cadlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Sun, 17 Feb 2008 18:13:07 -0500
schrieb Nick Droogh <ndroogh@cadlink.com>:

> Hi everyone,

Hi Nick,

> 
> I am looking for a driver example for a user space driver utilizing
> an interrupt handler.  I am having trouble registering a handler in
> my driver attempt and would like to see an example of a working UIO
> driver.

Did you have a look at uio-howto in Documentation/DocBook/ in the
kernel sources? Just do a "make htmldocs", and you get the UIO howto in
html format in its own subdirectory.

You don't have to "register" the userspace part of an UIO driver. You
simply open /dev/uio0, mmap() your device's memory, and wait for
interrupts using a blocking read() or select() on /dev/uio0.

If you want to do it properly, you should use sysfs to find the right
UIO device (there could be others...) and the size of the memory to
map. Have a look at the sources of lsuio to see how this is done:

http://www.osadl.org/projects/downloads/UIO/user/

You find the userspace part of the uio_cif driver there, too.

If you still got problems after reading this, feel free to ask me. Note
that I'm not subscribed to linuxppc-embedded. The preferred list for
UIO questions is LKML. If you don't want to subscribe to LKML, you can
also ask me by private mail. You should ask detailed questions, ideally
accompanied by a piece of your code that shows the problem.

Thanks,
Hans
