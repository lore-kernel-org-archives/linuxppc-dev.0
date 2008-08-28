Return-Path: <paul@mad-scientist.us>
Received: from smtp02.lnh.mail.rcn.net (smtp02.lnh.mail.rcn.net
	[207.172.157.102]) by ozlabs.org (Postfix) with ESMTP id 640D6DE38F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 02:02:28 +1000 (EST)
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
From: Paul Smith <paul@mad-scientist.us>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808281642.26647.arnd@arndb.de>
References: <1219928864.16802.69.camel@homebase.localnet>
	<200808281553.18167.arnd@arndb.de>
	<1219933848.16802.96.camel@homebase.localnet>
	<200808281642.26647.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 28 Aug 2008 12:01:58 -0400
Message-Id: <1219939318.16802.134.camel@homebase.localnet>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: paul@mad-scientist.us
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 16:42 +0200, Arnd Bergmann wrote:
> The trick that arch/ppc uses is to create a symlink
> arch/ppc/include/asm pointing to include/asm-powerpc and then passing
> "-Iinclude  -Iarch/ppc/include" to the compiler. This will make gcc
> look for headers in asm-ppc first, and then in asm-powerpc.
> 
> It should also work with external modules if you build them in the
> recommended way (see http://lwn.net/Articles/80250/),

Hrm... I do build that way (with M=...)... oh, I see.  When the kernel
build performs that trick the arch/ppc/include/asm symlink is pointing
to a fully-qualified pathname, not a relative pathname.  So, when I
export this information and use it somewhere else that link is not
pointing to anything.

Argh.  Well, at least that's something I can fix.  Thanks for the info;
I'll let you know how it goes.

> but as I said, the easiest way is to just build all modules as part of
> the regular kernel build.

It's not really a very easy way in our environment.  We're not primarily
in the business of building the Linux kernel; it's a very small part.
Most of our work is in userspace, and we have a very significant (and
bizarre) build environment there.  I definitely cannot change THAT, at
this point.  We build an initrd once in a blue moon, with a kernel,
busybox, and basic, very static facilities.  Then, we check in the
initrd to our source code control system and almost everyone just uses
that image; they never need to build a kernel or initrd etc. themselves.
However, some of our kernel modules do change pretty frequently and are
much more tightly tied to our userspace stuff, so if we tried to put
them into the kernel tree it would be constantly changing and it would
be a mess; we need to keep those in our normal source code control area
along with our other code.  So, I create a kernel sysroot kit and check
that in with the initrd, then unpack it to build the kernel modules.

Plus, we're using a development environment provided by WindRiver so the
build model for the kernel/initrd is that what we check in is a
compressed tarball with the basic kernel sources, plus a series of
patches; these are unpacked/applied when you build the initrd (kind of
like a Red Hat SRPM).  This kind of "development by patches" is just not
feasible for anything that is continuously updated (IMO).  If we were
fully invested in the entire kernel development model, with git for
source code control etc., then things would be simpler (for this
anyway).  But that's not how we're doing things.

It's not a licensing thing: it's a development model thing.
