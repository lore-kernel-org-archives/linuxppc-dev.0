Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 74B59DDE9C
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 09:47:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: Where are inb/outb macros?
Date: Sun, 7 Oct 2007 01:46:50 +0200
References: <adf480660710061347l59903ba6vf6b327db674606a9@mail.gmail.com>
	<1191704881.6414.3.camel@pasglop>
In-Reply-To: <1191704881.6414.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710070146.51140.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 06 October 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-10-07 at 00:47 +0400, Peter Lemenkov wrote:
> > Hello All!
> > I can't compile one small software title because of lack <sys/io.h>
> > and inb/outb macros. What sould I do to overcome this obstacle?
> > 
> > My linux distro is Fedora 7 if it is matter.
> 
> They don't exist in user space on non-x86. You have to do things
> differently. What is your software trying to do ? If it's trying to
> access a PCI device IO space, you probably want to mmap it in sysfs and
> write your own accessors with appropriate memory barriers.

All cases where I've seen application software use <sys/io.h>, there was
actually a full device driver in the kernel that already exported a 
high-level interface to user space. If that's the case here, the application
should use that instead of sysfs.

	Arnd <><
