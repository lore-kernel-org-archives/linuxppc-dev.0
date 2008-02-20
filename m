Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B88CCDDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 23:18:21 +1100 (EST)
Date: Wed, 20 Feb 2008 15:18:18 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
Message-ID: <20080220121818.GA20836@localhost.localdomain>
References: <20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de> <1203381353.6740.59.camel@pasglop>
	<47BABD3A.7010102@anagramm.de>
	<20080219040530.7b1d115d.akpm@linux-foundation.org>
	<18363.31427.989835.105966@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <18363.31427.989835.105966@cargo.ozlabs.ibm.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 11:56:35AM +1100, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > Bizarrely, the original author of the patch (Anton) has fallen off the cc. 
> > Could whoever did that please thwap himself?
> > 
> > Anyway, my head is now officially spinning.  Did anyone actually have a
> > reason why we shouldn't proceed with Anton's patch?
> 
> I was wondering if it would be sufficient to provide alternative
> versions of fb_readl, fb_writel etc. that do byte-swapping.

This is of course viable alternative. And I was considering this, but
later I abandoned the idea: that way we'll end up doing math in the
native endianness and then converting it to the foreign. This feels
ugly in contrast when we can do the right math in the first place, per
framebuffer.

> That
> would mean that all framebuffers would have to have the same
> endianness,

Yup, another downside of changing the code to fix some narrow
problem. Plus, this means things will break if/when we'll attach
PCI video card into the MPC8360E-RDK.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
