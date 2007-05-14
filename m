Return-Path: <SRS0+82eb8e4b0001a5351ca7+1359+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9208DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:07:01 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Wire up some more syscalls
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B31879C1-6E28-45F5-8253-466785183E41@kernel.crashing.org>
References: <20070514135033.07c1b840.sfr@canb.auug.org.au>
	<1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
	<1179116138.18580.2.camel@shinybook.infradead.org>
	<B31879C1-6E28-45F5-8253-466785183E41@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 22:06:51 +0800
Message-Id: <1179151611.3482.15.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 08:58 -0500, Kumar Gala wrote:
> The COMPAT I get, but what does it mean to be able to use a syscall  
> on SPU natively?  When wouldn't you be able to do this? 

There is no native vs. compat on the SPU. The COMPAT_ bit refers only to
32-bit or 64-bit processes on the PPU. 

However, there are some system calls which the SPU may execute, and
other system calls which it may not (usually those involving signals).

Looking back at it, I'm not entirely sure the above description is
actually going to help your confusion... I recommend just looking at the
places that systbl.h is included, and what the macros expand to in each
case.

-- 
dwmw2
