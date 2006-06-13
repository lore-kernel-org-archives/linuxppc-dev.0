Return-Path: <SRS0+4b0c712caa3c71df7734+1024+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5217B67B15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 09:31:36 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17551.16830.186314.247458@cargo.ozlabs.ibm.com>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
	<17551.16830.186314.247458@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 00:31:49 +0100
Message-Id: <1150241510.11159.159.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-14 at 08:52 +1000, Paul Mackerras wrote:
> Historically the PPC32 ELF ABI has used an executable PLT, containing
> instructions constructed at runtime, located next to the BSS, and
> without the corresponding program header entry indicating execute
> permission.  Alan Modra devised a new way of doing the PLT which
> doesn't require it to be executable, but of course it is only used in
> programs that have been built since the new method went into the
> toolchain (in fact all of the .o files being linked have to have been
> compiled with the new method in order for it to be used).

'Historical' being until about 4 years ago, around the time of
http://ecos.sourceware.org/ml/binutils/2002-05/msg00097.html ?

> So if you are absolutely sure that every program you will ever want to
> run on your kernel has been built with an up-to-date toolchain, you
> can turn on enforcement of execute permissions for 32-bit processes.
> It would be a "courageous" step (in the Yes Minister sense :) for a
> distro to do it, IMHO. 

We already did it in Fedora. We don't default to READ_IMPLIES_EXEC for
32-bit processes on the 64-bit kernel.

-- 
dwmw2
