Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 368736874D
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 11:36:58 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mbuesch@freenet.de>
In-Reply-To: <200511130013.45610.mbuesch@freenet.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<1131834254.7406.43.camel@gaston>
	<200511130013.45610.mbuesch@freenet.de>
Content-Type: text/plain; charset=utf-8
Date: Sun, 13 Nov 2005 11:33:13 +1100
Message-Id: <1131841993.5504.13.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: asm/delay.h missing on powerpc (was: Re: Linuv 2.6.15-rc1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-11-13 at 00:13 +0100, Michael Buesch wrote:
> On Saturday 12 November 2005 23:24, you wrote:
> > Ìt should still work. I'm running -rc1 with "powerpc" on mine so that at
> > least works, it's possible that we broke "ppc", I'll have a look and
> > send a fix.
> 
> powerpc arch builds and runs now, but
> I have problems compiling the bcm430x driver. It includes linux/delay.h.
> linux/delay.h includes asm/delay.h, which does not exist.
> What to do now?

I suspect that building drivers out of tree doesn't work very well with
the new "merged" architecture where includes are split between asm/ppc
and asm-powerpc... You should make sure that you build the driver with
the same ARCH as the kernel, that is ARCH=powerpc at least, if we got
the Makefiles right, that should give you all the headers...

(building glibc is definitely a pain :)

Ben.
