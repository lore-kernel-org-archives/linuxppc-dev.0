Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31DC368732
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 09:29:15 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mbuesch@freenet.de>
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 09:25:35 +1100
Message-Id: <1131834336.7406.46.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-11-12 at 22:37 +0100, Michael Buesch wrote:
> On Saturday 12 November 2005 22:00, you wrote:
> > 
> > On Sat, 12 Nov 2005, Michael Buesch wrote:
> > > 
> > > Latest GIT tree does not boot on my G4 PowerBook.
> > 
> > What happens if you do
> > 
> > 	make ARCH=powerpc
> > 
> > and build everything that way (including the "config" phase)?
> 
> I did
> make mrproper
> copy the .config over again
> make ARCH=powerpc menuconfig
> exit and save from menuconfig
> make ARCH=powerpc

You need to disable PREP support when building with ARCH=powerpc for 32
bits, it doesn't build (yet). We should remove it from Kconfig...

Also, there is an issue with the make clean stuff, make sure when
switching archs to also remove arch/powerpc/include/asm symlink before
trying to build.

Ben.
