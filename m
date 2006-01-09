Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9710568A1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 23:39:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 9 Jan 2006 12:39:20 +0000
References: <1CFEB358338412458B21FAA0D78FE86D042A2F4E@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D042A2F4E@rennsmail02.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601091239.21412.arnd@arndb.de>
Subject: Re: io.h question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 09 January 2006 12:16, Fillod Stephane wrote:
> You may not include the file directly from a user-land application
> program, but you may copy/paste the in_*/out_* macros, with appropriate 
> care off course.

Yes, that happens to work on some architectures, but it makes your program
not portable. Also, on some architectures you need special privileges,
e.g. i386 requires you to call iopl() first.
 
> >The correct way to solve your problem (which you did not explain, so
> >I can only guess) would be to write a kernel device driver for
> >the peripherial you want to drive, at least if it does not exist yet.
> 
> Sometimes, user-land access can make things simpler. YMMV.

Yes, that's true. I that's why I said I was only guessing ;-).
But even if I want to do the access from user space, I would
normally write a small device driver that exposes the registers
as an mmappable character device.

> >For prototyping, you can play with mmap() on /dev/mem in a user
> >application, but that is often not very reliable.
> 
> For sake of curiosity, what is not reliable in mmap'ed access
> by user application?

- Depending on your device, you may not be able to guarantee the
  correct timing for accessing the device.
- Some devices require locking to ensure you are accessing the
  registers in the right order. This breaks if you accidentally
  run your user space program more than once at a time.
- If the hardware changes with a later revision, you need to change
  your user space programs. Such changes ought to be hidden in the
  kernel.
- If your program is buggy, you might end up writing to a different
  device or memory location, which is very hard to debug.

	Arnd <><
